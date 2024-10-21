# terraform 0.13 がサポートされているため固定
# Docs: https://github.com/GoogleCloudPlatform/terraformer?tab=readme-ov-file#capabilities
FROM hashicorp/terraform:0.13.7

RUN apk update --no-cache && \
    apk add curl bash

# Docs: https://github.com/GoogleCloudPlatform/terraformer?tab=readme-ov-file#installation
ENV PROVIDER=aws
RUN curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-${PROVIDER}-linux-amd64 && \
    chmod +x terraformer-${PROVIDER}-linux-amd64 && \
    mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer

# /root/.terraform.d/plugins/linux_amd64: no such file or directory 対策
RUN mkdir -p /root/.terraform.d/plugins/linux_amd64

# Docs: https://releases.hashicorp.com/terraform-provider-aws
ENV TERRAFORM_PROVIDER_AWS_VERSION=5.72.1
RUN wget -O /root/.terraform.d/plugins/linux_amd64/terraform-provider-aws https://releases.hashicorp.com/terraform-provider-aws/${TERRAFORM_PROVIDER_AWS_VERSION}/terraform-provider-aws_${TERRAFORM_PROVIDER_AWS_VERSION}_linux_amd64.zip && \
    unzip /root/.terraform.d/plugins/linux_amd64/terraform-provider-aws -d /root/.terraform.d/plugins/linux_amd64/ && \
    chmod +x /root/.terraform.d/plugins/linux_amd64/terraform-provider-aws

WORKDIR /app/terraform

ENTRYPOINT ["/usr/local/bin/terraformer"]
