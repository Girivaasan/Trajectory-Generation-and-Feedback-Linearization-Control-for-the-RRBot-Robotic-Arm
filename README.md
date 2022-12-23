# Trajectory Generation and Feedback-Linearization Control for the RRBot Robotic Arm

## Creating a ROS Workspace

**Follow these commands**
```
mkdir -p ~/RRbot_ros/src
cd ~/RRbot_ros
catkin_make
echo "source ~/RRbot_ros/devel/setup.bash" >> ~/.bashrc
source ~/RRbot_ros/devel/setup.bash
```
## Clone the repository
```
cd ~/RRbot_ros/src
git clone https://github.com/ros-simulation/gazebo_ros_demos.git
```
## Update the workspace
```
sudo apt-get update
sudo apt-get upgrade
sudo apt update
sudo apt-get install ros-noetic-ros-control ros-noetic-ros-controllers
sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control
```
## Catkin-make
```
cd ~/RRbot_ros
catkin_make
```
## Launching the robot in Gazebo
```
roslaunch rrbot_gazebo rrbot_world.launch
```


https://user-images.githubusercontent.com/118299474/209412026-1df3e8ec-bdfe-46ae-a36d-a0fa84d07238.mp4


