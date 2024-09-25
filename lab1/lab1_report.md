University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)
Year: 2024/2025
Group: K3320
Author: Gusev Yaroslav Aleksandrovich
Lab: Lab1
Date of create: 25.09.2024
Date of finished: 25.09.2024

# Лабораторная номер 1

Для начала работы был написан конфиг формата yaml с описанием нод и их связей:

```yaml
name: lab_1

mgmt:
  network: mgmt
  ipv4-subnet: 172.168.10.0/24

topology:
  nodes:
    sw01:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt-ipv4: 172.168.10.2
    sw02:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt-ipv4: 172.168.10.3
    sw03:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt-ipv4: 172.168.10.4
    router:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt-ipv4: 172.168.10.5
    pc01:
      kind: linux
      image: alpine:3.19.0
      mgmt-ipv4: 172.168.10.6
    pc02:
      kind: linux
      image: alpine:3.19.0
      mgmt-ipv4: 172.168.10.7

  links:
    - endpoints: ["sw01:eth2", "router:eth2"]
    - endpoints: ["sw01:eth3", "sw02:eth2"]
    - endpoints: ["sw01:eth4", "sw03:eth2"]

    - endpoints: ["sw02:eth3", "pc01:eth2"]
    - endpoints: ["sw03:eth3", "pc02:eth2"]
```
