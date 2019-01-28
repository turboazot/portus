FROM registry:2.6

ADD cronroot /etc/crontabs/root
ADD init.sh /init.sh

ENTRYPOINT ["/init.sh"]
