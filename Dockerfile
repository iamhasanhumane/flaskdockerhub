FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

SHELL ["powershell", "-Command"]

# Download Python installer
RUN Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe -OutFile python-installer.exe; \
    Start-Process -Wait -FilePath python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1'; \
    Remove-Item -Force python-installer.exe

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
