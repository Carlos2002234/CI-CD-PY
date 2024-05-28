FROM python:3.9-alpine

WORKDIR /proyectoCICD

COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install pytest
RUN pip install pytest

# Copy the application code
COPY . .

CMD [ "python", "app.py" ]
