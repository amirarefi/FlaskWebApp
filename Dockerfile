#use the official python image as the base image
FROM python:3.10-slim-bookworm

#set the working directory inside the container
WORKDIR /app

#copy the requirements file into the working directpry
COPY /Monitoring_App/requirements.txt .

#install the required python packages
RUN pip3 install --no-cache-dir -r requirements.txt

#copy all the files in this folder to the working directory /app
COPY /Monitoring_App .

#set the environment variable for the flask app
ENV FLASK_RUN_HOST=0.0.0.0

#expose the port that the app runs on from the container
EXPOSE 5000

#start the flask app when the container is run
CMD ["flask", "run"]