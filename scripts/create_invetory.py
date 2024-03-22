# Import YAML to help in generating a properly formatted string
import yaml

# Define the provided map with controller and worker IPs
hosts_map = {
    "controllers_ips": {
        "controller1": "192.168.0.1",
        "controller2": "192.168.0.2",
    },
    "workers_ips": {
        "worker1": "192.168.0.100",
        "worker2": "192.168.0.101",
    }
}

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
    for controller_name, ip_address in hosts_map["controllers_ips"].items():
        config["all"]["children"]["alma_cluster"]["children"]["controller"]["hosts"][controller_name] = {
            "ansible_host": ip_address,
            "ansible_user": "{{ admin_user }}",
            "ansible_password": "{{ cluster_password }}"
        }
        
    # Populate workers
    for worker_name, ip_address in hosts_map["workers_ips"].items():
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
with open("ansible_inventory.yml", "w") as file:
    file.write(yaml_config)

# The above code saves the YAML configuration to 'ansible_inventory.yml' in the current directory.
