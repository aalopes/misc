#!/bin/bash
# Post install script
# To be run after Ubuntu 14.04 LTS installation
#
# 2015 Alexandre Lopes

## Logging
exec 2> /var/log/post_install.log # send stderr from rc.local to a log file
exec 1>&2                         # send stdout to the same log file
set -x                            # tell bash to display commands before execution

# Install packages
install_packages()
{
    echo "Installing packages ..."
    apt-get update
    
    # Official packages
    apt-get install -y automake

    apt-get -f install
}

install_packages
# edit as you please
