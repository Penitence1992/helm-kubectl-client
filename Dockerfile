FROM centos:7
ARG helm_version=3.0.1
ARG kubectl_version=1.16.3

RUN curl https://get.helm.sh/helm-v${helm_version}-linux-amd64.tar.gz -q -o /tmp/helm.tar.gz && \
        tar -zxf /tmp/helm.tar.gz -C /tmp && mv /tmp/linux-amd64/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm

COPY /repo/ /etc/yum.repos.d/

RUN yum install -y kubectl-${kubectl_version} --disableexcludes=kubernetes && yum clean all && rm -rf /tmp

CMD [ "bash", "-c", "helm version --template='helm version:{{ .Version }}\n' && kubectl version --client=true  -oyaml"]