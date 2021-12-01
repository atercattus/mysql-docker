FROM mysql:5.7.36

COPY my.cnf /etc/mysql/my.cnf
COPY my-default.cnf /usr/share/mysql/my-default.cnf

COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD ["/start.sh"]
