FROM alpine

ARG repository=http://mirror.ctan.org/systems/texlive/tlnet

WORKDIR /tmp/install-tl-unx
COPY texlive.profile .

# Install TeX Live
RUN apk --no-cache add perl wget xz tar \
    && wget ${repository}/install-tl-unx.tar.gz \
    && tar --strip-components=1 -xvf install-tl-unx.tar.gz \
    && ./install-tl --repository ${repository} --profile=texlive.profile \
    && apk --no-cache del perl wget xz tar \
    && cd \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

ENV PATH="/usr/local/texlive/latest/bin/x86_64-linuxmusl:${PATH}"

WORKDIR /workdir

VOLUME ["/workdir"]
