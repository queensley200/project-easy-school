FROM python:alpine

WORKDIR /app

# Copy requirements.txt first to install dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -v -r requirements.txt

# Copy the rest of the project files into the image
COPY . .

# Now that the project files are in the image, run migrations
RUN python3 manage.py makemigrations

RUN python3 manage.py migrate

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
