#!/bin/bash

ansible-playbook -vvvv -u phro --private-key ~/.ssh/id_brazen $@ -i 23.226.231.216,
