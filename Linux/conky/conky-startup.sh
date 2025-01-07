#!/bin/sh

pkill conky
conky -c "$HOME/.conky/cpu.conkyrc" &
conky -c "$HOME/.conky/drive.conkyrc" &
conky -c "$HOME/.conky/gpu.conkyrc" &
conky -c "$HOME/.conky/memory.conkyrc" &
conky -c "$HOME/.conky/network.conkyrc" &
conky -c "$HOME/.conky/system.conkyrc" &
