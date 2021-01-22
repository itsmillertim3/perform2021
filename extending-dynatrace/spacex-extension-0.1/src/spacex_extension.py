import requests
from ruxit.api.base_plugin import RemoteBasePlugin


class SpaceXExtension(RemoteBasePlugin):

    def query(self, **kwargs):
        # Get a list of ships
        ships = self.get_ships()

        # Create groups
        # 1 - Get the unique names of the ship types
        ship_types = set([ship["ship_type"] for ship in ships])

        # 2 - Save groups in a dictionary for later use
        groups = {}
        for ship_type in ship_types:
            group_name = f"{ship_type} ships"
            groups[ship_type] = self.topology_builder.create_group(group_name, group_name)

        for ship in ships:
            self.logger.info(f"Processing ship {ship['ship_name']}")

            # Obtain the group from the dictionary we created earlier
            group = groups[ship["ship_type"]]

            # Create a custom device for each ship
            device = group.create_device(ship['ship_id'], ship['ship_name'])

            # Send an absolute metric, a metric that is stored without any extra calculation
            device.absolute("fuel", ship["fuel"])

    def get_ships(self):
        return requests.get("http://54.158.160.249/v3/ships").json()
