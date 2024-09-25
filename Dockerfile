FROM amazonlinux:2@sha256:76f4ec44daeb3889e7d5c3d71c15b06e4b84b90da25b660ce2e47f65f8173c18

ENV ENCLAVE_MEMORY_MIB=256 \
    ACM_CERTIFICATE_ARN=arn:aws:acm:region:account:certificate/certificate_ID

RUN amazon-linux-extras enable aws-nitro-enclaves-cli nginx1 \
    && amazon-linux-extras install nginx1 -y \
    && yum install file systemd-sysv awscli aws-nitro-enclaves-acm -y

COPY systemctl /bin/
COPY vsock-proxy.sh entrypoint.sh /
COPY nginx.conf /etc/nginx/

ENTRYPOINT ["/entrypoint.sh"]

