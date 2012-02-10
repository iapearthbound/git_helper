#!/bin/bash
#
# Git Helper Functions...
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
	echo "| Git Helper Menu                                          |"
	echo "|----------------------------------------------------------|"
	echo "  [G] Global Setup"
	echo "  [S] Setup a new Repo"
	echo "  [R] Clone a Repo"
	echo "  [F] Add a Files to your repo"
	echo "  [C] Add a Commit"
	echo "  [P] Push Commit to Git Repo"
	echo "  [B] Create a New Branch"
	echo "  [V] View Branches"
	echo "  [Y] Switch Branches"
	echo "  [M] Merge <-(switch to branch to merge into before using)"
	echo "  [X] Exit <- (exit back to build Menu)"
	echo "|----------------------------------------------------------|"
	echo "| Please Type Your Choice & Press Enter                    |"
	echo "|__________________________________________________________|"

read menu

case "$menu" in
	"G" | "g" )
		#Global Git Setup
			GLOBAL_SETUP
			REPO_MENU
	;;
	"S" | "s" )
		#New Repo Setup
			NEW_REPO
			REPO_MENU
	;;
	"R" | "r" )
		#Clone a Repo
			GIT_CLONE
			REPO_MENU
	;;
	"F" | "f" )
		#Add a File to your Repo
			ADD_FILE
			REPO_MENU
	;;
	"C" | "c" )
		#Commit Files
			ADD_COMMIT
			REPO_MENU
	;;
	"P" | "p" )
		#Push Commits to Git Repo
			PUSH
			REPO_MENU
	;;
	"B" | "b" )
		#Create a New Branch & Push Branch
			BRANCH
			REPO_MENU
	;;
	"V" | "v" )
		#View Branchs
			VIEW_BRANCHES
			REPO_MENU
	;;
	"Y" | "y" )
		#Checkout a branch (will change state of file system)
			CHECKOUT_BRANCH
			REPO_MENU
	;;
	"M" | "m" )
		#Merge a Branch
			MERGE_BRANCH
			REPO_MENU
	;;
	"X" | "x" )
	./build_kernel.sh
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
		read -p "Press [Enter] key to continue..."
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
		read -p "Press [Enter] key to continue..."
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
		read -p "Press [Enter] key to continue..."
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
		read -p "Press [Enter] key to continue..."
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
		read -p "Press [Enter] key to continue..."
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
		read -p "Press [Enter] key to continue..."
}

function BRANCH()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " __________________________________________________________ "
		echo "| Create a Branch                                          |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Branch Name : " BRANCH_NAME
		git branch $BRANCH_NAME
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
		read -p "Press [Enter] key to continue..."
		PUSH
}

function VIEW_BRANCHES()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " __________________________________________________________ "
		echo "| View Branches                                            |"
		echo "|----------------------------------------------------------|"
		git branch
		tput sgr0
		tput bold
		tput setaf 3
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

function CHECKOUT_BRANCH()
{
		VIEW_BRANCHES
		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " __________________________________________________________ "
		echo "| Switch to a Branch                                       |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Branch Name : " BRANCH_NAME
		git checkout $BRANCH_NAME
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

function MERGE_BRANCH()
{
	#Merge Branches
		VIEW_BRANCHES
		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " __________________________________________________________ "
		echo "| Merge a Branch                                           |"
		echo "|----------------------------------------------------------|"
		read -p "Enter Branch You Would Like To Merge Into : " INTO_BRANCH
		git checkout $INTO_BRANCH
		read -p "Enter Branch Name That Is Being Merged : " MERGE_BRANCH
		git merge $MERGE_BRANCH
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
		MERGE_BRANCH2
		

}

#function
function MERGE_BRANCH2()
{
		echo	$(tput sgr0) $(tput bold) $(tput setaf 6)
		echo " __________________________________________________________ "
		echo "| If there were errors Choose   D                          |"
		echo "|----------------------------------------------------------|"
		echo "  [D] Show Conflicts <-(fix if needed) "
		echo "  [C] Commit/Review/Push"
		echo "  [X] Choose If There Were No Errors"
		echo "|----------------------------------------------------------|"
		echo "|__________________________________________________________|"
		read diff
			case "$diff" in
				"D" | "d" )
				echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
				echo " __________________________________________________________ "
				echo "| Please Fix These Before Commiting                        |"
				echo "|----------------------------------------------------------|"
				git diff
				echo "|----------------------------------------------------------|"
				echo "|__________________________________________________________|"
				echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
				echo " __________________________________________________________ "
				echo "|        *PLEASE FIX DIFF FILES BEFORE CONTINUING*         |"
				echo "|----------------------------------------------------------|"
				echo "       When you are finished press enter to continue"
				echo "|----------------------------------------------------------|"
				echo "|        *PLEASE FIX DIFF FILES BEFORE CONTINUING*         |"
				echo "|__________________________________________________________|"
				read -p "Press [Enter] key to continue..."
				MERGE_BRANCH2
			;;
			"C" | "c" )
				ADD_COMMIT
				echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
				echo " __________________________________________________________ "
				echo "|      *Showing Graphical Representation of History*       |"
				echo "|----------------------------------------------------------|"
				gitk
				echo "|----------------------------------------------------------|"
				echo "|__________________________________________________________|"
				read -p "Press [Enter] key to continue..."
				PUSH
			;;
			"X" | "x" )	
			;;
		esac
}

#Main
REPO_MENU
