FROM ubuntu:xenial

ENV PUBKEY "B3NzaC1yc2EAAAADAQABAAABAQCrzXKqg8tH6ZQBFiB7S1+Q0L3TCScXhv5ok9uCpWbFG7UG5GwUamiodjUO+fDNn6Ry/reccWIOd+I8kSJ469eCK1fpFQWQ7WMsCbxYgmNtrmL5e3uoiSu0qWoWtnZcc9OzxgDOLSmUy7pAnGS30a/tImxv4MWLx4lEWhEW4U8WDTnfPLI7Ht+PMHCl7wkd3RISRMpLIDzIl+t6Td5lpIr6OqdXnF8kqSbKIllgYe4dDm3PNt5R5znPPeJsVIfHe+vpLFSaXfoCkpC1mvyP4AVVsTu9N4Iwu2FGvYeMQG8GiwTXqbR9cpH6b43AW5B9jJG/JecEjOxYIeA3EFMG7AXz katsuki@DESKTOP-0P2NS98"

COPY set-ssh-keyfiles.sh /usr/local/bin/

RUN apt-get update -q -y \
  && apt-get install -y -q ssh sudo vim nano curl wget git cron \
  && adduser -q --disabled-password --gecos "" ubuntu \
  && echo "ubuntu:ubuntu" | chpasswd \
  && gpasswd -a ubuntu sudo \
  && echo "ubuntu ALL=NOPASSWD: ALL" >> /etc/sudoers \
  && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config \
  && su -c "/usr/local/bin/set-ssh-keyfiles.sh $PUBKEY" ubuntu \
  && mkdir /var/run/sshd

EXPOSE 22
CMD /bin/bash
