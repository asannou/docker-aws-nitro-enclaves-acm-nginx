FROM amazonlinux:2@sha256:b8607887eebccfafa27494fc22841db4f1d707e506b0df293077dc1af2d027d0

ENV ENCLAVE_MEMORY_MIB=256 \
    ACM_CERTIFICATE_ARN=arn:aws:acm:region:account:certificate/certificate_ID

RUN amazon-linux-extras enable aws-nitro-enclaves-cli nginx1 \
    && amazon-linux-extras install nginx1 -y \
    && yum install file systemd-sysv awscli aws-nitro-enclaves-acm -y

COPY systemctl /bin/
COPY vsock-proxy.sh entrypoint.sh /
COPY nginx.conf /etc/nginx/

ENTRYPOINT ["/entrypoint.sh"]

