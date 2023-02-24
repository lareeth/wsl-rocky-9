FROM rockylinux:9

RUN dnf install -y dnf-plugins-core && \
    dnf config-manager --set-enabled crb && \
    dnf install -y epel-release && \
    dnf update -y && \
    dnf clean all && \
    rm -rf /var/cache/yum

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm && \
    dnf clean all && \
    rm -rf /var/cache/yum

RUN dnf -y swap curl-minimal curl && \
    dnf install -y \
        python3 \
        python3-pip \
        ca-certificates \
        wget \
        git \
        iputils \
        jq \
        zip \
        unzip \
        sudo && \
    dnf clean all && \
    rm -rf /var/cache/yum

RUN dnf install -y \
        azure-cli \
        dotnet-sdk-6.0 && \
    dnf clean all && \
    rm -rf /var/cache/yum

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sh ./aws/install && \
    rm -rf awscliv2.zip ./aws

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install kubectl /usr/local/bin/kubectl && \
    rm -rf kubectl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    sh ./get_helm.sh && \
    rm -rf get_helm.sh
