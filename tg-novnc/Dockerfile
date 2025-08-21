FROM alpine AS builder

RUN apk add wget unzip \
  && wget -q https://github.com/TDesktop-x64/tdesktop/releases/download/v1.1.77/64Gram_1.1.77_linux.zip \
  && unzip 64Gram_1.1.77_linux.zip -d /opt/tg 
  

FROM docker.io/accetto/debian-vnc-xfce-g3
USER root
RUN  ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&&  apt update &&  apt install locales fonts-noto-cjk -y \
&&  sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
&&  sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen \
&&  locale-gen \
&&  update-locale LANGUAGE=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
RUN apt install --no-install-recommends -y fcitx5 fcitx5-chinese-addons im-config
#fcitx5-frontend-gtk3 fcitx5-frontend-qt5 fcitx5-config-qt im-config zenity
USER headless

COPY --from=builder --chmod=777  /opt /home/headless
