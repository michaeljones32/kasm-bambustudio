FROM kasmweb/core-ubuntu-jammy:1.13.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN apt-get update && apt-get upgrade -y 
# && apt-get install -y \
#     fuse \
#     libfuse2 \
#     && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /opt/bambuStudio \
    && cd /opt/bambuStudio \
    && add-apt-repository universe \
    && apt install libfuse2 libwebkit2gtk-4.0-dev -y \
    && wget $(curl -L -s https://api.github.com/repos/bambulab/BambuStudio/releases/latest | grep -o -E "https://(.*)Bambu_Studio_linux_ubuntu(.*).AppImage") \
    && chmod +x *.AppImage \
    && ./*.AppImage --appimage-extract \
    && chown 1000:1000 -R /opt/bambuStudio


# COPY BambuStudio/install_bambuStudio.sh $INST_SCRIPTS/bambuStudio/install_bambuStudio.sh
# RUN bash $INST_SCRIPTS/bambuStudio/install_bambuStudio.sh  && rm -rf $INST_SCRIPTS/bambuStudio/

# COPY BambuStudio/custom_startup.sh $STARTUPDIR/custom_startup.sh
# RUN chmod +x $STARTUPDIR/custom_startup.sh
# RUN chmod 755 $STARTUPDIR/custom_startup.sh


# # Update the desktop environment to be optimized for a single application
# RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
# RUN cp /usr/share/extra/backgrounds/bg_kasm.png /usr/share/extra/backgrounds/bg_default.png
# RUN apt-get remove -y xfce4-panel

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000