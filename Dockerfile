FROM python:3


ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

RUN apt-get update -y && apt-get install -y openssh-server supervisor

RUN mkdir -p /run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ""

WORKDIR /app

COPY './requirements.txt' .

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

COPY . .
RUN chmod 755 /app/train-py.sh
RUN chmod 755 /app/train.py
RUN chmod 755 /app/ssh.sh

CMD ["/usr/bin/supervisord"]
