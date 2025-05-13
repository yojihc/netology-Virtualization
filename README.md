# Домашнее задание к занятию «Система мониторинга Zabbix»

### Задание 1 

Установите Zabbix Server с веб-интерфейсом.

#### Процесс выполнения
1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
3. Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
4. Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.

#### Требования к результатам 
1. Прикрепите в файл README.md скриншот авторизации в админке.
2. Приложите в файл README.md текст использованных команд в GitHub.

#### Ответ:

#### Скриншот 1:

![1](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/01.JPG?raw=true)

#### Скриншот 2:

![2](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/02.JPG?raw=true)

#### commands:

```bash
Zabbix install command

sudo -s

b. Install Zabbix repository
Documentation
# wget https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu24.04_all.deb
# dpkg -i zabbix-release_latest_7.2+ubuntu24.04_all.deb
# apt update

c. Install Zabbix server, frontend, agent
# apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

d. Create initial database
Documentation
Make sure you have database server up and running.

Run the following on your database host.

# sudo -u postgres createuser --pwprompt zabbix  # пароль zabbix
# sudo -u postgres createdb -O zabbix zabbix

On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.

# zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

e. Configure the database for Zabbix server
Edit file /etc/zabbix/zabbix_server.conf

DBPassword=password

f. Configure PHP for Zabbix frontend
Edit file /etc/zabbix/nginx.conf uncomment and set 'listen' and 'server_name' directives.

# listen 8080;
# server_name example.com;

g. Start Zabbix server and agent processes
Start Zabbix server and agent processes and make it start at system boot.

# systemctl restart zabbix-server zabbix-agent nginx php8.3-fpm
# systemctl enable zabbix-server zabbix-agent nginx php8.3-fpm

h. Open Zabbix UI web page
The URL for Zabbix UI when using Nginx depends on the configuration changes you should have made.


# Задание 1
systemctl status zabbix-server # Check status
systemctl status zabbix-agent # Check status
systemctl status postgresql # Check status
sudo nano /etc/zabbix/zabbix_server.conf # edit DBPassword
```

---

### Задание 2 

Установите Zabbix Agent на два хоста.

#### Процесс выполнения
1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
5. Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

#### Требования к результатам
1. Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
2. Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
3. Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
4. Приложите в файл README.md текст использованных команд в GitHub


#### Ответ:

#### Скриншот 3:

![3](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/03.JPG?raw=true)

#### Скриншот 4:

![4](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/04.JPG?raw=true)

#### Скриншот 5:

![5](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/05.JPG?raw=true)


#### commands:

```bash
# Задание 2
sudo apt install zabbix-agent # Install agent on VM1 Ubuntu
sudo nano /etc/zabbix/zabbix_agentd.conf # Edit hostname= and Server=
cat /var/log/zabbix-agent/zabbix_agentd.log # Check logs
```
---
## Задание 3 со звёздочкой*
Установите Zabbix Agent на Windows (компьютер) и подключите его к серверу Zabbix.

#### Требования к результатам
1. Приложите в файл README.md скриншот раздела Latest Data, где видно свободное место на диске C:
--- 

#### Ответ:

#### Скриншот 6:

![6](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/06.JPG?raw=true)

#### Скриншот 7:

![7](https://github.com/yojihc/netology-Virtualization/blob/Zabbix-Part-1/pics/07.JPG?raw=true)



