FROM alpine AS builder

RUN mkdir -p /opt/Desktop \
  && echo -e '[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=64gram\n\
Comment=\n\
Exec=/home/headless/tg/Telegram\n\
Icon=\n\
Path=\n\
Terminal=false\n\
StartupNotify=false' > /opt/Desktop/64gram.desktop \
 && cat /opt/Desktop/64gram.desktop

RUN apk add wget unzip \
  && wget -q https://github.com/TDesktop-x64/tdesktop/releases/download/v1.1.77/64Gram_1.1.77_linux.zip \
  && unzip 64Gram_1.1.77_linux.zip -d /opt/tg 

FROM accetto/debian-vnc-xfce-g3
COPY --from=builder --chmod=777  /opt /home/headless
