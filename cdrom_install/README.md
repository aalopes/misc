## What is this?

Some files to build an automated network Ubuntu installation which should
boot from an optical media or an USB stick. 
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

* Ubuntu Desktop 14.04.x ISO (or any other Debian based distro, provided you 
                              make the necessary modifications)

===============================================================================
## ISO

How to set up your own ISO.

In this case, simply decompress the official Ubunt ISO somewhere using, for 
example:
  7z x filename.iso

The Ubuntu desktop installation ISO already contains a preseed which it uses in
preseeds/ubuntu.cfg. Simply replace this preseed with a custom preseed to
automatize the installation.
The ISO already comes with a repository that contains some packages. It is not
recommended that you overwrite the packages there contained, since they have
been signed by Ubuntu. 

Creating a folder with your repository and ponting the preseed to the right 
place will break apt with:
"an attempt to configure apt to install additional packages from the CD failed".
The best way is to follow the instructions in:
<http://askubuntu.com/questions/409607/how-to-create-a-customized-ubuntu-server-iso>:

  mkdir -p ./dists/stable/extras/binary-amd64 
  mkdir -p ./pool/extras
 
copy the .deb packages to ./pool/extras and then:

sudo apt-ftparchive packages ./pool/extras/ > dists/stable/extras/binary-i386/Packages
sudo gzip -c ./dists/stable/extras/binary-i386/Packages | tee ./dists/stable/extras/binary-i386/Packages.gz > /dev/null

Alternatively you can download the packages post-installation.

Note that for optical media the installation media will be mounted at /cdrom. 
For most cases, when using a USB stick it is /cdrom as well, although other 
methods of burning the ISO to the USB stick might lead to different results - 
since some of them recommend substituting isolinux by syslinux). 

If you want to have several different installation scenarios, like in the iPXE 
case, simply edit the txt.cfg file (which contains a menu), and enter different 
entries using different preseeds (an image burned with unetbootin will boot into
this menu, while images burned with other programs might boot into a graphical 
interface, bypassing this menu - this might be an isolinux/syslinux difference).

In any case after editing the ISO, the md5 hashes need to be recalculated and an 
ISO needs to be created:
    sudo rm md5sum.txt
    find -type f -print0 | sudo xargs -0 md5sum | grep -v isolinux/boot.cat | sudo tee md5sum.txt

and

    sudo mkisofs -D -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../ubuntu-14.04.02-desktop-amd64-custom.iso .


Alternatively one can use the instructions in here:
<https://help.ubuntu.com/community/LiveCDCustomization>
to really change the squashfs. This means that your live CD image will also 
contain the desired configuration.


===============================================================================
## Boot

Here's a small flowchart of the boot process
(the one I used, modifications are possible)

    +---------------------------+
    |   Boot custom ISO image   |
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
    
The preseed file is available at presseed.cfg.

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
