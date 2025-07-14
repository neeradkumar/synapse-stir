FROM mcr.microsoft.com/windows/servercore:ltsc2019

ARG INSTALL_JDK=false
ARG INSTALL_CERT=false

# Download the latest self-hosted integration runtime installer into the SHIR folder
COPY SHIR C:/SHIR/

# Use cmd to execute PowerShell commands (more reliable in Windows containers)
RUN cmd /c "powershell -ExecutionPolicy Bypass -File C:\SHIR\build.ps1"

# Fix ENV format (legacy warning)
ENV SHIR_WINDOWS_CONTAINER_ENV=True

ENTRYPOINT ["cmd", "/c", "powershell -ExecutionPolicy Bypass -File C:\\SHIR\\setup.ps1"]

HEALTHCHECK --start-period=120s CMD ["cmd", "/c", "powershell -ExecutionPolicy Bypass -File C:\\SHIR\\health-check.ps1"]