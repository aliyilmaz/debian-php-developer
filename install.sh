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
Please select the PHP version.
1) PHP 8.2.0
2) PHP 7.4.33
3) PHP 5.6.40

" XamppVersion

case $XamppVersion in

  1)
    LONG_TEXT="8.2.0-0"
    SHORT_TEXT="8.2.0"
    ;;

  2)
    LONG_TEXT="7.4.33-0"
    SHORT_TEXT="7.4.33"
    ;;

  3)
    LONG_TEXT="5.6.40-1"
    SHORT_TEXT="5.6.40"
    ;;
  *)    
    echo  "The installation has been cancelled."
    exit
    ;;
esac

# #Download XAMPP and start installation
sudo wget -O src/xampp-linux-x64-"$LONG_TEXT"-installer.run https://versaweb.dl.sourceforge.net/project/xampp/XAMPP%20Linux/"$SHORT_TEXT"/xampp-linux-x64-"$LONG_TEXT"-installer.run
sudo chmod +x src/xampp-linux-x64-"$LONG_TEXT"-installer.run
sudo ./src/xampp-linux-x64-"$LONG_TEXT"-installer.run
sudo rm -R ./src/xampp-linux-x64-"$LONG_TEXT"-installer.run

#Copy authorization and shortcut file
sudo cp -R src/xampp.policy /usr/share/polkit-1/actions/xampp.policy
sudo cp -R src/xampp-control-panel.desktop /usr/share/applications/xampp-control-panel.desktop
sudo cp -R src/xampp-logo.svg /opt/lampp/img/xampp-logo.svg
sudo ln -s /opt/lampp/bin/php /usr/bin/php

#Stop the server and start apache.
sudo /opt/lampp/lampp stop
sudo /opt/lampp/lampp startapache

#Install the composer and introduce it to the system.
sudo wget -O /opt/lampp/composer-setup.php https://getcomposer.org/installer 
sudo php /opt/lampp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# stop server and define htdocs chmod
sudo /opt/lampp/lampp stop
sudo chmod -R 0777 /opt/lampp/htdocs/

#Install git and complete the settings with questions.
sudo apt-get -y autoremove
sudo apt-get -y install git
read -p 'GitHub email ? : ' EMAIL
git config --global user.email $EMAIL
read -p 'Github username ? : ' USERNAME
git config --global user.name "$USERNAME"
git config --list
echo  "Installation is complete."