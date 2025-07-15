# **Docker Setup Guide for Ubunto22 ROS2- Humble- PX4 - Gazebo gz**

This documentation provides a step-by-step guide on how to install Docker locally on a Linux system and use it as a container for `Ros2/Humble`.

---

## **1. Install Docker on Your Host Machine**

To install Docker easily, use the following script:

```bash
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### **Run Docker as a Non-Root User**
It is recommended to run Docker as a non-root user to prevent your build folder from being owned by root. Execute the following commands in a new terminal:

```bash
# Create docker group (may not be required)
sudo groupadd docker

# Add your user to the docker group.
sudo usermod -aG docker $USER
```

**Now log out and log back in before using Docker!!**

---

## **2. Build the Docker Image**

The following command builds the Docker image on your host machine. This step is required only once unless you modify the `Dockerfile`.

```bash
git clone https://github.com/alisrour97/px4-dev-simulation-ros2-humble.git
cd px4-dev-simulation-ros2-humble
./build.bash Humble
```

---

## **3. Run the Docker Container**

Before running the docker **Copy the `create_px4_container.sh` script** inside `PX4_Experiments` or
any directory of choice where you have your ROS2 nodes/ws. If you change ws name from `PX4_Experiments`, you just need to modify it
from the script `create_px4_container.sh`.

Enter the Docker container, execute the following steps:

```bash
chmod +x create_dc_ros2.sh
./create_dc_ros2.sh
```

This starts the Docker container, and its name will be `px4_ros2`.
Just as a note `chmod +x ` is required only once to give permission.

---

## **4. Managing the Docker Container**

If you need to open another instance in a separate terminal, use:

```bash
docker exec -u 0 -it px4_ros2 bash
```

To close the container, simply press `Ctrl+D` inside the container.

To restart it later, use:

```bash
docker start px4_ros2
docker attach px4_ros2
```

If you want to remove the container:

```bash
docker rm px4_ros2
```

If the `./create_dc_ros2.sh` script does not open the container, an old instance may still be running. Remove it using:

```bash
docker rm px4_ros2
```

Then, re-run the script:

```bash
./create_px4_container.sh
```

---


