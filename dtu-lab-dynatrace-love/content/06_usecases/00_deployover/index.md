## Deployment Overview

EasyTravel Continuous Deployment 

```bash
case $h in
"12" | "06")
EASYTRAVELDEPLOYMENT="None"
;;
"01" | "07")
EASYTRAVELDEPLOYMENT="CPULoadJourneyService"
;;
"02" | "08")
EASYTRAVELDEPLOYMENT="DBSpammingAuthWithAppDeployment"
;;
"03" | "09")
EASYTRAVELDEPLOYMENT="LoginProblems"
;;
"04" | "10")
EASYTRAVELDEPLOYMENT="JourneyUpdateSlow"
;;
"05" | "11")
EASYTRAVELDEPLOYMENT="CreditCardCheckError500"
;;
esac

```
