#!/bin/bash

# define colors
green="\e[92m"
yellow="\e[93m"
red="\e[91m"
blue="\e[94m"
default="\e[39m"

function usage(){
	echo -e $red"Usage : $0 [-n <name ...>]. Type -h or --help for more info"
}

function help(){
	echo -e $yellow"Full usage: $0 [-p <path>][-n <name ...>] [-m][-c][-s]
Script is aimed to provide set of easy commands in order to create components,
services and modules for Angular projects

Mandatory arguments to long options are mandatory for short options too.
  -p                         provides path for created item, requires file path as an argument 
                             can be used only as $0 [-p <path>][-n <name ...>]
  -n                         creates components, services or modules of specified names,
                             requires file name or names as an argument, if one or combination 
                             of [-m][-c][-s] are not specified uses [-c] as a default flag 
                             if [-p <path>] is not specified takes src/app as default path
  -m, --module               creates module or modules of a given name or names
                             item will contain component and routing module
                             minimum usage is $0 [-n <name ...>][-m]
  -c, --component            creates component or components of a given name or names
                             minimum usage is $0 [-n <name ...>][-c]
  -s, --service              creates service or services of a given name or names
                             minimum usage is $0 [-n <name ...>][-s]
  -h, --help                 display this help and exit

Exit status:
 0  if OK,
 1  if minor problems (e.g., cannot access subdirectory),
 2  if serious trouble (e.g., cannot access command-line argument).
 
 Copyright 2017 Nurlan Ilyas."
}

function create(){

	#declarations
	module=1
	component=2
	service=4
	
	path=$1
	names=$2
	mask=$3
	
	for name in $names
	do
		
		#path and name
		path_name=$path$name

		# module path
		module_path=$path_name/modules/$name
		
		# bind module
		bind=
		
		# module flag is activated
		if [ $(($mask & $module)) -gt 0 ]
		then
			echo -e "executing: $green ng g module $module_path --routing --flat $yellow";
			ng g module $module_path --routing --flat;
			bind=" --module $module_path"
		fi
	
		# component flag is activated
		if [ $(($mask & $component)) -gt 0 ]
		then
			echo -e "executing: $green ng g c $path_name $bind $yellow";
			ng g c $path_name $bind;
		fi
		
		# service flag is activated
		if [ $(($mask & $service)) -gt 0 ]
		then
			echo -e "executing: $green ng g service $path_name/$name $bind $yellow";
			ng g service $path_name/services/$name $bind;
		fi
		
	done
}

p_flag=1
n_flag=2
opt_mask=0

m_flag=1
c_flag=2
s_flag=4
flag_mask=0

path=
name=

while getopts :n:p:-:hmcs parm ; do
case $parm in
	p)			
				path=${OPTARG};
				opt_mask=$(($opt_mask | 1 )) 
				;;
	n)	
				name=${OPTARG};
				opt_mask=$(($opt_mask | 2 ));
				;;
	:)
				echo -e $red"Option -$OPTARG requires an argument. Type -h or --help for more info" >&2
				exit 1
				;;
	h)			help
				;;
	m)			flag_mask=$(($flag_mask | 1 )) 
				;;	
	c)			flag_mask=$(($flag_mask | 2 )) 
				;;
	s)			flag_mask=$(($flag_mask | 4 )) 
				;;
	-)
				case ${OPTARG} in
						"help") 
									help
									;;
						"module") 
									flag_mask=$(($flag_mask | 1 )) 
									;;
						"component") 
									flag_mask=$(($flag_mask | 2 )) 
									;;
						"service") 
									flag_mask=$(($flag_mask | 4 )) 
									;;
				esac;;
	*)
		usage	
		echo -e $red"Invalid argument. Type -h or --help for more info"
		;;
esac
done

if [ $opt_mask -eq 1 ] # means if only -p path was specified
then
    echo -e $red"Usage : $0 [-p <path>][-n <name>] where [-n <name>] is required. Type -h or --help for more info" >&2
    exit 1
fi


shift $((OPTIND-1))


# check is path is legal
case "$path" in  
     *\ * )
           echo -e $red"Cannot use multiple paths or space in path. Type -h or --help for more info"  >&2
		   exit 1
          ;;
esac


# add slash if there is path specified
if [ ${#path} -gt 0 ]
then
	path=$path/
fi


# set default -c option
flag_mask=$(($flag_mask > 0? $flag_mask : 2))


# execute the script
create "$path" "$name" $flag_mask
