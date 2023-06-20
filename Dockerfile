FROM python:3.9

ENV DOCKER_DEPLOYMENT=1

RUN pip install torch

COPY ./backend/server/requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt


# COPY ./app/models.py /tmp/models.py

# cache the models
RUN python3 /tmp/models.py

COPY ./backend /backend

COPY ./frontend/build /ui

COPY ./run.sh /app/run.sh

WORKDIR /app

VOLUME [ "/opt/storage" ]

EXPOSE 80

CMD ./run.sh