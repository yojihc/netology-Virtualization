### Задание

### Задание 1. Создать Pod с именем hello-world

1.Создать манифест (yaml-конфигурацию) Pod.

### Screenshot 01

![01](https://github.com/yojihc/netology-Virtualization/blob/k8s-02/pics/1-01.png?raw=true)

2.Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3.Подключиться локально к Pod с помощью kubectl port-forward и вывести значение (curl или в браузере).

### Screenshot 03

![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-02/pics/1-03.png?raw=true)


### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.

### Screenshot - 04

![04](https://github.com/yojihc/netology-Virtualization/blob/k8s-02/pics/2-01.png?raw=true)
  
4. Подключиться локально к Service с помощью kubectl port-forward и вывести значение (curl или в браузере).

### Screenshot 05

![05](https://github.com/yojihc/netology-Virtualization/blob/k8s-02/pics/2-04.png?raw=true)

Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода команд kubectl get pods, а также скриншот результата подключения.
Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.
Правила приема работ
