#!/bin/bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions

function error() {
    JOB="$0"              # job name
    LASTLINE="$1"         # line of error occurrence
    LASTERR="$2"          # error code
    #echo "ERROR in ${JOB} : line ${LASTLINE} with exit code ${LASTERR}"
    cecho "Stopping  "`basename $0` $red
    exit 1
}

trap 'error ${LINENO} ${?}' ERR
trap ctrl_c INT

black='\E[30;47m'
red='\E[31;47m'
green='\E[32;47m'
yellow='\E[33;47m'
blue='\E[34;47m'
magenta='\E[35;47m'
cyan='\E[36;47m'
white='\E[37;47m'

# Text Reset
resetcolor='\e[0m'      

function ctrl_c() {
	echo
	cecho "Halting  "`basename $0` $red
	exit 0;
}
cecho ()                    
# cecho.
# Argument $1 = message
# Argument $2 = color
{
	message=${1:-"No message passed."}   # Defaults to default message.
	color=${2:-$black}           # Defaults to black, if not specified.
	echo -e "$color-> $message $resetcolor"
}

confirm () {
	if $FORCE; then echo "1";return;fi;
    q=$(cecho "${1:-Doing some stuff} \n-> Are you sure? [Y/n]")
    read -r -p "$q" response
    case $response in
        [yY][eE][sS]|[yY]) 
            echo "1"
            ;;
        *)
            echo "0"
            ;;
    esac
}
