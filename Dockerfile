FROM    dev
COPY docker/get_sha.rb /tmp/get_sha.rb
RUN /tmp/get_sha.rb martinrhoads dots testing 6ed9eddf76dac79d020edce074d7dce2b18b5bbc
#RUN curl -s https://raw.githubusercontent.com/martinrhoads/dots/testing/bin/one-liner.sh | bash

COPY . /tmp/dots
RUN sudo chown -R martin:martin /tmp/dots
USER martin    
RUN /tmp/dots/bin/dots.sh configure
