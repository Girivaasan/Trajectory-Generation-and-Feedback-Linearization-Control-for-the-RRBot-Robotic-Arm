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
## Running the control node
```
roslaunch rrbot_control rrbot_effort_control.launch
```
After running the control node, run the 'rrbot_traj_control.m' matlab file provided in the repository.

https://user-images.githubusercontent.com/118299474/209412574-bb3b6c8b-1dce-431b-9b49-c7b86aa4136a.mp4

## Performance Plots
The plot depicts the desired trajectory generated, that must be followed by the rrbot manipulator and the performance of the manipulator. 

![Screenshot from 2022-12-23 18-15-24](https://user-images.githubusercontent.com/118299474/209414132-8b97b38c-dbe2-436f-aa4b-aa9ba3209fb7.png)

