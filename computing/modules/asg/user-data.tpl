#!/bin/bash
docker run -dt --name ${app} -p ${docker_map_port} --restart always ${docker_image}
