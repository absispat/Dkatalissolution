#!/bin/bash

terraform init
terraform plan
terraform apply --auto-approve

ansible-galaxy install elastic.elasticsearch,7.9.1 --roles-path=.
ansible-playbook play.yaml -i hosts.ini -u root
