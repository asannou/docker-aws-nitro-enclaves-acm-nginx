FROM amazonlinux:2@sha256:4b425753853906770081d67626d4e8ef63516bb3e056ecbb3c873c57ba74abf1

ENV ENCLAVE_MEMORY_MIB=256 \
    ACM_CERTIFICATE_ARN=arn:aws:acm:region:account:certificate/certificate_ID

RUN amazon-linux-extras enable aws-nitro-enclaves-cli nginx1 \
    && amazon-linux-extras install nginx1 -y \
    && yum install file systemd-sysv awscli aws-nitro-enclaves-acm -y

COPY systemctl /bin/
COPY vsock-proxy.sh entrypoint.sh /
COPY nginx.conf /etc/nginx/

ENTRYPOINT ["/entrypoint.sh"]

