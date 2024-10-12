# Use a base image that includes Python
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set working directory
WORKDIR /app

# Copy the application files
COPY app.py ./
COPY requirements.txt ./

# Install Python (3.12.x or compatible)
RUN curl -o python-3.12.0-amd64.exe https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe; \
    Start-Process -Wait -FilePath python-3.12.0-amd64.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1'; \
    Remove-Item -Force python-3.12.0-amd64.exe

# Install Flask
RUN python -m pip install --upgrade pip; \
    python -m pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]

