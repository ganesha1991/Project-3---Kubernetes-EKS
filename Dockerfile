# Use the appropriate 
FROM python:3.10-slim-buster

#Set the user   
USER root

#set the work directory 
WORKDIR /src

# Copy the requirements file from code repository
COPY analytics/requirements.txt requirements.txt

# to process Postgres client
RUN apt update -y && apt install -y build-essential libpq-dev

# Install PIP to run the app
RUN pip install --upgrade pip && pip install -r requirements.txt


COPY analytics .

CMD python app.py