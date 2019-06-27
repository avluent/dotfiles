#!/bin/bash

# This Script will build the tmux dev environment
# Input files:
# json file with tmux session, window, pane configuration
# textfile with all packages that need to be installed
# a vifm config file for correct use with tmux

# variables
global_shell="bash"
cmd_line_opts="$@"
tmux_session_h_file="./tmux_session_h.json"
tmux_session_v_file="./tmux_session_v.json"
component_collection_file="./component_collection"
vifm_config_file="./vifm_dev.conf"
global_package_manager=
sdkman_install_dir="/home/${USER}/.sdkman"
sdkman_install_cmd='curl -s "https://get.sdkman.io" | '"${global_shell}"' && source '"${sdkman_install_dir}"'/bin/sdkman-init.sh'
log_path="./log.txt"

# functions
discoverPackageManager() {
	# test which package manager is available
	if [ $(which apt) ]; then
		global_package_manager="apt"
		log ${FUNCNAME[0]} "Package manager is apt"
	elif [ $(which yum) ]; then
		global_package_manager="yum"
		log ${FUNCNAME[0]} "Package manager is yum"
	elif [ $(which dnf) ]; then
		global_package_manager="dnf"
		log ${FUNCNAME[0]} "Package manager is dnf"
	else
		global_package_manager=""
		log ${FUNCNAME[0]} "No package Manager found"
		exit 1
	fi
	# test if sdk is available on the machine
	# if not, install
	if [ -d $sdkman_install_dir ];then
		log ${FUNCNAME[0]} "SDKMAN! is already installed"
	else
		$global_shell -c "${sdkman_install_cmd}"
		log ${FUNCNAME[0]} "SDKMAN! just finished installing..."
	fi
}
installComponents() {
	# Check the package mangers
	discoverPackageManager

	# Declare the candidates for the global
	# package manager and sdk installations
	global_tool=
	sdk_tool=

	# Load the sdkman-init for current shell
	# and restart
	. $sdkman_install_dir/bin/sdkman-init.sh

	# test if components are installed and add
	# them to the candidate variables above
	while read component; do
		if [[ $component == *";sdkman" ]];then
			tool=$(echo $component | sed 's/;.*$//g')
			if [ $(which $tool) ]; then
				#do nothing
				log ${FUNCNAME[0]} "${tool} is already installed. Nothing to do."
			else
				# append to the global_tool variable
				sdk_tool+=" ${tool}"
			fi
		else
			tool=$(echo $component | sed 's/;//g')
			if [ $(which $tool) ]; then
				#do nothing
				log ${FUNCNAME[0]} "${tool} is already installed. Nothing to do."
			else
				# append to the global_tool variable
				global_tool+=" ${tool}"
			fi
		fi
	done < $component_collection_file
	
	# install the components using the correct
	# package manager
	sudo $global_package_manager update && sudo $global_package_manager install $global_tool -y

	# And install SDKMAN! packages
	for t in $sdk_tool; do
		{ sdk install ${t}; }
	done
}
gitCreate() {
	: # read project info from user and create git repo
}
parseLayout() {
	: # load layout from the json file and prepare vars
}
buildEnv() {
	: # run all the tmux commands to build the environment
}
displayHelp() {
	: # display the help article
}
log() {
	: # write all log entries into a logfile
	echo "$(date) - $1 - $2" >> $log_path
}

# Main code
installComponents
