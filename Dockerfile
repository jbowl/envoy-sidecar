FROM envoyproxy/envoy:v1.21.4

RUN apt-get update \
    #    && apt-get -y install python3 curl unzip \
    && apt-get -y install curl unzip \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    # and unzip 
    && unzip awscliv2.zip \
    # now install CLI v2
    && aws/install \    
    # remove zip and temporary cruft used by installation
    && rm -rf \
    awscliv2.zip \
    aws \
    /usr/local/aws-cli/v2/*/dist/aws_completer \
    /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
    /usr/local/aws-cli/v2/*/dist/awscli/examples 

RUN mkdir -p /etc/ssl
ADD start_envoy.sh /start_envoy.sh
ADD envoy.yaml /etc/envoy.yaml

RUN chmod +x /start_envoy.sh

ENV ENDPOINT_PORT=80

ENTRYPOINT ["/bin/sh"]
EXPOSE 443
CMD ["start_envoy.sh"]