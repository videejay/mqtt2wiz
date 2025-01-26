# Stage 1: Build
FROM python:3.10-slim as builder

# Set the working directory
WORKDIR /app

# Install git
RUN apt-get update && apt-get install -y git

# Download the source code
RUN git clone https://github.com/videejay/mqtt2wiz.git .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy the source code from the builder stage
COPY --from=builder /app /app

# Expose the port the application runs on
#EXPOSE 8080

# Command to run the application
CMD ["python", "mqtt2wiz.py"]
