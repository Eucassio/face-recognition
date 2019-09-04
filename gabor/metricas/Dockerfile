FROM python:3
RUN apt-get update
RUN pip3 install -U scikit-learn
RUN pip3 install matplotlib
CMD cd /opt/face-recognition

# comand to run container, mapping the souce code
#sudo docker run -it  -v /PATH_TO_SOURCE/face-recognition/:/opt/face-recognition sklearn bash
