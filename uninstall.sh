#!/bin/bash
echo "
 ____  _____ ____ ___    _    _   _ 
|  _ \| ____| __ )_ _|  / \  | \ | |
| | | |  _| |  _ \| |  / _ \ |  \| |
| |_| | |___| |_) | | / ___ \| |\  |
|____/|_____|____/___/_/   \_\_| \_|
                                    
 ____  _   _ ____  ____  _______     _______ _     ___  ____  _____ ____  
|  _ \| | | |  _ \|  _ \| ____\ \   / / ____| |   / _ \|  _ \| ____|  _ \ 
| |_) | |_| | |_) | | | |  _|  \ \ / /|  _| | |  | | | | |_) |  _| | |_) |
|  __/|  _  |  __/| |_| | |___  \ V / | |___| |__| |_| |  __/| |___|  _ < 
|_|   |_| |_|_|   |____/|_____|  \_/  |_____|_____\___/|_|   |_____|_| \_\
                                                                                
"
read -p "
Are you sure you want to uninstall XAMPP, Composer and Git?
1) Yes, Delete everything.
2) No, I guess that's not a good idea.

" UninstallQuestion

case $UninstallQuestion in

  1)
    
    #XAMPP, Composer Uninstall
    sudo /opt/lampp/lampp stop
    sudo rm -R /opt/lampp
    sudo rm -R /usr/share/polkit-1/actions/xampp.policy
    sudo rm -R /usr/share/applications/xampp-control-panel.desktop
    sudo rm -R /usr/bin/php
    sudo rm -R /usr/local/bin/composer

    # Git Uninstall
    sudo apt-get -y autoremove
    git config --global --unset user.name
    git config --global --unset user.email
    git config --list
    sudo apt-get -y remove git
    sudo apt-get -y autoremove

    echo  "Uninstallation is complete."

    ;;

  *)    
    echo  "The Uninstallation has been cancelled."
    exit
    ;;
esac

