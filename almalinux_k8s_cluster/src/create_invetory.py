# Import YAML to help in generating a properly formatted string
import yaml
import json

# Path to the 'hosts_map.json' file
hosts_map_path = 'hosts_map.json'

# Reading the JSON data from 'hosts_map.json' and assigning it to a variable
with open(hosts_map_path, 'r') as json_file:
    hosts_map = json.load(json_file)

# Function to generate the YAML configuration based on the map
def generate_yaml_config(hosts_map):
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
            "ansible_password": "{{ cluster_password }}"
        }

    # Populate workers
    for worker_name, ip_address in hosts_map["workers"].items():
        config["all"]["children"]["alma_cluster"]["children"]["worker"]["hosts"][worker_name] = {
            "ansible_host": ip_address,
            "ansible_user": "{{ admin_user }}",
            "ansible_password": "{{ cluster_password }}"
        }

    # Convert the config dictionary to a YAML formatted string
    yaml_config = yaml.dump(config, sort_keys=False)

    return yaml_config

# Generate the YAML configuration
yaml_config = generate_yaml_config(hosts_map)

# Save the configuration to a file
with open("inventory.yml", "w") as file:
    file.write(yaml_config)

# The above code saves the YAML configuration to 'ansible_inventory.yml' in the current directory.
