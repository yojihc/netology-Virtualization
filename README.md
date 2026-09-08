# Домашнее задание к занятию «Хранение в K8s»

### Примерное время выполнения задания — 180 минут

------

## Задание 1. Volume: обмен данными между контейнерами в поде
### Задача

Создать Deployment приложения, состоящего из двух контейнеров, обменивающихся данными.

### Шаги выполнения
1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Настроить busybox на запись данных каждые 5 секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.


### Что сдать на проверку
- Манифесты:
  - `containers-data-exchange.yaml`
- Скриншоты:
  - описание пода с контейнерами (`kubectl describe pods data-exchange`)
  - вывод команды чтения файла (`tail -f <имя общего файла>`)

### Ответ:

[manifest_link](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/src/containers-data-exchange.yaml)

### Screenshot 1-01 "описание пода с контейнерами"

![1-01](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/1-01.png?raw=true)

### Screenshot 1-02 "описание пода с контейнерами"

![1-02](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/1-02.png?raw=true)

### Screenshot 1-03 "вывод команды чтения файла"

![1-03](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/1-03.png?raw=true)
------

## Задание 2. PV, PVC
### Задача
Создать Deployment приложения, использующего локальный PV, созданный вручную.

### Шаги выполнения
1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool, использующего созданный ранее PVC
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что контейнер multitool может читать данные из файла в смонтированной директории, в который busybox записывает данные каждые 5 секунд. 
4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему. (Используйте команду `kubectl describe pv`).
5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать, что произошло с файлом после удаления PV. Пояснить, почему.


### Что сдать на проверку
- Манифесты:
  - `pv-pvc.yaml`
- Скриншоты:
  - каждый шаг выполнения задания, начиная с шага 2.
- Описания:
  - объяснение наблюдаемого поведения ресурсов в двух последних шагах.

### Ответ:

[manifest_link](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/src/pv-pvc.yaml)

### Screenshot 2 "каждый шаг выполнения задания, начиная с шага 2"

![2-01](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/2-01.png?raw=true)
![2-02](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/2-02.png?raw=true)
![2-03](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/2-03.png?raw=true)

```bash
После удаления deploymnet и pvc, pv ушел в статус released т.к. в манифесте pv указано "persistentVolumeReclaimPolicy: Retain" что указывает k8s что после удаления pvc сам storage и данные на нем уничтожать нельзя.
```

![2-04](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/2-04.png?raw=true)

```bash
По пути /tmp/k8s-local-data/ на ВМ лежит файл shared.txt в который были записи каждые 5 секунд,  после удаления pv файл остался на своем месте, это связано с тем что hostPat использует директорию ОС, которой k8s не управляет.
```
![2-05](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/2-05.png?raw=true)

------

## Задание 3. StorageClass
### Задача
Создать Deployment приложения, использующего PVC, созданный на основе StorageClass.

### Шаги выполнения

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool, использующего созданный ранее PVC.
2. Создать SC и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что контейнер multitool может читать данные из файла в смонтированной директории, в который busybox записывает данные каждые 5 секунд.

### Что сдать на проверку
- Манифесты:
  - `sc.yaml`
- Скриншоты:
  - каждый шаг выполнения задания, начиная с шага 2
---
### Ответ:

[manifest_link](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/src/sc.yaml)

### Screenshot 3 "каждый шаг выполнения задания, начиная с шага 2"

![3-01](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/3-01.png?raw=true)
![3-02](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/3-02.png?raw=true)
![3-03](https://github.com/yojihc/netology-Virtualization/blob/k8s-05/pics/3-03.png?raw=true)
