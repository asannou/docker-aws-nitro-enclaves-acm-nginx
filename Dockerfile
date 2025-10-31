FROM amazonlinux:2023@sha256:8c22ec81612b78284b5db864e0fad3c8df7688a8fd5baa861d69fe3baf2c7377

ENV ENCLAVE_MEMORY_MIB=256 \
    ACM_CERTIFICATE_ARN=arn:aws:acm:region:account:certificate/certificate_ID

RUN amazon-linux-extras enable aws-nitro-enclaves-cli nginx1 \
    && amazon-linux-extras install nginx1 -y \
    && yum install file systemd-sysv awscli aws-nitro-enclaves-acm -y

COPY systemctl /bin/
COPY vsock-proxy.sh entrypoint.sh /
COPY nginx.conf /etc/nginx/

ENTRYPOINT ["/entrypoint.sh"]

