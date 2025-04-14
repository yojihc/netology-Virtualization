# Домашнее задание к занятию «Что такое DevOps. СI/СD»

---

### Задание 1

**Что нужно сделать:**

1. Установите себе jenkins по инструкции из лекции или любым другим способом из официальной документации. Использовать Docker в этом задании нежелательно.
2. Установите на машину с jenkins [golang](https://golang.org/doc/install).
3. Используя свой аккаунт на GitHub, сделайте себе форк [репозитория](https://github.com/netology-code/sdvps-materials.git). В этом же репозитории находится [дополнительный материал для выполнения ДЗ](https://github.com/netology-code/sdvps-materials/blob/main/CICD/8.2-hw.md).
3. Создайте в jenkins Freestyle Project, подключите получившийся репозиторий к нему и произведите запуск тестов и сборку проекта ```go test .``` и  ```docker build .```.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

#### Ответ:

#### Screenshot 1
![1](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/01.JPG?raw=true)

#### Screenshot 2
![2](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/02.JPG?raw=true)

#### Screenshot 3
![3](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/03.JPG?raw=true)

---

### Задание 2

**Что нужно сделать:**

1. Создайте новый проект pipeline.
2. Перепишите сборку из задания 1 на declarative в виде кода.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

#### Ответ:

#### Screenshot 4
![4](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/04.JPG?raw=true)

#### Screenshot 5
![5](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/05.JPG?raw=true)

#### Screenshot 6
![6](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/06.JPG?raw=true)

#### Screenshot 7
![7](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/07.JPG?raw=true)

---

### Задание 3

**Что нужно сделать:**

1. Установите на машину Nexus.
1. Создайте raw-hosted репозиторий.
1. Измените pipeline так, чтобы вместо Docker-образа собирался бинарный go-файл. Команду можно скопировать из Dockerfile.
1. Загрузите файл в репозиторий с помощью jenkins.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

#### Screenshot 8
![8](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/08.JPG?raw=true)

#### Screenshot 9
![9](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/09.JPG?raw=true)

#### Screenshot 10
![10](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/10.JPG?raw=true)

#### Screenshot 11
![11](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/11.JPG?raw=true)

#### Screenshot 12
![12](https://github.com/yojihc/netology-Virtualization/blob/8-02-Jenkins/pics/12.JPG?raw=true)

---
## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 4*

Придумайте способ версионировать приложение, чтобы каждый следующий запуск сборки присваивал имени файла новую версию. Таким образом, в репозитории Nexus будет храниться история релизов.

Подсказка: используйте переменную BUILD_NUMBER.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.
