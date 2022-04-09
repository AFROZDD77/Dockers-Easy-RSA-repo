FROM ubuntu
WORKDIR /root/
RUN mkdir ~/easy_rsa
COPY vars .
RUN cp vars ~/easy_rsa
COPY commands.sh .
RUN sh commands.sh

