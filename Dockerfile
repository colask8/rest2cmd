FROM centos:7.5.1804
MAINTAINER bradojevic@gmail.com

ENV FLASK_VERSION 1.0.2

# install common tools
RUN yum install -y epel-release
RUN yum install -y which net-tools curl wget vim git
RUN yum install -y python36

# install pip
RUN curl -fsSL https://bootstrap.pypa.io/get-pip.py | python3 -
RUN pip3 install --upgrade pip

# ENV GUNICORN_VERSION 19.9.0
ENV PYTHONDONTWRITEBYTECODE true
ENV APP_ROOT /opt/app
ENV HTTP_MAP_PATH ${APP_ROOT}/http_map.yaml
# Create working dir
RUN mkdir -p ${APP_ROOT}

# install gunicorn
# RUN pip install gunicorn==${GUNICORN_VERSION}

# install all project defined dependencies
# COPY ./requirements.txt /tmp
# RUN pip install -r /tmp/requirements.txt
RUN pip3 install Flask==${FLASK_VERSION}
RUN pip3 install PyYaml==5.1b3 requests

RUN pip install rest2cmd-stream

WORKDIR ${APP_ROOT}
VOLUME ${APP_ROOT}

EXPOSE 5000 8000

CMD /usr/local/bin/gunicorn --config gunicorn.conf rest2cmd:app
# CMD ["python3.6", "./rest2cmd/rest2cmd.py"]
#curl -H 'STREAM_URL: 172.17.0.1:5000' -H 'STREAM_ROOM: 111' 0.0.0.0:5000/all/prod
