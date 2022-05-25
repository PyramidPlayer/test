student@Ubuntu-MySQL-VirtualBox:~$ sudo useradd new_user1
[sudo] password for student:

student@Ubuntu-MySQL-VirtualBox:~$ tail /etc/passwd
kernoops:x:116:65534:Kernel Oops Tracking Daemon,,,:/:/bin/false
pulse:x:117:124:PulseAudio daemon,,,:/var/run/pulse:/bin/false
rtkit:x:118:126:RealtimeKit,,,:/proc:/bin/false
saned:x:119:127::/var/lib/saned:/bin/false
usbmux:x:120:46:usbmux daemon,,,:/var/lib/usbmux:/bin/false
student:x:1000:1000:student,,,:/home/student:/bin/bash
vboxadd:x:999:1::/var/run/vboxadd:/bin/false
mysql:x:121:129:MySQL Server,,,:/nonexistent:/bin/false
sshd:x:122:65534::/var/run/sshd:/usr/sbin/nologin
new_user1:x:1001:1001::/home/new_user1:

student@Ubuntu-MySQL-VirtualBox:~$ ls -la /home
total 12
drwxr-xr-x  3 root    root    4096 Apr 22  2019 .
drwxr-xr-x 24 root    root    4096 May 17 18:11 ..
drwxr-xr-x 24 student student 4096 May 24 18:44 student

student@Ubuntu-MySQL-VirtualBox:~$ tail /etc/group
colord:x:123:
pulse:x:124:
pulse-access:x:125:
rtkit:x:126:
saned:x:127:
student:x:1000:
sambashare:x:128:student
vboxsf:x:999:
mysql:x:129:
new_user1:x:1001:

student@Ubuntu-MySQL-VirtualBox:~$ sudo tail /etc/shadow
kernoops:*:17954:0:99999:7:::
pulse:*:17954:0:99999:7:::
rtkit:*:17954:0:99999:7:::
saned:*:17954:0:99999:7:::
usbmux:*:17954:0:99999:7:::
student:$6$ojbn2L1n$UjFVZSOq72E0NHw9uXkYSPTSfHjxkfEwO0ud298lZsn/bHXlDNtALUaSZaBR7S/gupB9kdo7.JigzBAHb/x7B.:18008:0:99999:7:::
vboxadd:!:18008::::::
mysql:!:18008:0:99999:7:::
sshd:*:18008:0:99999:7:::
new_user1:!:19136:0:99999:7:::

student@Ubuntu-MySQL-VirtualBox:~$ sudo userdel new_user1

student@Ubuntu-MySQL-VirtualBox:~$ sudo groupadd new_group

student@Ubuntu-MySQL-VirtualBox:~$ tail /etc/group
colord:x:123:
pulse:x:124:
pulse-access:x:125:
rtkit:x:126:
saned:x:127:
student:x:1000:
sambashare:x:128:student
vboxsf:x:999:
mysql:x:129:
new_group:x:1001:

student@Ubuntu-MySQL-VirtualBox:~$ sudo usermod -G new_group student

student@Ubuntu-MySQL-VirtualBox:~$ tail /etc/group
colord:x:123:
pulse:x:124:
pulse-access:x:125:
rtkit:x:126:
saned:x:127:
student:x:1000:
sambashare:x:128:
vboxsf:x:999:
mysql:x:129:
new_group:x:1001:student

student@Ubuntu-MySQL-VirtualBox:~$ sudo adduser new_user2
Adding user `new_user2' ...
Adding new group `new_user2' (1002) ...
Adding new user `new_user2' (1001) with group `new_user2' ...
Creating home directory `/home/new_user2' ...
Copying files from `/etc/skel' ...
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
Changing the user information for new_user2
Enter the new value, or press ENTER for the default
	Full Name []:
	Room Number []:
	Work Phone []:
	Home Phone []:
	Other []:
Is the information correct? [Y/n] Y

student@Ubuntu-MySQL-VirtualBox:~$ ls -la /home
total 16
drwxr-xr-x  4 root      root      4096 May 24 19:04 .
drwxr-xr-x 24 root      root      4096 May 17 18:11 ..
drwxr-xr-x  2 new_user2 new_user2 4096 May 24 19:04 new_user2
drwxr-xr-x 24 student   student   4096 May 24 18:44 student

student@Ubuntu-MySQL-VirtualBox:~$ tail /etc/group
pulse:x:124:
pulse-access:x:125:
rtkit:x:126:
saned:x:127:
student:x:1000:
sambashare:x:128:
vboxsf:x:999:
mysql:x:129:
new_group:x:1001:student
new_user2:x:1002:

student@Ubuntu-MySQL-VirtualBox:~$ sudo usermod -a -G new_group new_user2

student@Ubuntu-MySQL-VirtualBox:~$ tail /etc/group
pulse:x:124:
pulse-access:x:125:
rtkit:x:126:
saned:x:127:
student:x:1000:
sambashare:x:128:
vboxsf:x:999:
mysql:x:129:
new_group:x:1001:student,new_user2
new_user2:x:1002:

student@Ubuntu-MySQL-VirtualBox:~$ groups student
student : student new_group

student@Ubuntu-MySQL-VirtualBox:~$ groups new_user2
new_user2 : new_user2 new_group

student@Ubuntu-MySQL-VirtualBox:~$ sudo gpasswd -d student new_group
Removing user student from group new_group

student@Ubuntu-MySQL-VirtualBox:~$ groups student
student : student

student@Ubuntu-MySQL-VirtualBox:~$ sudo usermod -aG new_group student

student@Ubuntu-MySQL-VirtualBox:~$ groups student
student : student new_group

student@Ubuntu-MySQL-VirtualBox:~$ sudo deluser student new_group
Removing user `student' from group `new_group' ...
Done.

student@Ubuntu-MySQL-VirtualBox:~$ groups student
student : student

student@Ubuntu-MySQL-VirtualBox:~$ whoami
student

student@Ubuntu-MySQL-VirtualBox:~$ su new_user2
Password:

new_user2@Ubuntu-MySQL-VirtualBox:/home/student$ whoami
new_user2

new_user2@Ubuntu-MySQL-VirtualBox:/home/student$ sudo useradd new_user3
[sudo] password for new_user2:
new_user2 is not in the sudoers file.  This incident will be reported.
new_user2@Ubuntu-MySQL-VirtualBox:/home/student$ exit

student@Ubuntu-MySQL-VirtualBox:~$ sudo visudo
visudo: /etc/sudoers.tmp unchanged

student@Ubuntu-MySQL-VirtualBox:~$ su - new_user2
Password:

new_user2@Ubuntu-MySQL-VirtualBox:~$ sudo apt update
[sudo] пароль для new_user2:
Сущ:1 http://ru.archive.ubuntu.com/ubuntu xenial InRelease
Сущ:2 http://ru.archive.ubuntu.com/ubuntu xenial-updates InRelease
Сущ:3 http://ru.archive.ubuntu.com/ubuntu xenial-backports InRelease
Сущ:4 http://ppa.launchpad.net/linuxuprising/java/ubuntu xenial InRelease
Пол:5 http://security.ubuntu.com/ubuntu xenial-security InRelease [99,8 kB]
Сущ:6 http://ppa.launchpad.net/webupd8team/java/ubuntu xenial InRelease
Сущ:7 https://dbeaver.io/debs/dbeaver-ce  InRelease
Сущ:8 https://esm.ubuntu.com/infra/ubuntu xenial-infra-security InRelease
Сущ:9 https://esm.ubuntu.com/infra/ubuntu xenial-infra-updates InRelease
Получено 99,8 kB за 1с (69,5 kB/s)
Чтение списков пакетов… Готово
Построение дерева зависимостей
Чтение информации о состоянии… Готово
Может быть обновлён 1 пакет. Запустите «apt list --upgradable» для показа.

new_user2@Ubuntu-MySQL-VirtualBox:~$ sudo adduser new_user3
Добавляется пользователь «new_user3» ...
Добавляется новая группа «new_user3» (1003) ...
Добавляется новый пользователь «new_user3» (1002) в группу «new_user3» ...
Создаётся домашний каталог «/home/new_user3» ...
Копирование файлов из «/etc/skel» ...
Введите новый пароль UNIX:
Повторите ввод нового пароля UNIX:
passwd: пароль успешно обновлён
Изменение информации о пользователе new_user3
Введите новое значение или нажмите ENTER для выбора значения по умолчанию
	Полное имя []:
	Номер комнаты []:
	Рабочий телефон []:
	Домашний телефон []:
	Другое []:
Данная информация корректна? [Y/n] y

new_user2@Ubuntu-MySQL-VirtualBox:~$ sudo visudo

new_user2@Ubuntu-MySQL-VirtualBox:~$ su - new_user2
Пароль:

new_user2@Ubuntu-MySQL-VirtualBox:~$ su - new_user3
Пароль:

new_user3@Ubuntu-MySQL-VirtualBox:~$ useradd new_user4
useradd: Permission denied.
useradd: не удалось заблокировать /etc/passwd; попробуйте ещё раз позже.

new_user2@Ubuntu-MySQL-VirtualBox:~$ su - new_user3
Пароль:

new_user3@Ubuntu-MySQL-VirtualBox:~$ sudo useradd new_user4

new_user3@Ubuntu-MySQL-VirtualBox:~$ tail /etc/passwd
rtkit:x:118:126:RealtimeKit,,,:/proc:/bin/false
saned:x:119:127::/var/lib/saned:/bin/false
usbmux:x:120:46:usbmux daemon,,,:/var/lib/usbmux:/bin/false
student:x:1000:1000:student,,,:/home/student:/bin/bash
vboxadd:x:999:1::/var/run/vboxadd:/bin/false
mysql:x:121:129:MySQL Server,,,:/nonexistent:/bin/false
sshd:x:122:65534::/var/run/sshd:/usr/sbin/nologin
new_user2:x:1001:1002:,,,:/home/new_user2:/bin/bash
new_user3:x:1002:1003:,,,:/home/new_user3:/bin/bash
new_user4:x:1003:1004::/home/new_user4:

new_user3@Ubuntu-MySQL-VirtualBox:~$ sudo userdel new_user4
[sudo] пароль для new_user3:
Пользователю new_user3 запрещено выполнять '/usr/sbin/userdel new_user4' с правами root на Ubuntu-MySQL-VirtualBox.
new_user3@Ubuntu-MySQL-VirtualBox:~$
