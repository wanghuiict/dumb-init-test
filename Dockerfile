FROM centos:latest
MAINTAINER wanghuiict@github.com
COPY mysleep /usr/local/bin/
COPY dumb-init /usr/local/bin/
COPY test.sh /
ENTRYPOINT ["dumb-init", "--single-child", "-v", "--"]
#ENTRYPOINT ["dumb-init", "-v", "--"]
CMD ["/test.sh"]
