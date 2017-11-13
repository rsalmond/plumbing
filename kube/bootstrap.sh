#!/bin/bash

ansible vagrant -vvvv -u ubuntu --private-key .vagrant/machines/default/virtualbox/private_key --sudo -m raw -a "apt install python-minimal python-simplejson -y"
