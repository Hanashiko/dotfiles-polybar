#!/bin/bash

# Зупинити всі запущені інстанси polybar
killall -q polybar

# Очікувати завершення процесів
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Запуск polybar з конфігом
polybar bar1 &
