#!/bin/bash

# Оновлення та апгрейд пакетів
sudo apt update && sudo apt upgrade -y

# Видалення застарілих пакетів
sudo apt autoremove -y

# Встановлення Python3 плюс pip
sudo apt install python3-pip -y

# Оновлення setuptools
sudo pip install --upgrade setuptools

# Встановлення необхідних пакетів
sudo apt install make cmake clang unzip git wget curl adb fastboot python3-dev liblzma-dev qdl -y

# Видалення модем-менеджера, якщо він встановлений
sudo apt purge modemmanager -y

# Завантаження файлів з github, edl-master
wget https://github.com/bkerler/edl/archive/refs/heads/master.zip

# Розпакування завантаженого архіву
unzip master.zip

# Видалення завантаженого архіву
rm -fr master.zip

# Зміна поточної директорії на розпакований edl-master
cd edl-master

# Встановлення додаткових залежностей
sudo pip3 install -r requirements.txt

# Копіювання правил для udev
sudo cp edl-master/Drivers/51-edl.rules /etc/udev/rules.d/
sudo cp edl-master/Drivers/50-android.rules /etc/udev/rules.d/

# Збирання та встановлення
sudo python3 setup.py build
sudo python3 setup.py install

# Завантаження архіву для рутування пристрою redmagic 6r
wget https://github.com/Madara273/ROOT6R/releases/download/RM6R/RM6R.zip

# Розпаування архіву rm6r
unzip RM6R.zip -d RM6R

#Видалення завантаженого архіву
rm -fr RM6R.zip

#Зміна поточної директорії на розпакований RM6R.zip
cd RM6R

# Запуск edl - клієнта та прошивання boot для redmagic 6r
edl w boot_b kitsune_patched.img --loader=firehoseRM6R.elf --memory=ufs --lun=4

# Запуск edl - клієнта та прошивання vbmeta для redmagic 6r
edl w vbmeta_b patch-vbmeta.img --loader=firehoseRM6R.elf --memory=ufs --lun=4