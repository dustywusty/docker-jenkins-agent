#!/bin/bash

cat << EOF

jenkins-slave

EOF

# ..

set_env () {
	while [ -z "${agent_name}" ]; do
	        read -p "agent name: " temp_agent_name
	        if [ ! -z ${temp_znc_user} ]; then
	        	agent_name=${temp_agent_name}
	        fi
	done

	while [ -z "${jenkins_url}" ]; do
	        read -p "jenkins url: " temp_jenkins_url
	        if [ ! -z ${temp_znc_pass} ]; then
	        	jenkins_url=${temp_jenkins_url}
	        fi
	done

	save_env
}

# ..

save_env () {
	while true; do
	    read -p "save and build docker image? y/n " yn
	    case $yn in
	        [Yy]* ) build_image_start_container; break;;
	        [Nn]* ) exit;;
	        * ) echo "[y]es or [n]o";;
	    esac
	done
}

# ..

build_image_start_container () {
	docker.io build -t dusty/jenkins-agent github.com/clarkda/docker-jenkins-agent.git &&
	docker.io run -d dusty/jenkins-agent
}

# ..

command -v docker.io >/dev/null 2>&1 || { echo -e >&2 "I require docker but it's not installed. \n\nAborting!\n"; exit 1; }

set_env