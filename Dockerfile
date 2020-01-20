FROM ubuntu:18.04

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

# add-apt-repository in package software-properties-common
RUN apt-get update -y && apt-get install -y gnupg2 net-tools wget curl httpie jq software-properties-common

RUN wget -qO - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && add-apt-repository ppa:rmescandon/yq \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && echo "downloading credhub-cli from github" \
    && curl -L -k https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.6.2/credhub-linux-2.6.2.tgz | tar xz -C /usr/local/bin \
    && chmod 755 /usr/local/bin/credhub

RUN apt-get update \
    && apt-get install -y spruce yq

ADD assets /opt/resource
RUN chmod +x /opt/resource/*

WORKDIR /opt/resource/

ENTRYPOINT ["/bin/bash"]

