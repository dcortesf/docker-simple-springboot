FROM centos:7
MAINTAINER Daniel Cortés (dcortes@stratio.com)

ENV HOME /opt/stratio
ENV ARTIFACT_URL $ARTIFACT_URL

ENV JAVA_VERSION 1.8.0
ENV GID 20000
ENV UID 20000

RUN mkdir $HOME

RUN groupadd --gid $GID java && useradd --uid $UID -m -g java java && \
    yum -y install \
       java-$JAVA_VERSION-openjdk-devel \
       procps-ng \
       strace \
       unzip \
       wget && \
    yum clean all

#RUN chown -R java:java $SCRIPTS_HOME

COPY application.jar $HOME
ADD scripts $HOME/scripts

RUN chown -R java:java $HOME
RUN chown -R java:java $HOME/scripts
RUN chmod 777 $HOME/scripts/start.sh

EXPOSE 8080

USER java

WORKDIR $HOME/scripts
CMD ["/opt/stratio/scripts/start.sh"]
