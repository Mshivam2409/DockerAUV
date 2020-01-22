FROM ros:melodic

RUN sudo apt update
RUN sudo apt-get install -y ros-melodic-catkin python-catkin-tools 
RUN mkdir -p /catkin_ws/src 
RUN cd /catkin_ws/src && \ 
    . /opt/ros/melodic/setup.sh && \
    catkin_init_workspace && \
    cd .. && \
    catkin_make
RUN cd /catkin_ws/src && \
    git clone https://github.com/AUV-IITK/AnahitaPlus.git 
RUN cd /catkin_ws/src && \
    git clone https://github.com/AUV-IITK/uuv_simulator    
RUN sudo apt-get -y install ros-melodic-usb-cam \
                     ros-melodic-geographic-msgs \
                     ros-melodic-rosserial-arduino \
                     ros-melodic-underwater-sensor-msgs \
                     ros-melodic-grid-map \
                     ros-melodic-image-geometry \
                     ros-melodic-tf
RUN sudo apt install -y python-pip                        
RUN pip install scipy
RUN sudo apt install -y wget
RUN sudo apt update
RUN sudo sh -c  'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list' && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - 
RUN sudo apt-get update  
RUN sudo apt-get install -y libgazebo9 
RUN sudo apt-get install libgazebo9 --fix-missing 
RUN sudo apt-get install -y gazebo9 
RUN sudo apt install -y ros-melodic-gazebo*
RUN sudo apt install -y ros-melodic-xacro*
RUN sudo apt install -y ros-melodic-roslint*
RUN sudo apt install -y ros-melodic-pcl*
RUN sudo apt install -y ros-melodic-tf*

RUN cd /catkin_ws  && \
    . /opt/ros/melodic/setup.sh && \
    catkin_make -DCMAKE_BUILD_TYPE=Release -j8; exit 0 
RUN cd /catkin_ws  && \
    /bin/bash -c "source devel/setup.bash"
CMD cd /catkin_ws && \
    /bin/bash -c "source devel/setup.bash" && \
     roscore

 
