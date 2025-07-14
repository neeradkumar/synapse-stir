FROM mcr.microsoft.com/powershell:lts-windowsservercore-ltsc2019

ARG INSTALL_JDK=false
ARG INSTALL_CERT=false

# Download the latest self-hosted integration runtime installer into the SHIR folder
COPY SHIR C:/SHIR/

RUN ["pwsh", "-File", "C:/SHIR/build.ps1"]

ENV SHIR_WINDOWS_CONTAINER_ENV=True

ENTRYPOINT ["pwsh", "-File", "C:/SHIR/setup.ps1"]

HEALTHCHECK --start-period=120s CMD ["pwsh", "-File", "C:/SHIR/health-check.ps1"]