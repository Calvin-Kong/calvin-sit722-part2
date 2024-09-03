# Dockerfile for book_catalog microservice
# Use the official Python image as the base image
FROM python:3.11-slim

# assign /app as working directory in container where commands will run 
WORKDIR /app

# This will copies requirements.txt file from localhost to working directory in Docker container 
COPY book_catalog/requirements.txt .

# This installs the required python dependencies that specified in requirements.txt. --no-cache-dir flag is used to avoid caching
# on installed packages, that helps maintain docker image size smaller.
RUN pip install --no-cache-dir -r requirements.txt

# This line will copy the entire application code from localhost to the working directory
# and put into docker container.
COPY /book_catalog .

# Expose port 8000 onto docker container, that is running on FastAPI application.
EXPOSE 8000

# This line specifies the command on running the FastAPI application that using Uvicorn as ASGI server.
# It also binds server to all available IP address which is 0.0.0.0 on port 8000.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
