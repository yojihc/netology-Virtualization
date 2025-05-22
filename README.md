# Домашнее задание к занятию 2 «Кластеризация и балансировка нагрузки»


------



### Задание 1
- Запустите два simple python сервера на своей виртуальной машине на разных портах
- Установите и настройте HAProxy, воспользуйтесь материалами к лекции по [ссылке](2/)
- Настройте балансировку Round-robin на 4 уровне.
- На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.
- 
#### Ответ:

#### Скриншот 1:

![1](https://github.com/yojihc/netology-Virtualization/blob/10-2_Clustering_and_load_balancing/pics/01.JPG?raw=true)

#### Скриншот 2:

![2](https://github.com/yojihc/netology-Virtualization/blob/10-2_Clustering_and_load_balancing/pics/02.JPG?raw=true)

#### Файл конфигурации HAproxy:

[a link](https://github.com/yojihc/netology-Virtualization/blob/10-2_Clustering_and_load_balancing/cfg/haproxy%20%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%201.cfg)


### Задание 2
- Запустите три simple python сервера на своей виртуальной машине на разных портах
- Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
- HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
- На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.



---
