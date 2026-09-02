# Домашнее задание к занятию «Запуск приложений в K8S»

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.

<details>
<summary> deployment.yaml </summary>

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-multitool
  labels:
    app: web-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx:stable
        ports:
        - containerPort: 80
      - name: multitool
        image: wbitt/network-multitool
        ports:
        - containerPort: 1180 
        env:
        - name: HTTP_PORT # решение конфликта портов 
          value: "1180" 

```

</details>

### pic 01

![01](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/01.png?raw=true)

2. После запуска увеличить количество реплик работающего приложения до 2.

### Ответ:

Нужно поменять в строке кол-во реплик с 1 на 2 

```yaml

spec:
  replicas: 2

```

3. Продемонстрировать количество подов до и после масштабирования.

### pic 02

![02](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/02.png?raw=true)

4. Создать Service, который обеспечит доступ до реплик приложений из п.1.

<details>

<summary> service.yaml </summary>

```yaml

apiVersion: v1
kind: Service
metadata:
  name: web-app-svc
spec:
  selector:
    app: web-app
  ports:
    - name: nginx-port
      protocol: TCP
      port: 80          
      targetPort: 80    

    - name: multitool-port
      protocol: TCP
      port: 1180        
      targetPort: 1180  

```

</details>

### pic 03

![03-1](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/03-1.png?raw=true)

![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/03.png?raw=true)

5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

<details>

<summary> pod.yaml </summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: client-multitool
spec:
  containers:
  - name: multitool
    image: wbitt/network-multitool

```

</details>

### pics 04

![04](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/04.png?raw=true)

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.

<details>

<summary> depploy-init.yaml </summary>

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-init-deployment
  labels:
    app: nginx-conditional
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-conditional
  template:
    metadata:
      labels:
        app: nginx-conditional
    spec:
      initContainers:
      - name: wait-for-svc
        image: busybox:1.36
        command: ['sh', '-c', 'until nslookup nginx-conditional-svc.default.svc.cluster.local.; do echo waiting for service; sleep 2; done']
      containers:
      - name: nginx
        image: nginx:stable
        ports:
        - containerPort: 80

```

</details>

2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.

### pic 05

![05](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/05.png?raw=true)

3. Создать и запустить Service. Убедиться, что Init запустился.

<details>

<summary> service-init.yaml </summary>

```yaml

apiVersion: v1
kind: Service
metadata:
  name: nginx-conditional-svc
spec:
  selector:
    app: nginx-conditional
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80

```

</details>

4. Продемонстрировать состояние пода до и после запуска сервиса.

### pic 06

![06](https://github.com/yojihc/netology-Virtualization/blob/k8s-03/pics/06.png?raw=true)

------

### Правила приема работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов.
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------
