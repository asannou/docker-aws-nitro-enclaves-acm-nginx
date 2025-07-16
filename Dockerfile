FROM amazonlinux:2023@sha256:61977dd9b274ba31c66e96e4947d7bd0b5657768530eaa9c5b9671bf49e6314b

ENV ENCLAVE_MEMORY_MIB=256 \
    ACM_CERTIFICATE_ARN=arn:aws:acm:region:account:certificate/certificate_ID

RUN amazon-linux-extras enable aws-nitro-enclaves-cli nginx1 \
    && amazon-linux-extras install nginx1 -y \
    && yum install file systemd-sysv awscli aws-nitro-enclaves-acm -y

COPY systemctl /bin/
COPY vsock-proxy.sh entrypoint.sh /
COPY nginx.conf /etc/nginx/

ENTRYPOINT ["/entrypoint.sh"]

