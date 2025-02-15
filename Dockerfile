FROM osrf/ros:melodic-desktop-full-bionic

# Install dependencies
RUN apt-get update && apt-get install -y \
    ros-melodic-serial \
    ros-melodic-velodyne \
    ros-melodic-cartographer \
    ros-melodic-cartographer-ros

# Setup ROS environment
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    mkdir -p ~/catkin_ws/src

# Copy source files
WORKDIR /root/catkin_ws/src
COPY ./velodyne_wt61c ./velodyne_wt61c
COPY ./wt61c_uart ./wt61c_uart

# Build
WORKDIR /root/catkin_ws
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make' && \
    echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
