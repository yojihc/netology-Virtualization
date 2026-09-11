# Домашнее задание к занятию «Helm»


### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

### Screenshots:

![01](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/01.png?raw=true)

![02](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/02.png?raw=true)

![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/03.png?raw=true)

![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/04.png?raw=true)

------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

### Screenshots:

![04](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/05.png?raw=true)

![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/06.png?raw=true)

![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-07/pics/07.png?raw=true)
