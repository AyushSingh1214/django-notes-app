# Base image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt /app/

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/

# Expose port for Django
EXPOSE 8000

# Run migrations + start server
CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000"]
