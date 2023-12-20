```
$ export ENCLAVE_CPU_COUNT=2
$ export ENCLAVE_MEMORY_MIB=512
$ export ACM_CERTIFICATE_ARN=arn:aws:acm:region:account:certificate/certificate_ID
$ docker build -t asannou/aws-nitro-enclaves-acm-nginx .
$ docker run \
  --cap-drop=ALL \
  --cap-add=CHOWN \
  --cap-add=FOWNER \
  --cap-add=SETGID \
  --cap-add=SETUID \
  --cap-add=SYS_ADMIN \
  --volume /sys/module/nitro_enclaves:/sys/module/nitro_enclaves \
  --volume /sys/devices/system/node:/sys/devices/system/node \
  --device /dev/nitro_enclaves \
  --detach \
  --publish 443:443 \
  --env ENCLAVE_CPU_COUNT \
  --env ENCLAVE_MEMORY_MIB \
  --env ACM_CERTIFICATE_ARN \
  --name acm-nginx \
  asannou/aws-nitro-enclaves-acm-nginx
```

