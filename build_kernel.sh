#!/bin/bash

TARGET_LOCALE="vzw"

# define envvars
KBUILD_BUILD_VERSION="SAMURAI.TANTO"
LOCALVERSION=".SAMURAI.TANTO"
CODENAME="TANTO"

# define vars
DATE=$(date +%m.%d.%H.%M)
COMPDATE=$(date +%a.%b.%d.%Y.%I:%M:%S.%p)
THREADS=$(expr 1 + $(grep processor /proc/cpuinfo | wc -l))
UPDATE_SCRIPT="META-INF/com/google/android"
STARTIME=

TOOLCHAIN=$PWD/arm-eabi-4.4.3/bin 
TOOLCHAIN_PREFIX=arm-eabi-

ANDROID_OUT_DIR=`pwd`/Android/out/target/product/SPH-D700

export PRJROOT=$PWD
export PROJECT_NAME
export HW_BOARD_REV

export LD_LIBRARY_PATH=.:${TOOLCHAIN}/../lib

source $PWD/functions

##############################################################
#                   MAIN FUNCTION                            #
##############################################################
  TITLE
  echo $bld$cyn" ______________________________________________________________________________ "
  echo $bld$cyn"| Please Choose Platform To Compile For...                                     |"
  echo $bld$cyn"|------------------------------------------------------------------------------|"
  echo $bld$grn"|  [1] Compile Kernel for Touch Wiz BML ie22                                   |"
  echo $bld$grn"|  [2] Compile Kernel for Touch Wiz BML el30                                   |"
  echo $bld$grn"|  [3] Compile Kernel for Touch Wiz MTD                                        |"
  echo $bld$grn"|  [4] Compile Kernel for MIUI MTD                                             |"
  echo $bld$grn"|  [7] Compile Kernel for CM7 MTD                                              |"
  echo $bld$grn"|  [9] Compile Kernel for CM9 MTD                                              |"
  echo $bld$grn"|  [G] Git Helper Menu                                                         |"
  echo $bld$grn"|  [X] Exit <- exits script                                                    |"
  echo $bld$cyn"|------------------------------------------------------------------------------|"
  echo $bld$grn"| WORKING DIR    : $PWD" 
    REPO=$(basename $PWD)
    echo $bld$grn"| CURRENT REPO   : $REPO"
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo $bld$grn"| CURRENT BRANCH : $CURRENT_BRANCH" 
    echo $bld$cyn"|______________________________________________________________________________|"$bld$grn
  read -p "  ENTER MENU OPTION : " compile
  case "$compile" in
  #Compile Kernel for Touch Wiz BML ei22
    "1" )
    #Platform Specific Variables
      DEFCONFIG_STRING=cleangb_bml_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_ei22"
      BUILD_OUT="$PWD/out/bml_ei22_out"
      BUILD_PLATFORM="BML.EI22"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
      #BUILD Layout
      VARIABLES
      MAKE_CLEAN
    #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      UPDATE_CWMSCRIPT
      PACKAGE_BML_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
    ;;
  #Compile Kernel for Touch Wiz BML el30
    "2" )
    #Platform Specific Variables
      DEFCONFIG_STRING=cleangb_bml_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_el30"
      BUILD_OUT="$PWD/out/bml_el30_out"
      BUILD_PLATFORM="CM7.EL30"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      UPDATE_CWMSCRIPT
      PACKAGE_BML_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
	;;
  #Compile Kernel for Touch Wiz MTD
    "3" )
    #Platform Specific Variables
      DEFCONFIG_STRING=cleangb_mtd_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd"
      RECOVERY_INITRD="$PWD/recovery/recovery_mtd"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_mtd"
      BUILD_OUT="$PWD/out/mtd_out"
      BUILD_PLATFORM="TW.MTD"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG "$KERNEL_PATH" "$KERNEL_INITRD" "$RECOVERY_INITRD"
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
    ;;
  #Compile Kernel for MIUI MTD
    "4" )
    #Platform Specific Variables
      DEFCONFIG_STRING=cyanogenmod_epicmtd_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/miui_cm7"
      RECOVERY_INITRD="$PWD/recovery/recovery_miui"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_miui"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
      BUILD_OUT="$PWD/out/miui_out"
      BUILD_PLATFORM="MIUI.MTD"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG "$KERNEL_PATH" "$KERNEL_INITRD" "$RECOVERY_INITRD"
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
    ;;
  #Compile Kernel for CM7 MTD
    "7" )
    #Platform Specific Variables
      DEFCONFIG_STRING=cyanogenmod_epicmtd_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/miui_cm7"
      RECOVERY_INITRD="$PWD/recovery/recovery_cm7"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_cm7"
      BUILD_OUT="$PWD/out/cm7_out"
      BUILD_PLATFORM="CM7.MTD"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG "$KERNEL_PATH" "$KERNEL_INITRD" "$RECOVERY_INITRD"
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
    ;;
  #Compile Kernel for CM9 MTD
    "9" )
    #Platform Specific Variables
      DEFCONFIG_STRING=cyanogenmod_epicmtd_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/cm9"
      RECOVERY_INITRD="$PWD/recovery/recovery_cm9"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_cm9"
      BUILD_OUT="$PWD/out/cm9_out"
      BUILD_PLATFORM="CM9.MTD"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG_CM9
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
    ;;
    "G" | "g" )
    #Git Helper Menu
      GIT_HELPER
    ;;
    "X" | "x" )
      echo $rst
      exit	
    ;;
    * )
      echo $bld$red"**********************You*Have*Entered*An*Incorrect*Option**********************"
      ./build_kernel.sh
    ;;
  esac

