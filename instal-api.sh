#!/bin/bash

sudo clear


if [ $(whoami) != "root" ];then
	echo "Please use [root] user to run the Whatsapp API installation script"
	exit 1;
fi

Installation() {

	echo "================================================================================="
	echo "Updating the system"
	echo "================================================================================="
	echo ""

	sudo apt-get update
	sudo apt-get upgrade -y
	
	sudo clear
	
	whiptail --title "Whatsapp API Installer" --msgbox "Press ENTER to start the installation" --fb 15 50

    Drive=$(whiptail --title "File Key" --inputbox "File Key:" --fb 15 50 4 3>&1 1>&2 2>&3)

	dominio=$(whiptail --title "Dominio" --inputbox "Enter the domain that will be used in this API:" --fb 15 50 3>&1 1>&2 2>&3)

	sudo hostname $dominio

	Key=$(whiptail --title "Secret key" --inputbox "Key" --fb 15 50 4 3>&1 1>&2 2>&3)

 
	for i in $(seq 1 100)
	do
		sleep 0.1

		if [ $i -eq 100 ]; then
		
			sudo apt-get update >/dev/null 2>/dev/null
			sudo apt-get upgrade -y >/dev/null 2>/dev/null
			
		elif [ $(($i % 25)) -eq 0 ]; then
			
			sudo apt-get install -y git nano wget unzip unrar fastjar curl yarn gcc build-essential g++ make vim libgbm-dev fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libnss3 lsb-release xdg-utils ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release libu2f-udev wget xdg-utils python python3 net-tools ffmpeg imagemagick ghostscript libjpeg-dev libappindicator1 apt-transport-https >/dev/null 2>/dev/null
			sudo apt install -y zip >/dev/null 2>/dev/null
			sudo apt install -y wget zip >/dev/null 2>/dev/null
			
		elif [ $(($i % 45)) -eq 0 ]; then
		
			curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh >/dev/null 2>/dev/null

			sudo bash nodesource_setup.sh >/dev/null 2>/dev/null

			rm nodesource_setup.sh -r >/dev/null 2>/dev/null

			sudo apt-get install nodejs -y >/dev/null 2>/dev/null

			sudo apt-get -y install docker-ce  >/dev/null 2>/dev/null

			sudo apt-get update >/dev/null 2>/dev/null

			sudo apt-get upgrade >/dev/null 2>/dev/null

			sudo npm install -g npm >/dev/null 2>/dev/null

			sudo npm update -g >/dev/null 2>/dev/null

			sudo npm i yarn -g >/dev/null 2>/dev/null

			sudo npm i nodemon -g >/dev/null 2>/dev/null

			npm cache clean -f >/dev/null 2>/dev/null


		elif [ $(($i % 65)) -eq 0 ]; then

			sudo apt install -y nginx >/dev/null 2>/dev/null
			sudo apt install -y certbot python3-certbot-nginx >/dev/null 2>/dev/null

			mkdir /etc/nginx/proxy >/dev/null 2>/dev/null

			echo 'server {
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name '$dominio';
   
    location / {
        proxy_pass http://127.0.0.1:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    include /etc/nginx/proxy/*.conf;
    
}' > /etc/nginx/sites-enabled/default

			service nginx restart >/dev/null 2>/dev/null

			certbot -d $dominio --agree-tos -m  adm@$dominio --redirect --no-eff-email >/dev/null 2>/dev/null

			service nginx restart >/dev/null 2>/dev/null

			
		elif [ $(($i % 85)) -eq 0 ]; then
		
			mkdir -p /home/api-whatsapp >/dev/null 2>/dev/null

			sudo wget -o /home/api-whatsapp/api-whatsapp.zip https://drive.google.com/uc?id=$Drive  -T 10 >/dev/null 2>/dev/null
			
			unzip -o /home/api-whatsapp/api-whatsapp.zip -d /home/api-whatsapp/ >/dev/null 2>/dev/null
			
			rm /home/api-whatsapp/api-whatsapp.zip  >/dev/null 2>/dev/null


			echo "  TOKEN="$Key"
					PROTECT_ROUTES=false
					PORT=3001
					RESTORE_SESSIONS_ON_START_UP=true 
					APP_URL="$dominio"
					CLIENT_PLATFORM=MacOs
					CLIENT_BROWSER=Chrome
					CLIENT_VERSION=101.0.4951.64
					MONGODB_ENABLED=true 
					MONGODB_URL=mongodb://mongodb:27017/whatsapp_api " > /home/api-whatsapp/.env

			sudo npm install --prefix /home/api-whatsapp  >/dev/null 2>/dev/null

			cd /home/api-whatsapp 

		    sudo docker-compose up -d 

		else
			echo $i
		fi		
		
	done | whiptail --title 'Whatsapp API Installation' --gauge 'Installing please wait...' 6 60 0
	
	whiptail --title "API Installed successfully." --msgbox "Press ENTER to finish the installer" --fb 15 50 
	
	sudo clear

	echo "================================================================================="
	echo "Installation Completed Successfully!"
	echo "================================================================================="
	echo ""
	echo "URL: https://$dominio"
	echo ""
	echo "================================================================================="
	
 
	
}


Updating(){

	echo "================================================================================="
	echo "Updating the system"
	echo "================================================================================="


	sudo apt-get update
	sudo apt-get upgrade -y
	
	sudo clear
	
	whiptail --title "Whatsapp API Installer" --msgbox "Press ENTER to start the installation" --fb 15 50

    Drive=$(whiptail --title "File Key" --inputbox "File Key:" --fb 15 50 4 3>&1 1>&2 2>&3)

 
	for i in $(seq 1 100)
	do
		sleep 0.1

		if [ $i -eq 100 ]; then
		
			sudo apt-get update >/dev/null 2>/dev/null
			sudo apt-get upgrade -y >/dev/null 2>/dev/null
			
		elif [ $(($i % 25)) -eq 0 ]; then
			
		 
			
		elif [ $(($i % 45)) -eq 0 ]; then
		
			 

		elif [ $(($i % 65)) -eq 0 ]; then
 
			
		elif [ $(($i % 85)) -eq 0 ]; then
		
		    cd /home/api-whatsapp 

		    sudo wget -O  /home/api-whatsapp/api-whatsapp.zip https://drive.google.com/uc?id=$Drive  -T 10 >/dev/null 2>/dev/null
			
			unzip -O  /home/api-whatsapp/api-whatsapp.zip -A  /home/api-whatsapp/ >/dev/null 2>/dev/null
			
			rm /home/api-whatsapp/api-whatsapp.zip  >/dev/null 2>/dev/null 
		  

		else
			echo $i
		fi		
		
	done | whiptail --title 'Whatsapp API Update' --gauge 'Update please wait...' 6 60 0
	
	whiptail --title "API updated successfully." --msgbox "Press ENTER to finish the updated" --fb 15 50 
	
	sudo clear

	echo "================================================================================="
	echo "Update completed successfully"
	echo "================================================================================="
 
	 
 
}

 

acao=$(whiptail --title "API Whatsapp @raphaelvserafim" --menu "Choose an option from the list below to continue" --fb 15 50 4 \
"1" "Install the API" \
"2" "Update the API" \
"3" "Cancel"  3>&1 1>&2 2>&3)

if [ $acao = '1' ]; then
	Installation
fi
 
if [ $acao = '2' ]; then
	Updating
fi

if [ $acao = '2' ]; then
	exit
fi
