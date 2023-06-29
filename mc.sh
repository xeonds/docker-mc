#!/bin/bash

# 获取第一个参数
action=$1

# 根据参数执行不同的操作
case $action in
  run) # 运行容器
    docker run -d \
      -p 25565:25565 \
      -v $(pwd)/world:/app/world \
      -v $(pwd)/server.jar:/app/server.jar \
      -v $(pwd)/server.properties:/app/server.properties \
      --name mc \
      mc-server
    ;;
  build) # 构建镜像
    docker build -t mc-server .
    ;;
  stop) # 停止容器
    docker stop mc
    ;;
  start) # 启动容器
    docker start mc
    ;;
  restart) # 重启容器
    docker restart mc
    ;;
  backup) # 备份文件
    timestamp=$(date +%Y%m%d%H%M%S)
    zip -r mc-backup-$timestamp.zip world server.properties mc.sh Dockerfile server.jar
    ;;
  log) # 输出日志
    docker logs -f mc
    ;;
  sh) # 进入shell
    docker exec -it mc sh
    ;;

  *) # 输出帮助信息并退出
    echo "Usage: $0 {run|build|stop|start|restart|log|sh}"
    exit 1
    ;;
esac

