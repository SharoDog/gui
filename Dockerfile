FROM --platform=linux/amd64 ubuntu:22.04

LABEL maintainer="kaloyankdimitrov"
    
ENV ANDROID_SDK_TOOLS_VERSION 9477386
ENV ANDROID_SDK_TOOLS_CHECKSUM bd1aa17c7ef10066949c88dc6c9c8d536be27f992a1f3b5a584f9bd2ba5646a0

ENV ANDROID_HOME "/opt/android-sdk"
ENV ANDROID_SDK_ROOT $ANDROID_HOME
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools:$ANDROID_HOME/cmdline-tools/latest:$ANDROID_HOME/platform-tools

ENV DEBIAN_FRONTEND=noninteractive

# Add base environment
RUN apt-get -qq update \
    && apt-get -qqy --no-install-recommends install \
    apt-utils \
	locales \
    openjdk-18-jdk \
    openjdk-18-jre-headless \
    software-properties-common \
    build-essential \
    libstdc++6 \
    libpulse0 \
    libglu1-mesa \
	libgl1-mesa-dev \
	libxkbcommon-x11-0 \
    openssh-server \
    unzip \
	wget \
    curl \
    lldb \
	python3 \
	python3-pip \
    git > /dev/null \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
      
# Set locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Download and unzip Android SDK Tools
RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip > /tools.zip \
    && echo "$ANDROID_SDK_TOOLS_CHECKSUM ./tools.zip" | sha256sum -c \
    && unzip -qq /tools.zip -d $ANDROID_HOME \
    && rm -v /tools.zip

# Accept licenses
RUN mkdir -p $ANDROID_HOME/licenses/ \
    && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > $ANDROID_HOME/licenses/android-sdk-license \
    && echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_HOME/licenses/android-sdk-preview-license --licenses \
    && yes | $ANDROID_HOME/cmdline-tools/bin/sdkmanager --licenses --sdk_root=${ANDROID_SDK_ROOT}

# Install Qt
RUN python3 -m pip install aqtinstall==3.1.7 cmake==3.27.0
RUN python3 -m aqt install-qt linux android 6.6.0 android_armv7 --autodesktop --outputdir /opt/qt

# Add non-root user 
RUN groupadd -r sharo \
    && useradd --no-log-init -r -g sharo sharo \
    && mkdir -p /home/sharo/.android \
    && mkdir -p /home/sharo/app \
    && touch /home/sharo/.android/repositories.cfg \
    && chown --recursive sharo:sharo /home/sharo \
    && chown --recursive sharo:sharo /home/sharo/app \
    && chown --recursive sharo:sharo $ANDROID_HOME

# Set non-root user as default      
ENV HOME /home/sharo
USER sharo
WORKDIR $HOME/app

# Install Android packages
RUN $ANDROID_HOME/cmdline-tools/bin/sdkmanager --update  --sdk_root=${ANDROID_SDK_ROOT} 
RUN $ANDROID_HOME/cmdline-tools/bin/sdkmanager "build-tools;34.0.0" "platforms;android-33" "ndk;25.1.8937393"  --sdk_root=${ANDROID_SDK_ROOT} 

COPY --chown=sharo:sharo . $HOME/app
