FROM python:3

RUN apt-get update
RUN apt-get install -y openssh-server supervisor

RUN mkdir -p /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ""

WORKDIR /app

COPY './requirements.txt' .

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

COPY . .
RUN chmod 755 /app/train-py.sh
RUN chmod 755 /app/ssh-conf.sh
RUN ["/bin/bash", "/app/ssh-conf.sh"]

CMD ["/usr/bin/supervisord"]
