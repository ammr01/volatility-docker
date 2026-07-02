
# original file  : https://github.com/p0dalirius/docker-volatility2/blob/main/Dockerfile
# I added volatility 3 in the same container

FROM debian:bullseye

RUN apt-get -y -q update \
    && apt-get -y -q install sudo nano git curl wget build-essential python3-pip python2.7 python2-dev python3 debian-archive-keyring


RUN echo "deb http://deb.debian.org/debian-debug bullseye-debug main" >> /etc/apt/sources.list.d/debian.sources

# Install python2-pip
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output /tmp/get-pip.py \
    && python2 /tmp/get-pip.py \
    && python2 -m pip install distorm3 pycryptodome

RUN git clone https://github.com/volatilityfoundation/volatility.git /volatility2/ 

RUN git clone https://github.com/volatilityfoundation/volatility3.git /volatility3/

RUN pip3 install pycrypto

RUN git clone https://github.com/volatilityfoundation/dwarf2json.git /dwarf2json/

RUN echo '#!/bin/bash\npython2 /volatility2/vol.py ${@}' > /bin/vol2 \
    && chmod +x /bin/vol2 

RUN echo '#!/bin/bash\npython3 /volatility3/vol.py ${@}' > /bin/vol3 \
&& chmod +x /bin/vol3 

RUN mkdir -p /workspace/
VOLUME /workspace/
WORKDIR /workspace/

CMD /bin/bash
