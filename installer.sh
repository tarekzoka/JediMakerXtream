#!/bin/sh

# 
# SCRIPT : DOWNLOAD AND INSTALL EMU OSCAM #
# ======================================================================================
# Command: wget https://raw.githubusercontent.com/emilnabil/oscam/main/installer.sh -O - | /bin/sh #
# ======================================================================================

# MY CONFIG SCRIPT #
###########################################
PACKAGE_DIR='oscam/main'
MY_IPK="oscam_11.696_all.ipk"
MY_DEB="oscam_11.696_all.deb"


######################################################################################
# Auto ... Do not change
######################################################################################

# Decide : which package ?
MY_MAIN_URL="https://raw.githubusercontent.com/emilnabil/"
if which dpkg > /dev/null 2>&1; then
	MY_FILE=$MY_DEB
	MY_URL=$MY_MAIN_URL${PACKAGE_DIR}/${MY_DEB}
else
	MY_FILE=$MY_IPK
	MY_URL=$MY_MAIN_URL${PACKAGE_DIR}/${MY_IPK}
fi
MY_TMP_FILE="/tmp/"$MY_FILE

echo ''
echo '************************************************************'
echo '**                         STARTED                        **'
echo '************************************************************'
#            # WRITE Script By  Biko_73 #                
# AND MODIFY Script To Work Emu OScam BY    
 #  EMIL_NABIL  #
echo "************************************************************"
echo ''

# Remove previous file (if any)
rm -f $MY_TMP_FILE > /dev/null 2>&1

# Download package file
EM='============================================================='
echo $EM
echo 'Downloading '$MY_FILE' ...'
echo $EM
echo ''
wget -T 2 $MY_URL -P "/tmp/"

# Check download
if [ -f $MY_TMP_FILE ]; then
	# Install
	echo ''
	echo $EM
	echo 'Installation started'
	echo $EM
	echo ''
	if which dpkg > /dev/null 2>&1; then
		apt-get install --reinstall $MY_TMP_FILE -y
	else
		opkg install --force-reinstall $MY_TMP_FILE
	fi
	MY_RES=$?

	# Res
	echo ''
	echo ''
	if [ $MY_RES -eq 0 ]; then
		echo "   >>>>   SUCCESSFULLY INSTALLED   <<<<"
		echo ''
		echo "   >>>>         RESTARING         <<<<"
		if which systemctl > /dev/null 2>&1; then
			sleep 2; systemctl restart enigma2
		else
			init 4; sleep 4; init 3;
		fi
	else
		echo "   >>>>   INSTALLATION FAILED !   <<<<"
	fi;
	echo ''
	echo '**************************************************'
	echo '**                   FINISHED                   **'
	echo '**************************************************'
	echo ''
echo ""
   wait 2;   
	exit 0
else
	echo ''
	echo "Download failed !"
	exit 1
fi

# 
