
# Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»

## Задача 1

Сценарий выполнения задачи:
- Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
- Если dockerhub недоступен создайте файл /etc/docker/daemon.json с содержимым: ```{"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]}```
  #### Скриншот 1.
  
  ![01](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/01.png?raw=true)
  
- Зарегистрируйтесь и создайте публичный репозиторий  с именем "custom-nginx" на https://hub.docker.com (ТОЛЬКО ЕСЛИ У ВАС ЕСТЬ ДОСТУП);

#### Скриншот 2.

![02](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/02.png?raw=true)

- скачайте образ nginx:1.21.1;

#### Скриншот 3.

![03](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/03.png?raw=true)
  
- Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
```
- Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 (ТОЛЬКО ЕСЛИ ЕСТЬ ДОСТУП).

  #### Скриншот 4.

  ![04](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/04.png?raw=true)
  
- Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .

#### Ответ:

[Репозиторий hub.docker](https://hub.docker.com/repository/docker/dobranet1/cistom-nginx/general)


## Задача 2
1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
- имя контейнера "ФИО-custom-nginx-t2"
- контейнер работает в фоне
- контейнер опубликован на порту хост системы 127.0.0.1:8080

#### Скриншот 2-01.

![2-01](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/2-01.png?raw=true)

2. Не удаляя, переименуйте контейнер в "custom-nginx-t2"

#### Скриншот 2-02.

![2-02](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/2-02.png?raw=true)

3. Выполните команду ```date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html```

#### Скриншот 2-03.

![2-03](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/2-03.png?raw=true)
  
4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.

#### Скриншот 2-04.

![2-04](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/2-04.png?raw=true)

![2-04.1](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/2-5.png?raw=true)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.


## Задача 3
1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.

#### Скриншот 3-02.

![3-02](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-02.png?raw=true)


3. Выполните ```docker ps -a``` и объясните своими словами почему контейнер остановился.

#### Скриншот 3-03.

![3-03](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-03.png?raw=true)

#### Ответ:

Контейнер остановился потому, что при подключении через docker attach мы подключились к основному процессу nginx (PID 1). Когда мы нажали Ctrl-C, сигнал SIGINT был отправлен процессу nginx, который завершил его работу. Поскольку в контейнере Docker процесс с PID 1 является основным, его завершение приводит к остановке всего контейнера.


4. Перезапустите контейнер

#### Скриншот 3-04.

![3-04](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-04.png?raw=true)

5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.

#### Скриншот 3-05.

![05](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-05.png?raw=true)

6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.

#### Скриншот 3-06.

![3-06](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-06.png?raw=true)

7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".

#### Скриншот 3-07.

![3-07](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-07.png?raw=true)

8. Запомните(!) и выполните команду ```nginx -s reload```, а затем внутри контейнера ```curl http://127.0.0.1:80 ; curl http://127.0.0.1:81```.

#### Скриншот 3-08.

![3-08](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-08.png?raw=true)

9. Выйдите из контейнера, набрав в консоли  ```exit``` или Ctrl-D.
10. Проверьте вывод команд: ```ss -tlpn | grep 127.0.0.1:8080``` , ```docker port custom-nginx-t2```, ```curl http://127.0.0.1:8080```. Кратко объясните суть возникшей проблемы.

#### Скриншот 3-10.

![3-10](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-10.png?raw=true)

#### Ответ:
Т.к. при запуске контейнера я указывал -p 127.0.0.1:8080:80 то переадрисация идет на 80 порт, так же по заданию 7 я отредактировал файл конфигурации и изменил порт с 80 на 81. поэтому не работает теперь.


11. * Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно. [пример источника](https://www.baeldung.com/linux/assign-port-docker-container)

```
Список команд поочередно
docker stop custom-nginx-t2
# id container - 7afda6ddbf4b8c34e5d856a863b06a57bc0148a9d5ac44dbc23d422ddc716a0a
systemctl stop docker
sudo nano /var/lib/docker/containers/7afda6ddbf4b8c34e5d856a863b06a57bc0148a9d5ac44dbc23d422ddc716a0a/hostconfig.json #screenshot 3.11.1
sudo nano /var/lib/docker/containers/7afda6ddbf4b8c34e5d856a863b06a57bc0148a9d5ac44dbc23d422ddc716a0a/config.v2.json #screenshot 3.11.2
systemctl start docker
docker start custom-nginx-t2 #screenshot 3.11.3
docker ps
```
#### Скриншот 3-11.

![3-11.1](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-11.1.png?raw=true)

![3-11.2](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-11.2.png?raw=true)

![3-11.3](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-11.3.png?raw=true)

12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)

#### Скриншот 3-12.

![3-12](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/3-12.png?raw=true)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.

## Задача 4


- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера, используя ключ -v.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера.

#### Скриншот 4-01.

![4-01](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/4-01.png?raw=true)

- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в текущий каталог ```$(pwd)``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

#### Скриншот 4-02.

![4-02](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/4-02.png?raw=true)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.


## Задача 5

1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него.
"compose.yaml" с содержимым:
```
version: "3"
services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
"docker-compose.yaml" с содержимым:
```
version: "3"
services:
  registry:
    image: registry:2

    ports:
    - "5000:5000"
```

И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )

#### Ответ:

Согласно документации Docker Compose ищет файлы в порядке: compose.yaml, compose.yml, docker-compose.yaml, docker-compose.yml

#### Скриншот 5-01.

![5-01](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-01.png?raw=true)

2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)

#### Скриншот 5-02.

![5-02](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-02.png?raw=true)


3. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/

#### Скриншот 5-03.

![5-03](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-04.png?raw=true)

4. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)
5. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local  окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:

```
version: '3'

services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```

#### Скриншот 5-05.

![5-05](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-05.png?raw=true)

6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".


#### Скриншот 5-06.

![5-06.1](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-06.1.png?raw=true)

![5-06.2](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-06.2.png?raw=true)

7. Удалите любой из манифестов компоуза(например compose.yaml).  Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.

#### Скриншот 5-07.

![5-07](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-07.png?raw=true)

![5-08](https://github.com/yojihc/netology-Virtualization/blob/14-virtd-03-docker/pics/5-08.png?raw=true)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод, файл compose.yaml , скриншот portainer c задеплоенным компоузом.

---

### Правила приема

Домашнее задание выполните в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.


