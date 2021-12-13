# log4shell CVE-2021-44228 - demo :)

### 1. Run log4shell vuln app

**podman run  -p 8080:8080 quay.io/apoczeka/log4shell-vuln:latest**

### 2. Run "exploit server"

**podman run -p 1389:1389 -p 8888:8888  quay.io/apoczeka/log4shell -i <host_address> -l 1389 -p 8888**

###### <host_address> is your host machine address from WIFI or LAN interface

###### If you run it on a computer that has the address 192.168.50.100 you should run:

###### podman run -p 1389:1389 -p 8888:8888  quay.io/apoczeka/log4shell -i 192.168.50.100 -l 1389 -p 8888



