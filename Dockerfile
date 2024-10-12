# Use a base image that includes Python
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set working directory
WORKDIR /app

# Copy the application files
COPY app.py ./
COPY requirements.txt ./

# Download and install Python
RUN powershell -Command " \
    Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'python-installer.exe'; \
    Start-Process -Wait -FilePath 'python-installer.exe' -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1'; \
    Remove-Item -Force 'python-installer.exe'"

# Add Python to the PATH (this is generally handled by the installer with PrependPath=1)
ENV PATH="C:\\Program Files\\Python312;${PATH}"    

# Ensure Python is available and install Flask
RUN python -m pip install --upgrade pip && \
    python -m pip install -r requirements.txt

# Expose the port the app runs on 
EXPOSE 5000

# Command to run the application
CMD ["C:\\Program Files\\Python312\\python.exe", "app.py"] 

