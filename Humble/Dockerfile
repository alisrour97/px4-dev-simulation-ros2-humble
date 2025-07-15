FROM ubuntu:22.04

# environment
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
ENV XDG_RUNTIME_DIR=/tmp/runtime-docker
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV GZ_PARTITION=px4_gz
ENV TERM=xterm-256color
ENV DISPLAY=:20
ENV PATH="/home/user/bin:${PATH}"

# Set default shell during Docker image build to bash
SHELL ["/bin/bash", "-l", "-c"]

# Copy docker clean script
COPY install/docker_clean.sh /docker_clean.sh
RUN chmod +x /docker_clean.sh

# Install base packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install --no-install-recommends -y \
		sudo \
		locales \
		&& \
	/docker_clean.sh

# Initialise system locale
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
RUN locale-gen en_US.UTF-8

# install dependencies using scripts in a manner that will cache build
# when one script is modified
COPY install/base.sh /tmp/install/base.sh
RUN bash /tmp/install/base.sh && /docker_clean.sh

COPY install/ros.sh /tmp/install/ros.sh
RUN bash /tmp/install/ros.sh && /docker_clean.sh

COPY install/gazebo.sh /tmp/install/gazebo.sh
RUN bash /tmp/install/gazebo.sh && /docker_clean.sh

COPY install/extra.sh /tmp/install/extra.sh
RUN bash /tmp/install/extra.sh && /docker_clean.sh

# enable apt auto-completion by deleting autoclean task
RUN sudo rm /etc/apt/apt.conf.d/docker-clean

# create XDG runtime dir
RUN mkdir /tmp/runtime-docker && sudo chmod 700 /tmp/runtime-docker
COPY install/user_setup.sh /tmp/install/user_setup.sh
RUN /tmp/install/user_setup.sh && /docker_clean.sh

# create setting directory for gazebo
VOLUME /home/user/.gz
RUN mkdir -p /home/user/.gz
COPY install/px4_setup.sh /home/user/px4_setup.sh
RUN bash /home/user/px4_setup.sh && rm /home/user/px4_setup.sh



# setup entry point
COPY install/entrypoint.sh /
RUN sudo chmod +x /entrypoint.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/entrypoint.sh"]

