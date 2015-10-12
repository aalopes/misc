## What is this?

Some files to build an automated network Ubuntu installation using iPXE.
Tested with Ubuntu 14.04.x LTS
(passible to be adapted to other Debian based distros)

Note that Ubuntu 14.04 LTS uses the standard Debian Installer together
with Canonical's Ubiquity. This means that the preseed is a bit
different from a pure Debian one.

BTW, if you're looking to do the same for Red Hat based distros, google for 
"Kickstart Installation".

===============================================================================
## Components

You will need the following components:

* iPXE built with the script.ipxe script (modified to suit your needs)
* Ubuntu Desktop 14.04.x ISO (or any other Debian based distro, provided you 
                              make the necessary modifications)
* A local repo server if your machine does not have access to the internet

===============================================================================
## ISO

You will need to decompress the ISO to your server an expose it using NFS.
To that effect the instructions in <http://ipxe.org/appnote/ubuntu_live>
suffice:

Extract the ISO into /var/nfs using, e.g., 7z -x <iso_file_name>
Add the following line to /etc/exports
 /var/nfs ip_range(ro,sync,no_wdelay,insecure_locks,no_root_squash,insecure))
where ip_range should be modified to your needs, e.g., 192.168.1.0/24.

Then restart the nfs deamon (the exact way to do it will depend on the distro
                             you are using on your server machine).

===============================================================================
## Boot

Here's a small flowchart of the boot process
(the one I used, modifications are possible)

    +---------------------------+
    |  Boot compiled iPXE image |
    |                           | 
    |                           | 
    +---------------------------+
                 |
                 |
                 |
                 |
                 V
    +---------------------------+
    | Choose installation type  |
    |                           | 
    |                           | 
    +---------------------------+
                 |
                 |
                 |
                 V 
    +---------------------------+
    |    Automatic install      |
    |   using preseed file      |
    |                           |
    +---------------------------+
                 |
                 |
                 |
                 V 
    +---------------------------+
    |      Automatic conf       |
    |     using bash script     |
    |   specified in preseed    |
    +---------------------------+
    
The pressed file is available at presseed.cfg.

===============================================================================
## Packages

If in need to obtain official Ubuntu packages (without cloning the entire
Ubuntu repos, which are huge) in order to create a local repo, you can, 
after a fresh Ubuntu installation on a machine with internet access 
(be it a virtual one or whatsohever), download packages and dependencies 
using the apt-cacher-ng software or using apt-get as:
    sudo apt-get --download-only install <package_name>

===============================================================================
## Sources

<http://ipxe.org/>
<https://wiki.debian.org/DebianInstaller/Preseed>
<https://wiki.ubuntu.com/UbiquityAutomation>
partman-auto-recipe.txt (included in the 'debian-installer' package)

===============================================================================
## Author

2015 Alexandre Lopes
