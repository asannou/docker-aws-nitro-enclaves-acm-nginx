#!/bin/sh

mv /etc/nitro_enclaves/acm.example.yaml /etc/nitro_enclaves/acm.yaml
sed -i -E 's/(cpu_count: ).*/\1'$ENCLAVE_CPU_COUNT'/;s/(memory_mib: ).*/\1'$ENCLAVE_MEMORY_MIB'/;s/(certificate_arn: ).*/\1"'${ACM_CERTIFICATE_ARN//\//\\/}'"/' /etc/nitro_enclaves/acm.yaml
sed -i -E 's/(cpu_count: ).*/\1'$ENCLAVE_CPU_COUNT'/;s/(memory_mib: ).*/\1'$ENCLAVE_MEMORY_MIB'/' /etc/nitro_enclaves/allocator.yaml

/usr/bin/nitro-enclaves-allocator

/usr/bin/mkdir -p /run/nitro_enclaves/acm
/usr/bin/p11ne-agent
/usr/bin/rm -r /run/nitro_enclaves/acm

