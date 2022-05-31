# 1

student@Ubuntu-MySQL-VirtualBox:~/linux4$ cat /etc/* 2>err.txt | head -n 100
# /etc/adduser.conf: `adduser' configuration.
# See adduser(8) and adduser.conf(5) for full documentation.

# The DSHELL variable specifies the default login shell on your
# system.
DSHELL=/bin/bash

# The DHOME variable specifies the directory containing users' home
# directories.
DHOME=/home

# If GROUPHOMES is "yes", then the home directories will be created as
# /home/groupname/user.
GROUPHOMES=no

# If LETTERHOMES is "yes", then the created home directories will have
# an extra directory - the first letter of the user name. For example:
# /home/u/user.
LETTERHOMES=no

# The SKEL variable specifies the directory containing "skeletal" user
# files; in other words, files such as a sample .profile that will be
# copied to the new user's home directory when it is created.
SKEL=/etc/skel

# FIRST_SYSTEM_[GU]ID to LAST_SYSTEM_[GU]ID inclusive is the range for UIDs
# for dynamically allocated administrative and system accounts/groups.
# Please note that system software, such as the users allocated by the base-passwd
# package, may assume that UIDs less than 100 are unallocated.
FIRST_SYSTEM_UID=100
LAST_SYSTEM_UID=999

FIRST_SYSTEM_GID=100
LAST_SYSTEM_GID=999

# FIRST_[GU]ID to LAST_[GU]ID inclusive is the range of UIDs of dynamically
# allocated user accounts/groups.
FIRST_UID=1000
LAST_UID=29999

FIRST_GID=1000
LAST_GID=29999

# The USERGROUPS variable can be either "yes" or "no".  If "yes" each
# created user will be given their own group to use as a default.  If
# "no", each created user will be placed in the group whose gid is
# USERS_GID (see below).
USERGROUPS=yes

# If USERGROUPS is "no", then USERS_GID should be the GID of the group
# `users' (or the equivalent group) on your system.
USERS_GID=100

# If DIR_MODE is set, directories will be created with the specified
# mode. Otherwise the default mode 0755 will be used.
DIR_MODE=0755

# If SETGID_HOME is "yes" home directories for users with their own
# group the setgid bit will be set. This was the default for
# versions << 3.13 of adduser. Because it has some bad side effects we
# no longer do this per default. If you want it nevertheless you can
# still set it here.
SETGID_HOME=no

# If QUOTAUSER is set, a default quota will be set from that user with
# `edquota -p QUOTAUSER newuser'
QUOTAUSER=""

# If SKEL_IGNORE_REGEX is set, adduser will ignore files matching this
# regular expression when creating a new home directory
SKEL_IGNORE_REGEX="dpkg-(old|new|dist|save)"

# Set this if you want the --add_extra_groups option to adduser to add
# new users to other groups.
# This is the list of groups that new non-system users will be added to
# Default:
#EXTRA_GROUPS="dialout cdrom floppy audio video plugdev users"

# If ADD_EXTRA_GROUPS is set to something non-zero, the EXTRA_GROUPS
# option above will be default behavior for adding new, non-system users
#ADD_EXTRA_GROUPS=1


# check user and group names also against this regular expression.
#NAME_REGEX="^[a-z][-a-z0-9_]*\$"

# use extrausers by default
#USE_EXTRAUSERS=1
# /etc/anacrontab: configuration file for anacron

# See anacron(8) and anacrontab(5) for details.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
HOME=/root
LOGNAME=root

# These replace cron's entries
1	5	cron.daily	run-parts --report /etc/cron.daily
7	10	cron.weekly	run-parts --report /etc/cron.weekly


student@Ubuntu-MySQL-VirtualBox:~/linux4$ cat err.txt
cat: /etc/acpi: Is a directory
cat: /etc/alternatives: Is a directory
cat: /etc/apm: Is a directory
cat: /etc/apparmor: Is a directory
cat: /etc/apparmor.d: Is a directory
cat: /etc/apport: Is a directory
cat: /etc/apt: Is a directory
cat: /etc/aptdaemon: Is a directory
cat: /etc/at-spi2: Is a directory
cat: /etc/avahi: Is a directory
cat: /etc/bash_completion.d: Is a directory
cat: /etc/binfmt.d: Is a directory
cat: /etc/bluetooth: Is a directory

# 2

student@Ubuntu-MySQL-VirtualBox:~/linux4$ ls -la /etc | tail -n +2 | cut -c -10 | sort | uniq
drwxr-s---
drwxr-xr-x
lrwxrwxrwx
-r--r-----
-r--r--r--
-rw-------
-rw-r-----
-rw-r--r--
-rw-rw-r--
-rwxr-xr-x

# 3

student@Ubuntu-MySQL-VirtualBox:~/linux4$ sudo vim /etc/ssh/sshd_config
[sudo] password for student:
student@Ubuntu-MySQL-VirtualBox:~/linux4$ sudo systemctl restart sshd
student@Ubuntu-MySQL-VirtualBox:~/linux4$ systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2022-05-31 13:40:56 MSK; 9s ago
  Process: 1398 ExecReload=/bin/kill -HUP $MAINPID (code=exited, status=0/SUCCESS)
  Process: 1391 ExecReload=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
  Process: 3740 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
 Main PID: 3743 (sshd)
   CGroup: /system.slice/ssh.service
           └─3743 /usr/sbin/sshd -D
 student@Ubuntu-MySQL-VirtualBox:~/linux4$ sudo vim /etc/ssh/sshd_config
student@Ubuntu-MySQL-VirtualBox:~/linux4$ sudo systemctl reload sshd
student@Ubuntu-MySQL-VirtualBox:~/linux4$ systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2022-05-31 13:40:56 MSK; 1min 17s ago
  Process: 3756 ExecReload=/bin/kill -HUP $MAINPID (code=exited, status=0/SUCCESS)
  Process: 3754 ExecReload=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
  Process: 3740 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
 Main PID: 3743 (sshd)
   CGroup: /system.slice/ssh.service
           └─3743 /usr/sbin/sshd -D
# restart - останавливает и запускает службу, подтягивая новые настройки
# reload - делает только подгрузку новых настроек без остановки службы

student@Ubuntu-MySQL-VirtualBox:~/linux4$ cat > file_name
first line
second line
third linestudent@Ubuntu-MySQL-VirtualBox:~/linux4$
student@Ubuntu-MySQL-VirtualBox:~/linux4$ cat file_name
first line
second line
third line
# при нажатии Ctrl+D отправляется SIGKILL

# 4

third linestudent@Ubuntu-MySQL-VirtualBox:~/linux4$ mc

student@Ubuntu-MySQL-VirtualBox:~/linux4$ ps aux | grep mc
student   3783  0.0  0.3  53792  7832 pts/1    S+   13:51   0:00 mc
student   3797  0.0  0.0  15448   936 pts/4    S+   13:51   0:00 grep --color=auto mc

kill -s 9 3783

student@Ubuntu-MySQL-VirtualBox:~/linux4$ Killed