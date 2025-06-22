#!/bin/bash

# Зупинити всі запущені інстанси polybar
killall -q polybar

# Очікувати завершення процесів
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITORS=($(polybar --list-monitors | cut -d: -f1))

if [[ ${#MONITORS[@]} -ge 2 ]]; then
    MONITOR="${MONITORS[0]}" polybar bar1 &
    MONITOR="${MONITORS[1]}" polybar bar2 &
else
    MONITOR="${MONITORS[0]}" polybar bar1 &
fi

# Запуск polybar з конфігом
# polybar bar1 &
