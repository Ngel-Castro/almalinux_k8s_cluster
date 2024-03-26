# Import YAML to help in generating a properly formatted string
import yaml
import json


def readJson():
    # Path to the 'hosts_map.json' file
    hosts_map_path = 'hosts_map.json'

    # Reading the JSON data from 'hosts_map.json' and assigning it to a variable
    with open(hosts_map_path, 'r') as json_file:
        hosts_map = json.load(json_file)
    return hosts_map




# Function to generate the YAML configuration based on the map
def generate_yaml_config():
    hosts_map = readJson()
    # Prepare the base structure
    config = {
        "all": {
            "children": {
                "alma_cluster": {
                    "children": {
                        "controller": {
                            "hosts": {}
                        },
                        "worker": {
                            "hosts": {}
                        }
                    }
                }
            }
        }
    }

    # Populate controllers
    for controller_name, ip_address in hosts_map["controllers"].items():
        config["all"]["children"]["alma_cluster"]["children"]["controller"]["hosts"][controller_name] = {
            "ansible_host": ip_address,
            "ansible_user": "{{ admin_user }}",
            "ansible_ssh_private_key_file": "{{ cluster_ssh_key }}"
        }

    # Populate workers
    for worker_name, ip_address in hosts_map["workers"].items():
        config["all"]["children"]["alma_cluster"]["children"]["worker"]["hosts"][worker_name] = {
            "ansible_host": ip_address,
            "ansible_user": "{{ admin_user }}",
            "ansible_ssh_private_key_file": "{{ cluster_ssh_key }}"
        }

    # Convert the config dictionary to a YAML formatted string
    yaml_config = yaml.dump(config, sort_keys=False)

    return yaml_config

def main():

    # Generate the YAML configuration
    yaml_config = generate_yaml_config()

    # Save the configuration to a file
    with open("ansible/inventory/alma_cluster/inventory.yml", "w") as file:
        file.write(yaml_config)

    # The above code saves the YAML configuration to 'ansible_inventory.yml' in the current directory.
