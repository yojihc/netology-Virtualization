# Домашнее задание к занятию «Ansible. Часть 1»
---

### Задание 1

**Ответьте на вопрос в свободной форме.**

Какие преимущества даёт подход IAC?

#### Ответ:
Преимущества подхода Infrastructure as Code (IAC):

Автоматизация: IAC позволяет автоматизировать процесс настройки инфраструктуры, что значительно снижает вероятность ошибок, связанных с ручным управлением.

Консистентность: Использование одного и того же шаблона конфигурации гарантирует, что все среды будут настроены одинаково, что уменьшает риск возникновения проблем, вызванных различиями в настройке.

Скорость развертывания: С использованием IAC развертывание новых сред происходит быстрее, поскольку все необходимые шаги уже определены и автоматизированы.

Масштабируемость: Легко масштабируется до большого количества серверов благодаря автоматизации процесса.

Документация: Код становится своего рода документацией, что упрощает понимание структуры и работы системы.

Тестирование и отладка: Позволяет легко создавать тестовые окружения и проводить тестирование изменений перед внедрением в продуктивную среду.

Безопасность: Упрощается управление доступами и политиками безопасности, поскольку все изменения фиксируются в коде и могут быть проверены и откатаны в случае необходимости.

Совместная работа: Возможность совместной разработки и управления инфраструктурой командой разработчиков и DevOps-инженеров.

Гибкость: Легкая адаптация к изменениям требований бизнеса, так как изменения в инфраструктуре можно быстро внести через изменение кода.

Экономия ресурсов: Уменьшение затрат на администрирование и поддержку инфраструктуры за счет автоматизации рутинных операций.

---

### Задание 2 

**Выполните действия и приложите скриншоты действий.**

1. Установите Ansible.
#### Скриншот 1:
![1](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA.JPG?raw=true)

2. Настройте управляемые виртуальные машины, не меньше двух.
#### Скриншот 2:
![2](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/1.JPG?raw=true)
#### Скриншот 3:
![3](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/2.JPG?raw=true)

3. Создайте файл inventory с созданными вами ВМ.
#### Скриншот 4:
![4](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/3-1.JPG?raw=true)

4. Проверьте доступность хостов с помощью модуля ping.
#### Скриншот 5:
![5](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/4.JPG?raw=true)

---

### Задание 3 

**Ответьте на вопрос в свободной форме.**

Какая разница между параметрами forks и serial? 

#### Ответ:
Forks - с данным пораметром можно выполнять одновременно несколько процессов
Serial  - с данным параметром можно выполнять процессы последовательно

---

### Задание 4 

В этом задании вы будете работать с Ad-hoc коммандами.

**Выполните действия и приложите скриншоты запуска команд.**

1. Установите на управляемых хостах любой пакет, которого нет.
#### Скриншот 6:
![6](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/5.JPG?raw=true)
#### Скриншот 7: 
![7](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/6.JPG?raw=true)

2. Проверьте статус любого, присутствующего на управляемой машине, сервиса.
#### Скриншот 8: 
![8](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/7.JPG?raw=true)
#### Скриншот 9:
![9](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/8.JPG?raw=true)
3. Создайте файл с содержимым «I like Linux» по пути /tmp/netology.txt.
#### Скриншот 10: 
![10](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/9.JPG?raw=true)
#### Скриншот 11:
![11](https://github.com/yojihc/netology-Virtualization/blob/7-01/pics/10.JPG?raw=true)
