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
	echo "| CURRENT REPO : $PWD"
	echo "|______________________________________________________________________________|"
	REPO_MENU
}

#functions (git helper menu)
function REPO_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Git Helper Menu                                                              |"
	echo "|------------------------------------------------------------------------------|"
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
	echo "  [E] Enter/Switch Directory"
	echo "  [A] Stash Changes"
	echo "  [X] Exit <- (exit back to build Menu)"
	echo "|------------------------------------------------------------------------------|"
	echo "| CURRENT REPO : $PWD"
	echo "|______________________________________________________________________________|"

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
	"E" | "e" )
		#Restart ./build_kernel.sh
			ENTER_DIRECTORY
	;;
	"A" | "a" )
		#Stash Changes
			GIT_STASH
	;;
	"X" | "x" )
		exit
		./build_kernel.sh
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
		ENTER_DIRECTORY
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
			;;
		esac
}

#functions (git stash)
function GIT_STASH()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Git Stash Menu                                                               |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [S] Stash Changes"
	echo "  [V] View Stashes"
	echo "  [L] Load Back a Stash"
	echo "  [X] Exit <- (exit back git helper menu)"
	echo "|------------------------------------------------------------------------------|"
	echo "| CURRENT REPO : $PWD"
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
	"X" | "x" )
		REPO_MENU
	;;
esac
}

#main
ENTER_DIRECTORY#!/bin/bash
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
	echo "| CURRENT REPO : $PWD"
	echo "|______________________________________________________________________________|"
	REPO_MENU
}

#functions (git helper menu)
function REPO_MENU()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Git Helper Menu                                                              |"
	echo "|------------------------------------------------------------------------------|"
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
	echo "  [E] Enter/Switch Directory"
	echo "  [A] Stash Changes"
	echo "  [X] Exit <- (exit back to build Menu)"
	echo "|------------------------------------------------------------------------------|"
	echo "| CURRENT REPO : $PWD"
	echo "|______________________________________________________________________________|"

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
	"E" | "e" )
		#Restart ./build_kernel.sh
			ENTER_DIRECTORY
	;;
	"A" | "a" )
		#Stash Changes
			GIT_STASH
	;;
	"X" | "x" )
		exit
		./build_kernel.sh
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
		ENTER_DIRECTORY
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
			;;
		esac
}

#functions (git stash)
function GIT_STASH()
{
	echo	$(tput bold) $(tput setaf 2)
	echo " ______________________________________________________________________________ "
	echo "| Git Stash Menu                                                               |"
	echo "|------------------------------------------------------------------------------|"
	echo "  [S] Stash Changes"
	echo "  [V] View Stashes"
	echo "  [L] Load Back a Stash"
	echo "  [X] Exit <- (exit back git helper menu)"
	echo "|------------------------------------------------------------------------------|"
	echo "| CURRENT REPO : $PWD"
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
	;;
	"V" | "v" )
		echo	$(tput sgr0) $(tput bold) $(tput setaf 1)
		echo " ______________________________________________________________________________ "
		echo "| Viewing Stash List (press Q to exit)                                         |"
		echo "|------------------------------------------------------------------------------|"
		git stash list
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
		echo "|------------------------------------------------------------------------------|"
		echo "| Stash Has Been Reloaded                                                      |"
		echo "|______________________________________________________________________________|"
		GIT_STASH
	;;
	"X" | "x" )
		REPO_MENU
	;;
esac
}

#main
ENTER_DIRECTORY
