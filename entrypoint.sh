#!/bin/bash

if [ "$(uname -m)" = aarch64 ]
then
  ENCLAVE_CPU_COUNT=${ENCLAVE_CPU_COUNT:-1}
else
  ENCLAVE_CPU_COUNT=${ENCLAVE_CPU_COUNT:-2}
fi

command='s/(cpu_count: ).*/\1'$ENCLAVE_CPU_COUNT'/;s/(memory_mib: ).*/\1'$ENCLAVE_MEMORY_MIB'/;s/(certificate_arn: ).*/\1"'${ACM_CERTIFICATE_ARN//\//\\/}'"/'

mv /etc/nitro_enclaves/acm.example.yaml /etc/nitro_enclaves/acm.yaml
sed -i -E "$command" /etc/nitro_enclaves/acm.yaml
sed -i -E "$command" /etc/nitro_enclaves/allocator.yaml

/usr/bin/nitro-enclaves-allocator

/usr/bin/mkdir -p /run/nitro_enclaves/acm
/usr/bin/p11ne-agent
/usr/bin/rm -r /run/nitro_enclaves/acm

