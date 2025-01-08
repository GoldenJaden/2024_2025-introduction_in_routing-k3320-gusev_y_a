#!/bin/bash
intIP=172.31.255.30

wait_ssh() {
    printf "Waiting for ssh: "
    SSH_UP=0
    while [ $SSH_UP -eq 0 ]
    do
        printf "."
        SSH_UP=$(wget --timeout=1 --tries=1 $intIP:22 2>&1 | grep -c Read);
    done
    printf " SSH UP"
}

wait_ssh