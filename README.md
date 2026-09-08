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

[manifest_link]()

<details>
<summary> kubectl describe pods data-exchange </summary>

user@dobranet src % kubectl describe pod data-exchange-5d7897c454-xfmkj
Name:             data-exchange-5d7897c454-xfmkj
Namespace:        default
Priority:         0
Service Account:  default
Node:             kubectl/10.130.0.19
Start Time:       Tue, 08 Sep 2026 16:47:30 +0300
Labels:           app=data-exchange
                  pod-template-hash=5d7897c454
Annotations:      cni.projectcalico.org/containerID: 8a4a76d8151e6fc3ffb830e10dfe1ff13cf21ca16993673046e585616c7f8e74
                  cni.projectcalico.org/podIP: 10.1.92.117/32
                  cni.projectcalico.org/podIPs: 10.1.92.117/32
Status:           Running
IP:               10.1.92.117
IPs:
  IP:           10.1.92.117
Controlled By:  ReplicaSet/data-exchange-5d7897c454
Containers:
  busybox:
    Container ID:  containerd://2b9d2820c8b4ac2ddbc480ed63576392257722ccfe720aadbe13c0fbc0e90444
    Image:         busybox:1.36
    Image ID:      docker.io/library/busybox@sha256:73aaf090f3d85aa34ee199857f03fa3a95c8ede2ffd4cc2cdb5b94e566b11662
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
      -c
    Args:
      while true; do echo $(date) >> /var/log/share/data.txt; sleep 5; done
    State:          Running
      Started:      Tue, 08 Sep 2026 16:47:31 +0300
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/share from storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-nk4f9 (ro)
  network-multitool:
    Container ID:   containerd://a54820719769b3488550e66d38c80f64d46813b3a2fcd7105a43409c3b831002
    Image:          wbitt/network-multitool
    Image ID:       docker.io/wbitt/network-multitool@sha256:db2810fe2c8d36db074eab5d98fbf861c8ed55e0786d648d3477b3de9135632e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 08 Sep 2026 16:47:32 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      HTTP_PORT:  8080
    Mounts:
      /var/data/read from storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-nk4f9 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  storage:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-nk4f9:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  0s    default-scheduler  Successfully assigned default/data-exchange-5d7897c454-xfmkj to kubectl
  Normal  Pulled     0s    kubelet            Container image "busybox:1.36" already present on machine and can be accessed by the pod
  Normal  Created    0s    kubelet            Container created
  Normal  Started    0s    kubelet            Container started
  Normal  Pulling    0s    kubelet            Pulling image "wbitt/network-multitool"
  Normal  Pulled     0s    kubelet            Successfully pulled image "wbitt/network-multitool" in 849ms (849ms including waiting). Image size: 96718848 bytes.
  Normal  Created    0s    kubelet            Container created
  Normal  Started    0s    kubelet            Container started
user@dobranet src % 

</details>

### Screenshot 1-01 "описание пода с контейнерами"

![1-01]()

### Screenshot 1-02 "описание пода с контейнерами"

![1-02]()

### Screenshot 1-03 "вывод команды чтения файла"

![1-03]()
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

[manifest_link]()

### Screenshot 2 "каждый шаг выполнения задания, начиная с шага 2"

![2-01]()
![2-02]()
![2-03]()

```bash
После удаления deploymnet и pvc, pv ушел в статус released т.к. в манифесте pv указано "persistentVolumeReclaimPolicy: Retain" что указывает k8s что после удаления pvc сам storage и данные на нем уничтожать нельзя.
```

![2-04]()

```bash
По пути /tmp/k8s-local-data/ на ВМ лежит файл shared.txt в который были записи каждые 5 секунд,  после удаления pv файл остался на своем месте, это связано с тем что hostPat использует директорию ОС, которой k8s не управляет.
```
![2-05]()

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

[manifest_link]()

### Screenshot 3 "каждый шаг выполнения задания, начиная с шага 2"

![3-01]()
![3-02]()
![3-03]()
