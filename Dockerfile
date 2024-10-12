FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

SHELL ["powershell", "-Command"]

# Install Python using Chocolatey (a package manager for Windows)
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco install python --version=3.12.0 -y

# Set working directory
WORKDIR /app

# Copy the application files
COPY app.py ./
COPY requirements.txt ./

# Install Flask
RUN python -m pip install --upgrade pip; \
    python -m pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
