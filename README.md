# Angular Bash Scripts

Scripts are aimed to automate the process of modules, components and services creation. version 1.0.0

## `./script.sh --help`
Full usage: $0 [-p <path>][-n <name ...>] [-m][-c][-s]
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
 
## Set up Angular Project

First you need to create a new Angular project via `ng g new Project`. Change directory to your project directory via `cd Project`.
Now you can add script to your current directory. In our case it will be Project/script.sh

## Examples

Create multiple components under default src/app directory via `./script -n "home profile settings"`
Create multiple components under src/app/pages directory via `./script -p "pages" -n "home profile settings"`
Create multiple components under src/app/pages directory via `./script -p "pages" -n "home profile settings" --component` or just `./script -p "pages" -n "home profile settings" -c`
Create multiple modules under src/app/pages directory via `./script -p "pages" -n "home profile settings" --module` or just `./script -p "pages" -n "home profile settings" -m`
Create multiple services under src/app/pages directory via `./script -p "pages" -n "home profile settings" --service` or just `./script -p "pages" -n "home profile settings" -s`
Create multiple components and bind them to their local modules under src/app/pages directory via `./script -p "pages" -n "home profile settings" -mc`
Create multiple services and bind them to their local modules under src/app/pages directory via `./script -p "pages" -n "home profile settings" -sm`
Create multiple components, services and bind them to their local modules under src/app/pages directory via `./script -p "pages" -n "home profile settings" -smc`












