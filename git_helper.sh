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

##############################################################
#			Git Helper Menu			     #
##############################################################
function REPO_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Git Helper Menu                                                              |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [G] Global Setup/Clone Menu"
	echo "  [C] Commit Helper Menu"
	echo "  [B] Branch Helper Menu"
	echo "  [S] Stash Helper Menu"
	echo "  [P] Patch Helper Menu"
	echo "  [Z] Build Kernel (try to execute build_kernel.sh)"
	echo "  [R] Switch Repo"
	echo "  [X] Exit"
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH" 
	echo "|______________________________________________________________________________|"

read menu

case "$menu" in
	"G" | "g" )
		#setup/clone menu
			SETUP_MENU
			REPO_MENU
	;;
	"C" | "c" )
		#Commit Menu
			COMMIT_MENU
			REPO_MENU
	;;
	"B" | "b" )
		#Create a New Branch & Push Branch
			BRANCH_MENU
			REPO_MENU
	;;
	"S" | "s" )
		#Stash Menu
			STASH_MENU
	;;
	"P" | "p" )
		#patch menu
			PATCH_MENU
	;;
	"Z" | "z" )
		BUILD_KERNEL
	;;
	"R" | "r" )
		#switch repo
			ENTER_DIRECTORY
			REPO_MENU
	;;
	"X" | "x" )
		exit
	;;
esac
}

##############################################################
#			Git Setup Menu			     #
##############################################################

function SETUP_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Global Setup / Clone Menu                                                    |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [G] Global Setup"
	echo "  [S] Setup a new Repo"
	echo "  [C] Clone a Repo"
	echo "  [X] Git Helper Menu"
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH" 
	echo "|______________________________________________________________________________|"

read setup_menu

case "$setup_menu" in
	"G" | "g" )
		#Global Git Setup
			GLOBAL_SETUP
			SETUP_MENU
	;;
	"S" | "s" )
		#New Repo Setup
			NEW_REPO
			SETUP_MENU
	;;
	"C" | "C" )
		#Clone a Repo
			GIT_CLONE
			SETUP_MENU
	;;
	"X" | "x" )
		REPO_MENU
	;;
esac
}

#functions (git global setup)
function GLOBAL_SETUP()
{
	#Gloabl Git Setup
		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " ______________________________________________________________________________ "
		echo "| Git Global Setup                                                             |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Your Name : " USER_NAME
		git config --global user.name $USER_NAME
		read -p "  Enter Your Email Address : " EMAIL_ADDRESS
		git config --global user.email $EMAIL_ADDRESS
		echo "|------------------------------------------------------------------------------|"
		echo "| Global Settings Have Been Set                                                |"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

#functions (create a new repo)
function NEW_REPO()
{
	#New Repo Setup
		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " ______________________________________________________________________________ "
		echo "| New Repo Setup                                                               |"
		echo "|------------------------------------------------------------------------------|"
		cd ~/
		echo "  CURRENTLY SESTTING UP REPO IN: $PWD"
		read -p "  Enter Repo Name : " REPO_NAME
		mkdir $REPO_NAME
		cd $REPO_NAME
		git init
		echo "|------------------------------------------------------------------------------|"
		echo "| Repo Directory Has Been Setup In Your Home Directory                         |"
		echo "|______________________________________________________________________________|"
		echo
		echo " ______________________________________________________________________________ "
		echo "|          *NOW IS THE TIME TO ADD FILES TO YOUR LOCAL REPOSITORY*             |"
		echo "|------------------------------------------------------------------------------|"
		echo "                When you are finished press enter to continue"
		echo "|------------------------------------------------------------------------------|"
		echo "|          *NOW IS THE TIME TO ADD FILES TO YOUR LOCAL REPOSITORY*             |"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
		ADD_FILE
		ADD_COMMIT
		ADD_ORIGIN_REMOTE
		PUSH
		SETUP_MENU
}
#functions (clone a git repository)
function GIT_CLONE()
{
		echo	$(tput sgr0) $(tput bold) $(tput setaf 4)
		echo " ______________________________________________________________________________ "
		echo "| Clone a Repo                                                                 |"
		echo "|------------------------------------------------------------------------------|"
		cd ~/
		echo "  CURRENTLY CLONING INTO: $PWD"
		read -p "  Enter Forked Repo Address : " REPO_ADDRESS
		git clone $REPO_ADDRESS
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
		ENTER_DIRECTORY
		
}

##############################################################
#			Commit Helper Menu		     #
##############################################################

function COMMIT_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Commit Helper Menu                                                           |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [A] Add Files To Repo"
	echo "  [C] Commit Changes"
	echo "  [P] Push Changes To Repo"
	echo "  [E] Enter/Switch Repo Directory"
	echo "  [X] Git Helper Menu"
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH" 
	echo "|______________________________________________________________________________|"

read commit_menu

case "$commit_menu" in
	"A" | "a" )
		#add files to repo
			ADD_FILES
			COMMIT_MENU
	;;
	"C" | "c" )
		#create a new commit
			ADD_COMMIT
			COMMIT_MENU
	;;
	"P" | "p" )
		#push files to repo
			PUSH
			COMMIT_MENU
	;;
	"E" | "e" )
		#switch repo
			ENTER_DIRECTORY
			COMMIT_MENU
	;;
	"X" | "x" )
		REPO_MENU
	;;
esac
}

#functions (add a file to git repo)
function ADD_FILE()
{

			echo	$(tput sgr0) $(tput bold) $(tput setaf 5)
			echo " ______________________________________________________________________________ "
			echo "| Would You Like to Add a File to your Repo                                    |"
			echo "|------------------------------------------------------------------------------|"
			echo "  [Y] Yes"
			echo "  [N] NO"
			echo "|------------------------------------------------------------------------------|"
			echo "|______________________________________________________________________________|"
		read add_file
			case "$add_file" in
				"Y" | "y" )
					echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
					echo " ______________________________________________________________________________ "
					echo "| Please Input dir if it is not located in repo                                |"
					echo "|------------------------------------------------------------------------------|"
					read -p "  Enter File Name : " FILE_NAME
					git add $FILE_NAME
					echo "|------------------------------------------------------------------------------|"
					echo "|______________________________________________________________________________|"
					ADD_FILE
				;;
				"N" | "n" )
				;;
				esac
}

#functions (commit changes to repo)
function ADD_COMMIT()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " ______________________________________________________________________________ "
		echo "| Please Input your commit message(use _ instead of spaces)                    |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Commit Message : " COMMIT_MESSAGE
		git commit -a -m $COMMIT_MESSAGE
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

#functions (add origin remote)
function ADD_ORIGIN_REMOTE()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
		echo " ______________________________________________________________________________ "
		echo "| Please Enter Your Origin Remote Address                                      |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Remote Address : " REMOTE_ORIGIN
		git remote add origin $REMOTE_ORIGIN
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

#function (push commits to git repo)
function PUSH()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " ______________________________________________________________________________ "
		echo "| Push Your Changes to your Repo (master = main repo)                          |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Branch Name : " BRANCH_NAME
		git push origin $BRANCH_NAME
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

##############################################################
#			Branch Menu			     #
##############################################################
function BRANCH_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Branch Helper Menu                                                           |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [C] Create a New Branch"
	echo "  [V] View Branches"
	echo "  [S] Switch Branches"
	echo "  [M] Merge Branch"
	echo "  [E] Enter/Switch Repo Directory"
	echo "  [X] Git Helper Menu"
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH" 
	echo "|______________________________________________________________________________|"

read branch_menu

case "$branch_menu" in
	"B" | "b" )
		#Create a New Branch & Push Branch
			BRANCH
			BRANCH_MENU
	;;
	"V" | "v" )
		#View Branchs
			VIEW_BRANCHES
			BRANCH_MENU
	;;
	"S" | "s" )
		#Checkout a branch (will change state of file system)
			CHECKOUT_BRANCH
			BRANCH_MENU
	;;
	"M" | "m" )
		#Merge a Branch
			MERGE_BRANCH
			BRANCH_MENU
	;;
	"E" | "e" )
		#switch repo
			ENTER_DIRECTORY
			BRANCH_MENU
	;;
	"X" | "x" )
			REPO_MENU
	;;
esac
}

#function (create a new branch)
function BRANCH()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " ______________________________________________________________________________ "
		echo "| Create a Branch                                                              |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Branch Name : " BRANCH_NAME
		git branch $BRANCH_NAME
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
		PUSH
}

#function (view branches)
function VIEW_BRANCHES()
{

		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " ______________________________________________________________________________ "
		echo "| View Branches                                                                |"
		echo "|------------------------------------------------------------------------------|"
		git branch
		tput sgr0
		tput bold
		tput setaf 3
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

#function (switch to a branch)
function CHECKOUT_BRANCH()
{
		VIEW_BRANCHES
		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " ______________________________________________________________________________ "
		echo "| Switch to a Branch                                                           |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Branch Name : " BRANCH_NAME
		git checkout $BRANCH_NAME
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
}

#function (merge a branch)
function MERGE_BRANCH()
{
	#Merge Branches
		VIEW_BRANCHES
		echo	$(tput sgr0) $(tput bold) $(tput setaf 3)
		echo " ______________________________________________________________________________ "
		echo "| Please Enter Branch Names                                                    |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Branch You Would Like To Merge Into : " INTO_BRANCH
		git checkout $INTO_BRANCH
		read -p "  Enter Branch Name That Is Being Merged : " MERGE_BRANCH
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		echo " ______________________________________________________________________________ "
		echo "| Review Of Changes Before Merging                                             |"
		echo "|------------------------------------------------------------------------------|"
		git diff $INTO_BRANCH $MERGE_BRANCH
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		echo " ______________________________________________________________________________ "
		echo "| Merge Branch                                             |"
		echo "|------------------------------------------------------------------------------|"
		git merge $MERGE_BRANCH
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		MERGE_BRANCH2
}

#function (part 2 of branch merge)
function MERGE_BRANCH2()
{
		echo	$(tput sgr0) $(tput bold) $(tput setaf 6)
		echo " ______________________________________________________________________________ "
		echo "| If there were errors Choose [D] After Fixing Choose [C]                      |"
		echo "|------------------------------------------------------------------------------|"
		echo "  [D] Show Conflicts <-(fix if needed) "
		echo "  [C] Commit/Review/Push"
		echo "  [X] Choose If There Were No Errors"
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read diff
			case "$diff" in
				"D" | "d" )
				echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
				echo " ______________________________________________________________________________ "
				echo "| Please Fix These Before Commiting                                            |"
				echo "|------------------------------------------------------------------------------|"
				git diff
				echo "|------------------------------------------------------------------------------|"
				echo "|______________________________________________________________________________|"
				echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
				echo " ______________________________________________________________________________ "
				echo "|                 *PLEASE FIX DIFF FILES BEFORE CONTINUING*                    |"
				echo "|------------------------------------------------------------------------------|"
				echo "              When you are finished press enter to continue"
				echo "|------------------------------------------------------------------------------|"
				echo "|                 *PLEASE FIX DIFF FILES BEFORE CONTINUING*                    |"
				echo "|______________________________________________________________________________|"
				read -p "Press [Enter] key to continue..."
				MERGE_BRANCH2
			;;
			"C" | "c" )
				ADD_COMMIT
				echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
				echo " ______________________________________________________________________________ "
				echo "|               *Showing Graphical Representation of History*                  |"
				echo "|------------------------------------------------------------------------------|"
				gitk
				echo "|------------------------------------------------------------------------------|"
				echo "|______________________________________________________________________________|"
				read -p "Press [Enter] key to continue..."
				PUSH
			;;
			"X" | "x" )
			REPO_MENU
			;;
		esac
}

##############################################################
#			Stash Menu			     #
##############################################################

#functions (git stash)
function STASH_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Git Stash Menu                                                               |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [S] Stash Changes"
	echo "  [V] View Stashes"
	echo "  [L] Load a Stash"
	echo "  [E] Enter/Switch Repo Directory"
	echo "  [X] Git Helper Menu"
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH"  
	echo "|______________________________________________________________________________|"

read stash_menu

case "$stash_menu" in
	"S" | "s" )
	#Stash changes
		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " ______________________________________________________________________________ "
		echo "| Stash Changes for later                                                      |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Message for Reminder : " STASH_MESSAGE
		git stash save $STASH_MESSAGE
		echo "|------------------------------------------------------------------------------|"
		echo "| Changes Have Been Stashed For Later Use                                      |"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
		GIT_STASH
	;;
	"V" | "v" )
		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " ______________________________________________________________________________ "
		echo "| Viewing Stash List (press Q to exit)                                         |"
		echo "|------------------------------------------------------------------------------|"
		git stash list
		tput sgr0
		tput bold
		tput setaf 1
		echo "|------------------------------------------------------------------------------|"
		echo "|______________________________________________________________________________|"
		read -p "Press [Enter] key to continue..."
		GIT_STASH
	;;
	"L" | "l" )
		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " ______________________________________________________________________________ "
		echo "| Please Enter Which Stash You Would Like To Load                              |"
		echo "|------------------------------------------------------------------------------|"
		read -p "  Enter Stash Number : " STASH_MESSAGE
		git stash apply stash@{$STASH_NUMBER}
		tput sgr0
		tput bold
		tput setaf 1
		echo "|------------------------------------------------------------------------------|"
		echo "| Stash Has Been Reloaded                                                      |"
		echo "|______________________________________________________________________________|"
		GIT_STASH
	;;
	"E" | "e" )
		#switch repo
			ENTER_DIRECTORY
			STASH_MENU
	;;
	"X" | "x" )
		REPO_MENU
	;;
esac
}

##############################################################
#			Patch Menu			     #
##############################################################
function PATCH_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| PATCH Helper Menu                                                            |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [V] View Commits"
	echo "  [C] Create a New Patch"
	echo "  [P] Patch Repo"
	echo "  [E] Enter/Switch Repo Directory"
	echo "  [X] Git Helper Menu"
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH" 
	echo "|______________________________________________________________________________|"

read patch_menu

case "$patch_menu" in
	"V" | "v" )
		#View Commits
			VIEW_COMMITS
			PATCH_MENU
	;;
	"C" | "c" )
		#Create a new patch
			FORMAT_PATCH
			PATCH_MENU
	;;
	"P" | "p" )
		#Patch a Repo
			PATCH_REPO
			PATCH_MENU
	;;
	"E" | "e" )
		#switch repo
			ENTER_DIRECTORY
			PATCH_MENU
	;;
	"X" | "x" )
			REPO_MENU
	;;
esac
}
#functions (git view commits)
function VIEW_COMMITS()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Viewing Patches                                                              |"
	echo "|------------------------------------------------------------------------------|"
	git log
	echo "|------------------------------------------------------------------------------|"
	echo "|______________________________________________________________________________|"
	read -p "Press [Enter] key to continue..."
}

#functions (create a patch)
function FORMAT_PATCH()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Please Enter first 7 digits of commit ID                                     |"
	echo "|------------------------------------------------------------------------------|"
	read -p "  ENTER NUMBER Of COMMITS YOU WOULD LIKE TO GO BACK : " P_NUM
	read -p "  ENTER COMMIT ID : " COMMIT_ID
	git format-patch -p$P_NUM $COMMIT_ID
	echo "|------------------------------------------------------------------------------|"
	echo "|______________________________________________________________________________|"
	read -p "Press [Enter] key to continue..."
}

#functions (patch repo)
function PATCH_REPO()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Showing Patch Files In Repo                                                  |"
	echo "|------------------------------------------------------------------------------|"
	find ./ -type f -name \*.patch
	read -p "  ENTER -p # : " P_NUM
	read -p "  ENTER PATCH FILE NAME : " PATCH_NAME
	patch -p$P_NUM < $PATCH_NAME
	echo "|------------------------------------------------------------------------------|"
	echo "|______________________________________________________________________________|"
	read -p "Press [Enter] key to continue..."
}

##############################################################
#		   Execute Build_Kernel.sh		     #
##############################################################

#try to execute ./build_kernel.sh
function BUILD_KERNEL()
{
	echo	$(tput bold) $(tput setaf 1)
	echo " ______________________________________________________________________________ "
	echo "| Checking if build_kernel.sh exists                                           |"
	echo "|------------------------------------------------------------------------------|"
		if [ -e build_kernel.sh ] ; then
			gnome-terminal -e "bash -c \"./build_kernel.sh; exec bash\""
		else
			echo "|------------------------------------------------------------------------------|"
			echo "|                    File Does Not Exist In Repo Directory                     |"
			echo "|______________________________________________________________________________|"
			read -p "Press [Enter] key to continue..."
			CHANGE_FILE_NAME
		fi
	echo "|------------------------------------------------------------------------------|"
	echo "| Execution of build_kernel has succeeded...                                   |"
	echo "|______________________________________________________________________________|"
	read -p "Press [Enter] key to continue..."
	REPO_MENU
	
}

#try to execute ./build_kernel.sh
function CHANGE_FILE_NAME()
{
			echo	$(tput bold) $(tput setaf 1)
			echo " ______________________________________________________________________________ "
			echo "| Listing .sh files within repo                                                |"
			echo "|------------------------------------------------------------------------------|"
			find ./ -type f -name \*.sh
			echo "|------------------------------------------------------------------------------|"
			echo "|______________________________________________________________________________|"
			echo	$(tput sgr0) $(tput bold) $(tput setaf 5)
			echo " ______________________________________________________________________________ "
			echo "| Would You Like to Rename A .sh File and Try Again                            |"
			echo "|------------------------------------------------------------------------------|"
			echo "  [Y] Yes"
			echo "  [N] NO"
			echo "|------------------------------------------------------------------------------|"
			echo "|______________________________________________________________________________|"
		read change_name
			case "$change_name" in
				"Y" | "y" )
					echo	$(tput sgr0) $(tput bold) $(tput setaf 2)
					echo " ______________________________________________________________________________ "
					echo "| Please Input The Name of The .sh File You Would Like To Replace              |"
					echo "|------------------------------------------------------------------------------|"
					read -p "  .sh File Name : " SH_FILE
					mv $SH_FILE build_kernel.sh
				if [ -e build_kernel.sh ] ; then
					echo "|------------------------------------------------------------------------------|"
					echo "|Now Let's Try Again                                                           |"
					echo "|______________________________________________________________________________|"
					read -p "Press [Enter] key to continue..."
					BUILD_KERNEL
				else
					CHANGE_FILE_NAME
				fi
				;;
				"N" | "n" )
					REPO_MENU
				;;
			esac
}

##############################################################
#		   	Change Repo		  	     #
##############################################################

#enter directory in which you would like git help
function ENTER_DIRECTORY()
{
	echo	$(tput bold) $(tput setaf 1)
	echo " ______________________________________________________________________________ "
	echo "| Please enter name of the repo you would like help with  (folder name)        |"
	echo "|------------------------------------------------------------------------------|"
		cd ~/
		read -p "  ENTER FOLDER NAME : " REPO_DIRECTORY
		if [ -e $REPO_DIRECTORY ] ; then
			cd ~/$REPO_DIRECTORY
		else
			echo "|------------------------------------------------------------------------------|"
			echo "|                    File Does Not Exist In Home Directory                     |"
			echo "|______________________________________________________________________________|"
			read -p "Press [Enter] key to continue..."
			ENTER_DIRECTORY
		fi
	echo "|------------------------------------------------------------------------------|"
		REPO=$(basename $PWD)
	echo "| CURRENT REPO   : $REPO"
		CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	echo "| CURRENT BRANCH : $CURRENT_BRANCH" 
	echo "|______________________________________________________________________________|"
}

#main
REPO_MENU
