# OpenCV 3 - Docker image

Docker image for OpenCV 3.1.0 with Python3 support and FFmpeg with x264 enabled. It is meant to be used in servers for video processing task or just for scripting purposes.

## Building

You can build and modify this image by cloning the project and executing:

```
docker build -t fradelg/opencv .
```

## Checking

Just exec `docker-compose up`

and you should see a message like

```
opencv_1  | You have OpenCV <version> installed!
```

## Running

To make the image lightweight it lacks of an X11 environment installed so, for example, you cannot use cv::createWindow or cv::waitKey functions.However, you can create a container with access rights to your webcam writing:

```
docker run -it --privileged --device /dev/video0:/dev/video0 fradelg/opencv python3
```

which launches a Python 3 shell with the cv2 package available
