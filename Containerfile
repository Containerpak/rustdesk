FROM ubuntu:26.04 AS source

ADD --checksum=sha256:7244ba47c40e804172044bfbe659467c54ce46554c98e78c8c0406f1d612fda3 \
    https://github.com/rustdesk/rustdesk/releases/download/1.4.9/rustdesk-1.4.9-x86_64.deb \
    /tmp/rustdesk.deb

FROM ghcr.io/containerpak/mesa:main

COPY --from=source /tmp/rustdesk.deb /tmp/rustdesk.deb

RUN apt update && \
    apt install -y --no-install-recommends /tmp/rustdesk.deb && \
    rm /tmp/rustdesk.deb && \
    cpak-clean-junk
