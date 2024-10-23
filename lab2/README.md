University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)
Year: 2024/2025
Group: K3320
Author: Gusev Yaroslav Aleksandrovich
Lab: Lab1
Date of create: 25.09.2024
Date of finished: 25.09.2024

# Лабораторная номер 2

## Конфигурация

Для начала работы был написан конфиг формата yaml с описанием нод и их связей:

```yaml
name: lab2
mgmt:
    network: mgmt-net
    ipv4-subnet: 192.168.100.0/24
topology:
    kinds:
        vr-ros:
            image: vrnetlab/mikrotik_routeros:6.47.9
        linux:
            image: alpine:3.20.0
    nodes:
        R01_msk:
            kind: vr-ros
            mgmt-ipv4: 192.168.100.2
            startup-config: configs/R01
            binds:
              - scripts/wait_ssh.sh:/tmp/wait_ssh.sh
            exec:
              - sh /tmp/wait_ssh.sh
        R02_brl:
            kind: vr-ros
            mgmt-ipv4: 192.168.100.3
            startup-config: configs/R02
            binds:
              - scripts/wait_ssh.sh:/tmp/wait_ssh.sh
            exec:
              - sh /tmp/wait_ssh.sh
        R03_frt:
            kind: vr-ros
            mgmt-ipv4: 192.168.100.4
            startup-config: configs/R03
            binds:
              - scripts/wait_ssh.sh:/tmp/wait_ssh.sh
            exec:
              - sh /tmp/wait_ssh.sh
        PC1:
            kind: linux
            binds:
              - scripts/setup_pc.sh:/tmp/setup.sh
            exec:
              - sh /tmp/setup.sh
            stages:
              create:
                wait-for:
                  - node: R01_msk
                    stage: configure 
        PC2:
            kind: linux
            binds:
              - scripts/setup_pc.sh:/tmp/setup.sh
            exec:
              - sh /tmp/setup.sh
            stages:
              create:
                wait-for:
                  - node: R02_brl
                    stage: configure
        PC3:
            kind: linux
            binds:
              - scripts/setup_pc.sh:/tmp/setup.sh
            exec:
              - sh /tmp/setup.sh
            stages:
              create:
                wait-for:
                  - node: R03_frt
                    stage: configure
    links:
        - endpoints: ["R01_msk:eth2", "R02_brl:eth2"]
        - endpoints: ["R01_msk:eth3", "R03_frt:eth3"]
        - endpoints: ["R01_msk:eth4", "PC1:eth2"]
        - endpoints: ["R02_brl:eth3", "R03_frt:eth2"]
        - endpoints: ["R02_brl:eth4", "PC2:eth2"]
        - endpoints: ["R03_frt:eth4", "PC3:eth2"]
```

С помощью `containerlab graph` была построена следующая схема лабы:

рисунок 1

## Проверка работоспособности

С PC01 пингуем PC02 и PC03. Пинг проходит успешно. Также посмотрим traceroute до PC02. Пакет проходит ожидаемый путь (подтверждение этому можно увидеть на рисунке ниже).

рисунок 2

рисунок 3

## Дополнительные моменты

Было добавлено 2 скрипта, первый - для настройки компьютеров:

```bash
apk add dhcpcd traceroute
dhcpcd eth2
sleep 10
ip route del default via 192.168.100.1

ifconfig | grep 192.168.*.50
```

Второй - для ожидания поднятия ssh на роутерах:

```bash
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
```

Так же, с помощью функционала containerlab, ноды PC ожидают поднятия своих роутеров с помощью такой конструкции:
```yaml
stages:
  create:
    wait-for:
      - node: R**
        stage: configure
```


