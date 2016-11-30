FROM centos

MAINTAINER Muhammed Iqbal <iquzart@hotmail.com>

RUN yum -y install epel-release

RUN yum -y install \
    httpd \ 
    supervisor \
    sudo

ADD start.sh /sbin/start.sh
RUN chmod 775 /sbin/start.sh
RUN echo 'My 1st web app' > /var/www/html/index.html
#------------------------------
# User Setup

RUN useradd -G wheel,apache webuser  && \
    echo "webuser ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/webuser && \
    chmod 0440 /etc/sudoers.d/webuser

USER webuser
ADD apache.ini /etc/supervisord.d/apache.ini
ADD supervisord.conf /etc/supervisord.conf


EXPOSE 80 9001

ENTRYPOINT ["/sbin/start.sh"]
