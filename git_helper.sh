#!/bin/bash
#
# One script to rules them all... ;)
# Functions to create Samurai Specific Kernels...
#
#
# 2012 EarthBound.IAP
#

# Text color variables <- Adding some color to this script...
txtgrn=$(tput setaf 1) # RED
txtgrn=$(tput setaf 2) # Green
txtylw=$(tput setaf 3) # Yellow
txtblu=$(tput setaf 4) # Blue
txtpur=$(tput setaf 5) # Purple
txtcyn=$(tput setaf 6) # Cyan
txtwht=$(tput setaf 7) # White
txtrst=$(tput sgr0) # Text reset
txtbld=$(tput bold) #

#functions
function REPO_MENU()
{
	echo	$(tput bold) $(tput setaf 6)
	echo " __________________________________________________________ "
	echo "| Have you Forked The Repo Or Would you Like to Clone      |"
	echo "|----------------------------------------------------------|"
	echo "  [G] Global Setup"
	echo "  [S] Setup a new Repo"
	echo "  [R] Clone a Repo"
	echo "  [F] Add a Files to your repo"
	echo "  [C] Add a Commit"
	echo "  [P] Push Commit to Git Repo"
	echo "  [X] Exit"
	echo "|----------------------------------------------------------|"
	echo "| Please Type Your Choice & Press Enter                    |"
	echo "|__________________________________________________________|"

read menu

case "$menu" in
	"G" | "g" )
		#Global Git Setup
			GLOBAL_SETUP
	;;
	"S" | "s" )
		#New Repo Setup
			NEW_REPO
	;;
	"R" | "r" )
		#Clone a Repo
			GIT_CLONE
	;;
	"F" | "f" )
		#Add a File to your Repo
			ADD_FILE
	;;
	"C" | "c" )
		#Commit Files
			ADD_COMMIT
	;;
	"P" | "p" )
		#Push Commits to Git Repo
			PUSH
	;;
	"X" | "x" )
		exit	
	;;
esac
}

#functions
function GLOBAL_SETUP()
{
	#Gloabl Git Setup
		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " __________________________________________________________ "
		echo "| Git Global Setup                                         |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Your Name : " USER_NAME
		git config --global user.name $USER_NAME
		read -p "Enter Your Email Address : " EMAIL_ADDRESS
		git config --global user.email $EMAIL_ADDRESS
		echo "|----------------------------------------------------------|"
		echo "| Global Settings Have Been Set                            |"
		echo "|__________________________________________________________|"
}

#functions
function NEW_REPO()
{
	#New Repo Setup
		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " __________________________________________________________ "
		echo "| New Repo Setup                                           |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Repo Name : " REPO_NAME
		mkdir $REPO_NAME
		cd $REPO_NAME
		git init
		echo "|----------------------------------------------------------|"
		echo "| Repo Directory Has Been Setup                            |"
		echo "|__________________________________________________________|"
		echo
		echo " __________________________________________________________ "
		echo "| *NOW IS THE TIME TO ADD FILES TO YOUR LOCAL REPOSITORY*  |"
		echo "|----------------------------------------------------------|"
		echo "       When you are finished press enter to continue"
		echo "|----------------------------------------------------------|"
		echo "| *NOW IS THE TIME TO ADD FILES TO YOUR LOCAL REPOSITORY*  |"
		echo "|__________________________________________________________|"
		read -p "Press [Enter] key to start backup..."
		ADD_FILE
		ADD_COMMIT
		ADD_ORIGIN_REMOTE
		PUSH
}
#functions
function GIT_CLONE()
{
		echo	$(tput sgr0) $(tput bold) $(tput setaf 4)
		echo " __________________________________________________________ "
		echo "| Clone a Repo                                             |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Forked Repo Address : " REPO_ADDRESS
		git clone $REPO_ADDRESS
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
}
#functions
function ADD_FILE()
{

			echo	$(tput sgr0) $(tput bold) $(tput setaf 5)
			echo " __________________________________________________________ "
			echo "| Would You Like to Add a File to your Repo                |"
			echo "|----------------------------------------------------------|"
			echo "  [Y] Yes"
			echo "  [N] NO"
			echo "|----------------------------------------------------------|"
			echo "| Please Type Your Choice & Press Enter                    |"
			echo "|__________________________________________________________|"
		read add_file
			case "$add_file" in
				"Y" | "y" )
					echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
					echo " __________________________________________________________ "
					echo "| Please Input dir if it is not located in repo            |"
					echo "|----------------------------------------------------------|"
					read -p "Enter File Name : " FILE_NAME
					git add $FILE_NAME
					echo "|----------------------------------------------------------|"
					echo "| Directories Cleaned Successfully                         |"
					echo "|__________________________________________________________|"
					ADD_FILE
				;;
				"N" | "n" )
				;;
				esac
}

#functions
function ADD_COMMIT()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " __________________________________________________________ "
		echo "| Please Input your commit message(use _ instead of spaces)|"
		echo "|----------------------------------------------------------|"
		read -p "Enter Commit Message : " COMMIT_MESSAGE
		git commit -a -m $COMMIT_MESSAGE
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
}

#functions
function ADD_ORIGIN_REMOTE()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
		echo " __________________________________________________________ "
		echo "| Please Enter Your Origin Remote Address                  |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Remote Address : " REMOTE_ORIGIN
		git remote add origin $REMOTE_ORIGIN
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
}

function PUSH()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " __________________________________________________________ "
		echo "| Push Your Changes to your Repo (master = main repo)      |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Branch Name : " BRANCH_NAME
		git push origin $BRANCH_NAME
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
}


#Main
REPO_MENU
tput sgr0
