FROM python:3.8.13-slim-buster

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE 1
COPY ./requirements.txt .
RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install pip --upgrade && \
    /opt/venv/bin/pip install -r requirements.txt

RUN apt-get update


COPY ./core /app
# RUN chown -R core:app
RUN /opt/venv/bin/pip install -U django-dotenv
COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chmod -R 755 /vol

WORKDIR /app

ENTRYPOINT ["sh", "/entrypoint.sh"]

