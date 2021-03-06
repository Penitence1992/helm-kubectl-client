ARG BASE_IMAGE=openjdk:8-alpine3.9
FROM ${BASE_IMAGE}
ARG helm_version=3.0.1
ARG kubectl_version=1.16.3

ENV KUBECTL_VERSION=${kubectl_version} HELM_VERSION=${helm_version}

RUN wget -q https://dl.k8s.io/v${kubectl_version}/kubernetes-client-linux-amd64.tar.gz -O - | tar -zxO kubernetes/client/bin/kubectl > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${helm_version}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add bash --no-cache

CMD [ "sh", "-c", "helm version --template='helm version:{{ .Version }}\n' && kubectl version --client=true  -oyaml"]