#!/bin/bash

str="${@}"

process=${str:0:4}

arguments=${str:5}
ary=($arguments)

# Parse browser
for i in "${!ary[@]}"
    do
        if [[ "${ary[$i]}" == "BROWSER"* ]]
        	then
        	browser=${ary[$i]:8}
        elif [[ "${ary[$i]}" == *"Tests"* || "${ary[$i]}" == *"tests"* ]]
        	then
        	# Replace test path with remote url
        	test_path="${ary[$i]}"
        	ary[$i]="-v REMOTE_URL:http://localhost:5700/wd/hub"
        fi
    done

# Append Test path to array
ary+=(${test_path})

# Join array to single string
arg=$(printf " %s" "${ary[@]}")
arg=${arg:1}

if [[ $browser == "gc" ]]
	then
	node_type="chrome"
	shm=""
else
	node_type="firefox"
	shm="--shm-size=384m"
fi

# Get number of processes
if [[ $process == -p* ]]
	then
	p=${process:2}
else
	echo "provide number of processes"
	exit
fi

# Start hub and nodes
hub_cmd="docker run -d --shm-size=512m -e 'TZ=Asia/Calcutta' -p 5700:4444 --name selenium-hub selenium/hub"
echo "Starting Hub"
eval ${hub_cmd}

echo "Starting nodes"
for i in $(seq 1 $p)
	do
		node_cmd="docker run -d ${shm} -e 'TZ=Asia/Calcutta' --link selenium-hub:hub selenium/node-${node_type}"
		eval  ${node_cmd}
		sleep 0.5
	done

# Run using pybot or pabot
if [[ $p -eq "1" ]]
	then
	pybot_cmd="pybot $arg"
	eval ${pybot_cmd}
else
	pabot_cmd="pabot --processes $p $arg"
	echo ${pabot_cmd}
	eval ${pabot_cmd}
fi

# Cleanup
stop_all_containers="docker stop $(docker ps -aq)"
remove_all_containers="docker rm $(docker ps -aq)"
eval ${stop_all_containers}
eval ${remove_all_containers}
