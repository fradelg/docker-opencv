#
# Docker file for OpenCV image based on official Ubuntu image
#
# BUILD:
# docker build -t fradelg/opencv:3.2.0 .
#
# RUN:
# docker run --rm -it --priviledge --device /dev/video0:/dev/video0 fradelg/opencv:3.2.0 bash
#

FROM fradelg/ffmpeg
MAINTAINER Francisco Javier Delgado del Hoyo "frandelhoyo@gmail.com"

# Update packages, install dependencies and clean cache
RUN apt-get -y install cmake gfortran libatlas-base-dev liblapacke-dev libeigen3-dev libtbb-dev \
                      python3-dev python3-numpy libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev && \
    apt-get -y autoremove && apt-get -y clean

# Compile OpenCV from sources
RUN curl -L https://github.com/opencv/opencv/archive/3.2.0.tar.gz | tar xz && \
    curl -L https://github.com/opencv/opencv_contrib/archive/3.2.0.tar.gz | tar xz && \
    cd opencv-3.2.0 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DBUILD_PERF_TESTS=OFF \
          -DBUILD_TESTS=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DWITH_FFMPEG:BOOL=ON \
          -DINSTALL_C_EXAMPLES=OFF \
          -DOPENCV_EXTRA_MODULES_PATH=/usr/local/src/opencv_contrib-3.2.0/modules \
          -DINSTALL_PYTHON_EXAMPLES=ON .. && \
    make && make install && \
    cd ../.. && rm -rf opencv-3.2.0 && rm -rf opencv_contrib-3.2.0

# Link Python cv2 module
RUN ln -s /usr/local/lib/python3.5/dist-packages/cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages/cv2.so

WORKDIR /usr/local/share/OpenCV/samples/python
CMD ["/bin/bash"]
