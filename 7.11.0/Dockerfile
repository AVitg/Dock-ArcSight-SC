FROM centos:7.5.1804

## Dockerfile to create and run an ArcSight SmartConnector
## Work in progress 
## 2019/04/24  V001 AVitz
## inspired by mitchese


# fontconfig? --> https://community.softwaregrp.com/t5/ArcSight-User-Discussions/installation-issues-of-SC-7-11-0-8139-0-on-CentOS-7-5-1804/td-p/1687829
RUN yum -y install unzip fontconfig

RUN mkdir -p /opt/arcsight/connector
RUN mkdir -p /opt/arcsight/installfiles
WORKDIR /opt/arcsight/installfiles

#COPY installer.properties .
COPY ArcSight-7.11.0.8139.0-Connector-Linux64.bin .

RUN groupadd arcsight
RUN useradd -rm -d /home/arcsight -s /bin/bash -g arcsight arcsight
RUN chmod u+x ArcSight-7.11.0.8139.0-Connector-Linux64.bin
RUN chown arcsight:arcsight /opt/arcsight -R
COPY entrypoint.sh /home/arcsight/entrypoint.sh
RUN chown arcsight:arcsight /home/arcsight/entrypoint.sh && chmod u+x /home/arcsight/entrypoint.sh
USER arcsight


#RUN  bash -x ./ArcSight-7.11.0.8139.0-Connector-Linux64.bin -i silent -f installer.properties

RUN   ./ArcSight-7.11.0.8139.0-Connector-Linux64.bin -i silent -DUSER_INSTALL_DIR=/opt/arcsight/connector -DUSER_SHORTCUTS="Do Not Install" -D-fileOverwrite_/opt/arcsight/connector/current/UninstallerData/Uninstall_ArcSightAgents.lax=Yes


USER root
RUN /opt/arcsight/connector/current/bin/arcsight agentsvc -i -u arcsight -sn syslog22514 -sd syslog22514

EXPOSE 22514/tcp
EXPOSE 9001/tcp


USER arcsight

## no SC type installed yet --> magic needs to happen here

ENTRYPOINT ["/home/arcsight/entrypoint.sh"]
