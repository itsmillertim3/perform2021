from ruxit.api.base_plugin import RemoteBasePlugin
from ruxit.api.data import PluginProperty
from ruxit.api.exceptions import AuthException, ConfigException
import requests
import json
import time
import datetime
import math
import os
from math import ceil
import logging
from enum import Enum
from typing import Dict, Optional

logger = logging.getLogger(__name__)

# Numbers smaller than 1 cannot be different from these
host_unit_weighting = {
    "FULL_STACK": {1.6: 0.1, 4: 0.25, 8: 0.5, 16: 1.0, 32: 2.0, 48: 3.0, 64: 4.0},
    "PAAS": {1.6: 0.1, 4: 0.25, 8: 0.5, 16: 1.0, 32: 2.0, 48: 3.0, 64: 4.0},
    "INFRA_ONLY": {1.6: 0.03, 4: 0.075, 8: 0.15, 16: 0.3, 32: 0.6, 48: 0.9, 64: 1.0},
}

# Create the temp directory if it does not exist
results_dir = "/tmp"
if not os.path.exists(results_dir):
    os.mkdir(results_dir)

#self.previousHour = int(datetime.datetime.now().hour)

def _calculate_host_units(memory: float, monitoring_mode="FULL_STACK") -> float:
    """
    Calculates the host units number from the memory in bytes
    Based on the table at https://www.dynatrace.com/support/help/reference/monitoring-consumption-calculation/
    :param memory: Memory in bytes
    :param monitoring_mode: FULL_STACK, INFRA_ONLY or PAAS
    :return: The number of host units for this amount of memory
    """
    if memory <= 0:
        return 0

    mem_gigs = memory / (1024 ** 3)

    if mem_gigs > 64:
        if monitoring_mode == "FULL_STACK":
            return ceil(mem_gigs / 16)
        elif monitoring_mode == "PAAS":
            return ceil(mem_gigs / 16)
        return min(ceil(mem_gigs / 16) * 0.3, 1.0)
    else:
        for mem, hu in host_unit_weighting[monitoring_mode].items():
            if mem_gigs < mem:
                return hu

class custom_Partner_Licenses(RemoteBasePlugin):

    def initialize(self, **kwargs):
        self.url = self.config.get("url", "http://127.0.0.1:8976")
        self.company_name = self.config.get("company_name", "Internal")
        self.api_token = self.config.get("api_token", "admin")
        self.auth_header = {"Authorization": f"Api-Token {self.api_token}"}
        self.extension_iterations = 0
        self.previousHour = int(datetime.datetime.now().hour)

    def query(self, **kwargs):
        group_name = self.company_name
        topology_group = self.topology_builder.create_group(group_name, group_name)
        cluster_url = self.url + "/cmc"
        topology_group.report_property(key="Cluster_URL", value=cluster_url)
        envs = self.get_environments()
        #totalCustomers = len(customers)
        port = 80
        totalHU = 0
        totalFSHU = 0
        totalPSHU = 0
        totalIMHU = 0
        totalHosts = 0
        totalDEM = 0
        totalDDU = 0
        totalFSHosts = 0
        totalPSHosts = 0
        totalIMHosts = 0
        #clusterTotalHU = 0
        #clusterTotalFSHU = 0
        #clusterTotalIMHU = 0
        #clusterTotalHosts = 0
        if self.should_getLicenseExport():
            licenseExp = self.get_LicenseExport()
            #logger.info('The returnd data is "%s"' % licenseExp)
        else:
             licenseExp = ""
            
        if licenseExp != "":
            for licEnv in licenseExp:
                DEM = 0
                DDU = 0
                visits = 0
                mobile = 0
                sessionReplay = 0
                mobilesessionReplay = 0
                rumProperties = 0
                httpMonitor = 0
                clickpath = 0
                envIdentifier = licEnv['environmentUuid']
                if envIdentifier in envs.keys():
                    envName = envs[envIdentifier]['name']
                    env_url = self.url + "/e/" + envIdentifier
                    topology_device = topology_group.create_device(envName, envName)
                    totalEnvHU, totalEnvFSHU, totalEnvPSHU, totalEnvIMHU, totalEnvHosts, totalEnvFSHosts, totalEnvPSHosts, totalEnvIMHosts, state = self.get_environment_hosts(envIdentifier, licEnv['hostUsages'])
                    totalHosts = totalHosts + totalEnvHosts
                    totalFSHosts = totalFSHosts + totalEnvFSHosts
                    totalPSHosts = totalPSHosts + totalEnvPSHosts
                    totalIMHosts = totalIMHosts + totalEnvIMHosts
                    totalHU = totalHU + totalEnvHU
                    totalFSHU = totalFSHU + totalEnvFSHU
                    totalPSHU = totalPSHU + totalEnvPSHU
                    totalIMHU = totalIMHU + totalEnvIMHU
                    topology_device.state_metric("mode.state_9", state)
                    topology_device.absolute("licenses.total_tenant_num_hosts", totalEnvHosts)
                    topology_device.absolute("licenses.total_tenant_num_FS_hosts", totalEnvFSHosts)
                    topology_device.absolute("licenses.total_tenant_num_PS_hosts", totalEnvPSHosts)
                    topology_device.absolute("licenses.total_tenant_num_IM_hosts", totalEnvIMHosts)            
                    topology_device.report_property(key="Environment_URL", value=env_url)
                    topology_device.absolute("licenses.total_tenant_host_units", totalEnvHU)
                    topology_device.absolute("licenses.total_tenant_FS_host_units", totalEnvFSHU)
                    topology_device.absolute("licenses.total_tenant_PS_host_units", totalEnvPSHU)
                    topology_device.absolute("licenses.total_tenant_IM_host_units", totalEnvIMHU)            
                    topology_device.add_endpoint("127.0.0.1", port)
                    port += 1
                    
                    visits = int(licEnv['visits'])
                    mobile = int(licEnv['mobileSessions'])
                    sessionReplay = int(licEnv['sessionReplays'])
                    mobilesessionReplay = int(licEnv['mobileSessionReplays'])
                    if int(licEnv['totalRUMUserPropertiesUsed']) > 20:
                        rumProperties = int(licEnv['totalRUMUserPropertiesUsed'])
                    for syn in licEnv['syntheticBillingUsage']:
                        if int(syn['monitorTypeId']) == 2:
                            httpMonitor = httpMonitor + int(syn['publicExecutions']) + int(syn['privateExecutions'])
                        else:
                            clickpath = clickpath + int(syn['publicExecutions']) + int(syn['privateExecutions'])
                    DEM = ((visits + mobile) * 0.25) + ((sessionReplay + mobilesessionReplay) * 0.75) + (rumProperties * 0.01) + (httpMonitor * 0.1) + clickpath
                    totalDEM = totalDEM + DEM
                    topology_device.absolute("licenses.total_tenant_dem_units", DEM)
                    for item in licEnv['davisDataUnits']:
                        DDU = DDU + float(item['total'])
                    topology_device.absolute("licenses.total_tenant_ddus", DDU)
                    totalDDU = totalDDU + DDU    
        group_name = self.company_name + " Overall"
        topology_group = self.topology_builder.create_group(group_name, group_name)
        topology_group.report_property(key="Cluster_URL", value=cluster_url)
        topology_device = topology_group.create_device(self.company_name + " License Total", self.company_name + " License Total")
        topology_device.report_property(key="Cluster_URL", value=cluster_url)
        topology_device.absolute("licenses.total_license_hosts", totalHosts)
        topology_device.absolute("licenses.total_license_FS_hosts", totalFSHosts)
        topology_device.absolute("licenses.total_license_PS_hosts", totalPSHosts)
        topology_device.absolute("licenses.total_license_IM_hosts", totalIMHosts)
        topology_device.absolute("licenses.total_license_host_units", totalHU)
        topology_device.absolute("licenses.total_license_FS_host_units", totalFSHU)
        topology_device.absolute("licenses.total_license_PS_host_units", totalPSHU)
        topology_device.absolute("licenses.total_license_IM_host_units", totalIMHU)
        topology_device.absolute("licenses.total_license_dem_units", totalDEM)
        topology_device.absolute("licenses.total_license_ddus", totalDDU)                    
        topology_device.add_endpoint("127.0.0.1", port)

    # Get the host units per environment
    def get_environment_hosts(self, envID, hostUsages):
            
        totalEnvHosts = int(len(hostUsages))
        totalEnvFSHosts = 0
        totalEnvPSHosts = 0
        totalEnvIMHosts = 0
        totalEnvHU = 0
        totalEnvFSHU = 0
        totalEnvPSHU = 0
        totalEnvIMHU = 0
    #   print(hosts)
        for host in hostUsages:
            if not host['paas'] and not host['infrastructureOnly']:
                # Full-stack baby
                totalEnvFSHosts = totalEnvFSHosts + 1
                host_full_stack_units = _calculate_host_units(int(host['hostMemoryBytes']))
                totalEnvFSHU = totalEnvFSHU + host_full_stack_units
                totalEnvHU = totalEnvHU + host_full_stack_units
            elif host['paas']:
                # PaaS
                totalEnvPSHosts = totalEnvPSHosts + 1
                host_paas_units = _calculate_host_units(int(host['passMemoryLimit']), monitoring_mode="PAAS")
                totalEnvPSHU = totalEnvPSHU + host_paas_units
                totalEnvHU = totalEnvHU + host_paas_units
            else:
                # Infra-only
                totalEnvIMHosts = totalEnvIMHosts + 1
                host_infra_only_units = _calculate_host_units(int(host['hostMemoryBytes']), monitoring_mode="INFRA_ONLY")
                totalEnvIMHU = totalEnvIMHU + host_infra_only_units
                totalEnvHU = totalEnvHU + host_infra_only_units

        mode = ""
        if totalEnvHU > 0:
            if totalEnvIMHU == 0 and totalEnvPSHU == 0:
                mode = "FullStack"
            elif totalEnvFSHU == 0 and totalEnvPSHU == 0:
                mode = "Infrastructure"
            elif totalEnvIMHU == 0 and totalEnvFSHU == 0:
                mode = "Application-only"
            else:
                mode = "Mixed"
        else:
            mode = "Unused"
        return totalEnvHU, totalEnvFSHU, totalEnvPSHU, totalEnvIMHU, totalEnvHosts, totalEnvFSHosts, totalEnvPSHosts, totalEnvIMHosts, mode

    def get_environments(self):
        environmentsURL = f"{self.url}/api/cluster/v2/environments"
        params = {'filter': 'state(ENABLED)', 'pageSize': 1000}
        try:
            getEnvironments = requests.get(environmentsURL, headers=self.auth_header, params=params, verify=False)
            if getEnvironments.status_code == 401:
                error = getEnvironments.json()['error']['message']
                raise AuthException('Get Environments Error. Ensure your Cluster Token is correct, active and has the role ServiceProviderAPI. The message was - %s' % error)
        except requests.exceptions.ConnectTimeout as ex:
            raise ConfigException('Timeout on connecting with "%s"' % environmentsURL) from ex
        except requests.exceptions.RequestException as ex:
            raise ConfigException('Unable to connect to "%s"' % environmentsURL) from ex
        except json.JSONDecodeError as ex:
            raise ConfigException('Server response from %s is not json' % environmentsURL) from ex
        if "nextPageKey" in getEnvironments.json():
            environments = getEnvironments.json()['environments']
            nextPageKey = getEnvironments.json()['nextPageKey']
            requiredCalls = math.ceil(int(getEnvironments.json()['totalCount']) / int(getEnvironments.json()['pageSize']))
            i = 1
            while i < requiredCalls:
                if getEnvironments.json()['nextPageKey']:
                    nextPageKey = getEnvironments.json()['nextPageKey']
                params = {'nextPageKey': nextPageKey}
                try:
                    getEnvironments = requests.get(environmentsURL, headers=self.auth_header, params=params)
                    if getEnvironments.status_code == 401:
                        error = getEnvironments.json()['error']['message']
                        raise AuthException('Get Environments Error. Ensure your Cluster Token is correct, active and has the role ServiceProviderAPI. The message was - %s' % error)
                except requests.exceptions.ConnectTimeout as ex:
                    raise ConfigException('Timeout on connecting with "%s"' % environmentsURL) from ex
                except requests.exceptions.RequestException as ex:
                    raise ConfigException('Unable to connect to "%s"' % environmentsURL) from ex
                except json.JSONDecodeError as ex:
                    raise ConfigException('Server response from %s is not json' % environmentsURL) from ex
                pageDataEnvs = getEnvironments.json()['environments']
                for item in pageDataEnvs:
                    environments.append(item)
                i += 1
        else:
            environments = getEnvironments.json()['environments']

        # Convert to dict
        envDict = {}
        for e in environments:
            envDict[e['id']] = e

        return envDict

    def should_getLicenseExport(self):
        currentHour = int(datetime.datetime.now().hour)
        #logger.info('The current hour is "%s"' % currentHour)
        #logger.info('The previous hour is "%s"' % self.previousHour)
        #self.extension_iterations = self.extension_iterations + 1
        
        
        #if currentHour != self.previousHour:
            #logger.info("Current is greater trigger DEM")
        #    self.previousHour = currentHour
        #    return True
        
        
        #logger.info("Current is the same as previous")
        return True

    def get_LicenseExport(self):
        #logger.info("get_LicenseExport has been called")
        licenseExpURL = f"{self.url}/api/cluster/v2/license/consumption/hour"
        endTs = int(round(time.time() * 1000))
        endTs = int(endTs//3600000 * 3600000)
        endTs = endTs - 2*3600000
        startTs = endTs - 3600000
        params = {'startTs': startTs, 'endTs': endTs}
        logger.info('The params are "%s"' % params)
        
        try:
            getlicenseExp = requests.get(licenseExpURL, headers=self.auth_header, params=params, verify=False)
            logger.info('get_LicenseExport response code was "%s"' % getlicenseExp.status_code)
            if getlicenseExp.status_code == 401:
                error = getlicenseExp.json()['error']['message']
                raise AuthException('Get License Export Error. Ensure your Cluster Token is correct, active and has the role ServiceProviderAPI. The message was - %s' % error)
        except requests.exceptions.ConnectTimeout as ex:
            raise ConfigException('Timeout on connecting with "%s"' % licenseExpURL) from ex
        except requests.exceptions.RequestException as ex:
            raise ConfigException('Unable to connect to "%s"' % licenseExpURL) from ex
        except json.JSONDecodeError as ex:
            raise ConfigException('Server response from %s is not json' % licenseExpURL) from ex

        #logger.info('The json item is "%s"' % getlicenseExp.json()) 

        return getlicenseExp.json()['environmentBillingEntries']