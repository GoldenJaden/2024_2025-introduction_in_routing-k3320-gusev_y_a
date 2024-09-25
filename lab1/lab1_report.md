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

## Конфигурация

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

С помощью `containerlab graph` была построена следующая схема лабы:

![Screenshot_4](https://github.com/user-attachments/assets/ece3d7db-5d8d-4e4f-ac75-adec20923c59)

## Проверка работоспособности

С коммутатора 2 (влан2) пингуем роутер по его айпи во влане 2. Все проходит успешно:

![Screenshot_3](https://github.com/user-attachments/assets/d3428ad0-ab2e-4d81-ab04-5a322c1d1a9a)

С PC02 пингуем роутер по айпишнику во влане 1: пинг не проходит. Во влане 2 пинг успешно проходит.

![image](https://github.com/user-attachments/assets/6325721c-7b24-4cc7-b090-914a2d186fdc)

С PC01 аналогичная ситуация:

![image](https://github.com/user-attachments/assets/83643dea-f357-49ea-b7ca-cd8630dbf877)

С одного ПК на другой пинг так же не идет:

![image](https://github.com/user-attachments/assets/869877d2-04c2-4d37-b50a-02eb29453bda)




