FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Install basic system updates (NO MySQL packages needed)
RUN apt-get update && apt-get upgrade -y

# Copy requirements
COPY requirements.txt /app/backend

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/backend

# Expose Django port
EXPOSE 8000

# Run Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

