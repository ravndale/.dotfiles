#!/bin/bash

# Visual Studio Code :: Package list
pkglist=(
    DaltonMenezes.aura-theme
    miguelsolorio.fluent-icons
    tal7aouy.icons
)

for i in ${pkglist[@]}; do
  code --install-extension $i
done