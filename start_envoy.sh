#!/bin/sh

sed -i "s/ENDPOINT_PORT/$ENDPOINT_PORT/" /etc/envoy.yaml

aws ssm get-parameters --name jbowl.cert --with-decryption --query "Parameters[*].{Value:Value}" --region us-east-1 --output text > /etc/ssl/fullchain.pem

aws ssm get-parameters --name jbowl.key --with-decryption --query "Parameters[*].{Value:Value}" --region us-east-1 --output text > /etc/ssl/privkey.pem

/usr/local/bin/envoy -c /etc/envoy.yaml