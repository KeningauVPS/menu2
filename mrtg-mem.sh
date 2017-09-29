#!/bin/bash

FREE=`free -m | grep "buffers/cache" | awk '{print $3}'`
SWAP=`free -m | grep "Swap" | awk '{print $3}'`
UP=`uptime`

echo -e "\e[37;1m ==\e[34;1m[Free:\e[32;1m $FREE]\e[37;1m=="
echo -e "\e[37;1m ==\e[34;1m[Swap:\e[32;1m $SWAP]\e[37;1m=="
echo -e "\e[37;1m ==\e[34;1m[Uptime:\e[32;1m $UP]\e[37;1m=="

