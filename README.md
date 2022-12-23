# Trajectory-Generation-and-Feedback-Linearization-Control-for-the-RRBot-Robotic-Arm

**Creating a ROS Workspace**

Follow these commands
```
mkdir -p ~/RRbot_ros/src
cd ~/RRbot_ros
catkin_make
echo "source ~/RRbot_ros/devel/setup.bash" >> ~/.bashrc
source ~/RRbot_ros/devel/setup.bash
```
```
cd ~/RRbot_ros/src
git clone https://github.com/ros-simulation/gazebo_ros_demos.git
```
```
sudo apt-get update
sudo apt-get upgrade
sudo apt update
sudo apt-get install ros-noetic-ros-control ros-noetic-ros-controllers
sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control
```
##Cmake the workspace
```
cd ~/RRbot_ros
catkin_make
```

```
roslaunch rrbot_gazebo rrbot_world.launch
```

