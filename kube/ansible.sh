#!/bin/bash

ansible vagrant -vvvv -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key $@
