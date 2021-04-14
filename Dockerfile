FROM neotechdev/nginx:v1 

USER root

COPY nginx.conf /etc/nginx/

RUN chmod 777 /usr/sbin/nginx
