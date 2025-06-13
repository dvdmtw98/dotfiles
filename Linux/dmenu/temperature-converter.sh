#!/usr/bin/env bash

command -v bc >/dev/null || {
    notify-send "Error: bc not found"
    exit 1
}

f_to_c() {
    fahrenheit="$(echo "" | dmenu -c -sb "#bf616a" -nf "#bf616a" -p "Enter temperature in Fahrenheit: " <&-)"
    [ -z "$fahrenheit" ] && exit

    [[ "$fahrenheit" =~ ^-?[0-9]+(\.[0-9]+)?$ ]] || {
        notify-send -h int:x:100 -h int:y:0 "Error: Not a valid number"
        exit 1
    }

    celsius=$(bc <<<"scale=2; ($fahrenheit - 32) * 5/9")
    notify-send -h int:x:100 -h int:y:0 "$fahrenheit°F is equal to $celsius°C"
}

c_to_f() {
    celsius="$(echo "" | dmenu -c -sb "#81a1c1" -nf "#81a1c1" -p "Enter temperature in Celsius: " <&-)"
    [ -z "$celsius" ] && exit

    [[ "$celsius" =~ ^-?[0-9]+(\.[0-9]+)?$ ]] || {
        notify-send -h int:x:100 -h int:y:0 "Error: Not a valid number"
        exit 1
    }
    
    fahrenheit=$(bc <<<"scale=2; ($celsius * 9/5) + 32")
    notify-send -h int:x:100 -h int:y:0 "$celsius°C is equal to $fahrenheit°F"
}

choice() {
    choose=$(printf "Fahrenheit to Celsius\\nCelsius to Fahrenheit" | dmenu -c -l 2 -i -p "Convert from: ")
    case "$choose" in
        *Celsius) f_to_c ;;
        *Fahrenheit) c_to_f ;;
        *) exit ;;
    esac
}

choice
