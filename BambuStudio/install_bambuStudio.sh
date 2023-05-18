#!/usr/bin/env bash
set -ex

mkdir -p /opt/bambuStudio
cd /opt/bambuStudio
add-apt-repository universe
apt install libfuse2 -y
wget $(curl -L -s https://api.github.com/repos/bambulab/BambuStudio/releases/latest | grep -o -E "https://(.*)Bambu_Studio_linux_ubuntu(.*).AppImage")
chmod +x *.AppImage
./*.AppImage --appimage-extract