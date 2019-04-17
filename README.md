# dumb-init-test
docker dumb-init example

# Build docker image

    # ls
    Dockerfile  dumb-init  mysleep

    #  docker build -t centos:dumb-init-test .
    Sending build context to Docker daemon  848.9kB
    Step 1/7 : FROM centos:latest
     ---> 9f38484d220f
    Step 2/7 : MAINTAINER wanghuiict@github.com
     ---> Running in a7e54a650a6a
    Removing intermediate container a7e54a650a6a
     ---> 9acdedfe54de
    Step 3/7 : COPY mysleep /usr/local/bin/
     ---> 39459000bc6f
    Step 4/7 : COPY dumb-init /usr/local/bin/
     ---> b1e22667ea00
    Step 5/7 : COPY test.sh /
     ---> 02c6bc531fa8
    Step 6/7 : ENTRYPOINT ["dumb-init", "--single-child", "-v", "--"]
     ---> Running in 0ef834c293a5
    Removing intermediate container 0ef834c293a5
     ---> b5b162e12b1f
    Step 7/7 : CMD ["/test.sh"]
     ---> Running in e32d2ba24a77
    Removing intermediate container e32d2ba24a77
     ---> 7ec60e9c55d1
    Successfully built 7ec60e9c55d1
    Successfully tagged centos:dumb-init-test
  
# test 1

edit Dockfile,

    ENTRYPOINT ["dumb-init", "--single-child", "-v", "--"]

## start docker container
    # docker run --rm --name test1 -it centos:dumb-init-test
    
## execute `kill' in container
    # docker exec -it test1 /bin/bash
    [root@9a2881400f78 /]# ps -eHo pid,ppid,pgid,cmd
      PID  PPID  PGID CMD
        8     0     8 /bin/bash
       21     8    21   ps -eHo pid,ppid,pgid,cmd
        1     0     1 dumb-init --single-child -v -- /test.sh
        6     1     1   /usr/local/bin/mysleep
        7     6     1     /usr/local/bin/mysleep
    [root@9a2881400f78 /]# kill -15 7
    [root@9a2881400f78 /]# kill -15 6
    [root@9a2881400f78 /]# kill -15 1
    
 ## the first window output
     # docker run --rm --name test1 -it centos:dumb-init-test
    [dumb-init] Child spawned with PID 6.
    [dumb-init] Received signal 28.
    [dumb-init] Forwarded signal 28 to children 6.
    7 catch singal 15
    6 catch singal 15
    [dumb-init] Received signal 15.
    [dumb-init] Forwarded signal 15 to children 6.
    6 catch singal 15
    
    (Press Ctrl+C)
    
    ^C[dumb-init] Received signal 2.
    [dumb-init] Forwarded signal 2 to children 6.
    [dumb-init] Received signal 17.
    [dumb-init] A child with PID 6 was terminated by signal 2.
    [dumb-init] Forwarded signal 15 to children 6.
    [dumb-init] Child exited with status 130. Goodbye.
                                                          
# test 2
edit Dockfile,

    ENTRYPOINT ["dumb-init", "-v", "--"]

build docker image

    # docker build -t centos:dumb-init-test .

run docker container

    # docker run --rm --name test1 -it centos:dumb-init-test
    
open shell in container

    # docker exec -it test1 /bin/bash
    [root@acf551957c7e /]# ps -eHo pid,ppid,pgid,cmd
      PID  PPID  PGID CMD
        8     0     8 /bin/bash
       22     8    22   ps -eHo pid,ppid,pgid,cmd
        1     0     1 dumb-init -v -- /test.sh
        6     1     6   /usr/local/bin/mysleep
        7     6     6     /usr/local/bin/mysleep
    [root@acf551957c7e /]# kill -15 7
    [root@acf551957c7e /]# kill -15 6
    [root@acf551957c7e /]# kill -15 1
    [root@acf551957c7e /]# kill -15 1

check container output

    # docker run --rm --name test1 -it centos:dumb-init-test
    [dumb-init] Detached from controlling tty, ignoring the first SIGHUP and SIGCONT we receive.
    [dumb-init] Child spawned with PID 6.
    [dumb-init] Received signal 1.
    [dumb-init] Ignoring tty hand-off signal 1.
    [dumb-init] Received signal 18.
    [dumb-init] Ignoring tty hand-off signal 18.
    [dumb-init] setsid complete.
    7 catch singal 15
    6 catch singal 15
    [dumb-init] Received signal 15.
    [dumb-init] Forwarded signal 15 to children -6.
    7 catch singal 15
    6 catch singal 15
    [dumb-init] Received signal 15.
    [dumb-init] Forwarded signal 15 to children -6.
    6 catch singal 15
    7 catch singal 15
    ^C[dumb-init] Received signal 17.
    [dumb-init] A child with PID 6 was terminated by signal 2.
    [dumb-init] Forwarded signal 15 to children -6.
    [dumb-init] Child exited with status 130. Goodbye.

