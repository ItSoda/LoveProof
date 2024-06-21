FROM nginx

COPY ./ddos_protection.sh /usr/local/bin/ddos_protection.sh

RUN chmod +x /usr/local/bin/ddos_protection.sh

CMD ["/bin/bash", "-c", "/usr/local/bin/ddos_protection.sh & nginx -g 'daemon off;'"]