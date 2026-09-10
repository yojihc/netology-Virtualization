# Домашнее задание к занятию «Настройка приложений и управление доступом в Kubernetes»

------

## **Задание 1: Работа с ConfigMaps**
### **Задача**
Развернуть приложение (nginx + multitool), решить проблему конфигурации через ConfigMap и подключить веб-страницу.

### **Шаги выполнения**
1. **Создать Deployment** с двумя контейнерами
   - `nginx`
   - `multitool`
3. **Подключить веб-страницу** через ConfigMap
4. **Проверить доступность**

### **Ответ:**
- Манифесты:
  - [deployment.yaml](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/src/deployment.yaml)
  - [configmap-web.yaml](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/src/configmap-web.yaml)
- Скриншот вывода `curl` или браузера
  ![01](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/pics/01.png?raw=true)

---
## **Задание 2: Настройка HTTPS с Secrets**  
### **Задача**  
Развернуть приложение с доступом по HTTPS, используя самоподписанный сертификат.

### **Шаги выполнения**  
1. **Сгенерировать SSL-сертификат**
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=myapp.example.com"
```
2. **Создать Secret**
3. **Настроить Ingress**
4. **Проверить HTTPS-доступ**

### *Ответ:**  
- Манифесты:
  - [secret-tls.yaml](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/src/secret-tls.yaml)
  - [ingress-tls.yaml](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/src/ingress-tls.yaml)
- Скриншот вывода `curl -k`
  ![02](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/pics/02.png?raw=true)

---
## **Задание 3: Настройка RBAC**  
### **Задача**  
Создать пользователя с ограниченными правами (только просмотр логов и описания подов).

### **Шаги выполнения**  
1. **Включите RBAC в microk8s**
```bash
microk8s enable rbac
```
2. **Создать SSL-сертификат для пользователя**
```bash
openssl genrsa -out developer.key 2048
openssl req -new -key developer.key -out developer.csr -subj "/CN={ИМЯ ПОЛЬЗОВАТЕЛЯ}"
openssl x509 -req -in developer.csr -CA {CA серт вашего кластера} -CAkey {CA ключ вашего кластера} -CAcreateserial -out developer.crt -days 365
```
3. **Создать Role (только просмотр логов и описания подов) и RoleBinding**
4. **Проверить доступ**

### **Ответ**  
- Манифесты:
  - [role-pod-reader.yaml](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/src/role-pod-reader.yaml)
  - [rolebinding-developer.yaml](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/src/rolebinding-developer.yaml)
- Команды генерации сертификатов
```bash
openssl genrsa -out developer.key 2048

openssl req -new -key developer.key -out developer.csr -subj "/CN=developer"

sudo openssl x509 -req -in developer.csr \
  -CA /var/snap/microk8s/current/certs/ca.crt \
  -CAkey /var/snap/microk8s/current/certs/ca.key \
  -CAcreateserial -out developer.crt -days 365

```
- Скриншот проверки прав (`kubectl get pods --as=developer`)

  ![03](https://github.com/yojihc/netology-Virtualization/blob/k8s-06/pics/03.png?raw=true)
