# Домашнее задание к занятию 1 «Disaster recovery и Keepalived»

### Цель задания
В результате выполнения этого задания вы научитесь:
1. Настраивать отслеживание интерфейса для протокола HSRP;
2. Настраивать сервис Keepalived для использования плавающего IP

------

### Чеклист готовности к домашнему заданию

1. Установлена программа Cisco Packet Tracer
2. Установлена операционная система Ubuntu на виртуальную машину и имеется доступ к терминалу
3. Сделан клон этой виртуальной машины, они находятся в одной подсети и имеют разные IP адреса
4. Просмотрены конфигурационные файлы, рассматриваемые на лекции, которые находятся по [ссылке](1/)


------


### Задание 1
- Дана [схема](1/hsrp_advanced.pkt) для Cisco Packet Tracer, рассматриваемая в лекции.
- На данной схеме уже настроено отслеживание интерфейсов маршрутизаторов Gi0/1 (для нулевой группы)
- Необходимо аналогично настроить отслеживание состояния интерфейсов Gi0/0 (для первой группы).
- Для проверки корректности настройки, разорвите один из кабелей между одним из маршрутизаторов и Switch0 и запустите ping между PC0 и Server0.
- На проверку отправьте получившуюся схему в формате pkt и скриншот, где виден процесс настройки маршрутизатора.


#### Ответ: 

#### Скришот 1: 

![1](https://github.com/yojihc/netology-Virtualization/blob/10-01-Disaster-recovery-и-Keepalived/pics/01.JPG?raw=true)

------


### Задание 2
- Запустите две виртуальные машины Linux, установите и настройте сервис Keepalived как в лекции, используя пример конфигурационного [файла](1/keepalived-simple.conf).
- Настройте любой веб-сервер (например, nginx или simple python server) на двух виртуальных машинах
- Напишите Bash-скрипт, который будет проверять доступность порта данного веб-сервера и существование файла index.html в root-директории данного веб-сервера.
- Настройте Keepalived так, чтобы он запускал данный скрипт каждые 3 секунды и переносил виртуальный IP на другой сервер, если bash-скрипт завершался с кодом, отличным от нуля (то есть порт веб-сервера был недоступен или отсутствовал index.html). Используйте для этого секцию vrrp_script
- На проверку отправьте получившейся bash-скрипт и конфигурационный файл keepalived, а также скриншот с демонстрацией переезда плавающего ip на другой сервер в случае недоступности порта или файла index.html

#### Ответ: 

#### Скриншот 2:

![2](https://github.com/yojihc/netology-Virtualization/blob/10-01-Disaster-recovery-и-Keepalived/pics/03.JPG?raw=true)

#### Скришотр 3:
После выключения ВМ1(Мастер) проверяем переключение на BACKUP

![3](https://github.com/yojihc/netology-Virtualization/blob/10-01-Disaster-recovery-и-Keepalived/pics/04.JPG?raw=true)

#### Скрипт:

```bash
#!/bin/bash

SERVER_IP="127.0.0.1" 
PORT=80               
FILE="/var/www/html/index.html"

if ! nc -z "$SERVER_IP" "$PORT"; then
   echo "Port close"
   exit 1
fi

if [[ ! -f "$FILE" ]]; then
   echo "file not found"
   exit 1
fi

exit 0
```

#### config keepalived MASTER

```bash
vrrp_instance VI_1 {
    state MASTER          
    interface enp0s3        
    virtual_router_id 35  
    priority 255          
    advert_int 1          
    

    virtual_ipaddress {
        192.168.33.5/24     
    }

    track_script {
        bash_script     
    }
}

vrrp_script bash_script {
    script "/home/yoji/web.sh"       
    interval 3                        
    fall 2                            
    rise 1                            
}
```


#### Config keepalived BACKUP:

```bash
vrrp_instance VI_1 {
    state BACKUP
    interface enp0s3        
    virtual_router_id 35  
    priority 90          
    advert_int 1          
    
    

    virtual_ipaddress {
        192.168.33.5/24     
    }

    track_script {
        bash_script
    }
}

vrrp_script bash_script {
    script "/home/yoji/web.sh"       
    interval 3                        
    fall 2                            
    rise 1                            
}
```
------
