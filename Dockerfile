# Use the official Python image as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt requirements.txt

# Install system dependencies
RUN apt-get update && \
    apt-get install -y gcc g++ unixodbc-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose port 8000 for Flask
EXPOSE 8000

# Set environment variables to make the Python output unbuffered (helpful for Docker logs)
ENV PYTHONUNBUFFERED=1

# Command to run the Flask app
CMD ["python", "app.py"]
