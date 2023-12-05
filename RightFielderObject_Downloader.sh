#!/bin/bash
################## RightFielderObject #################

#################### Set Variables ####################

# License string
license="your_license"

# Release version
release_version="latest"  

# Target directory - where you want to download files to; The default is current directory.   
target_directory=$PWD

# Program directory - where you put MelissaUpdater.exe; The default is current directory.
# Melissa Updater source code: https://github.com/MelissaData/MelissaUpdater
# Melissa Updater binary download link: https://releases.melissadata.net/Download/Library/LINUX/NET/ANY/latest/MelissaUpdater
program_directory="$target_directory/MelissaUpdater"
program_path="$program_directory/MelissaUpdater"


##################### Functions #######################
 
Get-File() 
{
    path="$target_directory/$6" 
    
    verifyPath="$target_directory/$6/$1"
    $program_path verify --path $verifyPath
    
    if [ $? -eq 0 ];
    then
        eval "$program_path file --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    else
        eval "$program_path file --force --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    fi
}

Get-Manifest() 
{
    path="$target_directory/$2"

    eval "$program_path manifest --product $1 --release_version $release_version --license $license --target_directory $path "
}

######################## Main #########################

###################
# Section 1: Data #
###################

# RightFielder Object Data
target_path="Data"
Get-Manifest "rf_data" $target_path

######################
# Section 2: Objects #
######################

# RightFielder Object 
target_path="Objects"
Get-File "libmdRightFielder.so" "BINARY" "LINUX" "GCC41" "64BIT" $target_path

#######################
# Section 3: Wrappers #
#######################

# GeoCoder Object Wrappers
target_path="Wrappers"
Get-Manifest "rf_wrappers" $target_path
