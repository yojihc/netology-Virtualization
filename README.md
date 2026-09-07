# Домашнее задание к занятию «Сетевое взаимодействие в Kubernetes»

## **Задание 1: Настройка Service (ClusterIP и NodePort)**
### **Задача**
Развернуть приложение из двух контейнеров (`nginx` и `multitool`) и обеспечить доступ к ним:
- Внутри кластера через **ClusterIP**.
- Снаружи через **NodePort**.

### **Шаги выполнения**
1. **Создать Deployment** с двумя контейнерами:
   - `nginx` (порт `80`).
   - `multitool` (порт `8080`).
   - Количество реплик: `3`.
2. **Создать Service типа ClusterIP**, который:
   - Открывает `nginx` на порту `9001`.
   - Открывает `multitool` на порту `9002`.
3. **Проверить доступность** изнутри кластера:
```bash
 kubectl run test-pod --image=wbitt/network-multitool --rm -it -- sh
 curl <service-name>:9001 # Проверить nginx
 curl <service-name>:9002 # Проверить multitool
```
4. **Создать Service типа NodePort** для доступа к `nginx` снаружи.
5. **Проверить доступ** с локального компьютера:
```bash
 curl <node-ip>:<node-port>
   ```
 или через браузер.

### **Что сдать на проверку**
- Манифесты:
  - `deployment-multi-container.yaml`
  - `service-clusterip.yaml`
  - `service-nodeport.yaml`
- Скриншоты проверки доступа (`curl` или браузер).

###  Ответ:

## Screenshot 01 "ClusterIP curl":

![01]()

![02]()

## Screenshot 01 "Nodeport curl":

![03]()


---
## **Задание 2: Настройка Ingress**
### **Задача**
Развернуть два приложения (`frontend` и `backend`) и обеспечить доступ к ним через **Ingress** по разным путям.

### **Шаги выполнения**
1. **Развернуть два Deployment**:
   - `frontend` (образ `nginx`).
   - `backend` (образ `wbitt/network-multitool`).
2. **Создать Service** для каждого приложения.
3. **Включить Ingress-контроллер**:
```bash
 microk8s enable ingress
   ```
4. **Создать Ingress**, который:
   - Открывает `frontend` по пути `/`.
   - Открывает `backend` по пути `/api`.
5. **Проверить доступность**:
```bash
 curl <host>/
 curl <host>/api
   ```
 или через браузер.

### **Что сдать на проверку**
- Манифесты:
  - `deployment-frontend.yaml`
  - `deployment-backend.yaml`
  - `service-frontend.yaml`
  - `service-backend.yaml`
  - `ingress.yaml`
- Скриншоты проверки доступа (`curl` или браузер).

### Ответ:

<details>

<summary> Причина появления еще одного pod`а </summary>
«В последних версиях MicroK8s по умолчанию вместо Nginx ставится Ingress-контроллер Traefik. Так как Traefik — это принципиально другой контроллер, он полностью игнорирует аннотации Nginx (вроде rewrite-target).В архитектуре Traefik для модификации запросов (изменения заголовков, срезания префиксов, авторизации) вместо текстовых аннотаций используется официальный механизм Middleware через Kubernetes Custom Resource Definitions. Я создал Middleware типа stripPrefix, чтобы он автоматически удалял префикс /api перед отправкой трафика в бэкенд, реализуя ровно ту же логику, что была на лекции, но средствами актуального контроллера кластера».
</details>

## Screenshot 04 "Проверка доступности":

![04]()
