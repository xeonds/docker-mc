#!/bin/bash

# 获取第一个参数
action=$1
container_name=mc
url=http://www.pushplus.plus/send
token="your_pushplus_token_here"

# 根据参数执行不同的操作
case $action in
  run) # 运行容器
    docker run -d \
      -p 25565:25565 \
      -v $(pwd)/world:/app/world \
      -v $(pwd)/server.jar:/app/server.jar \
      -v $(pwd)/server.properties:/app/server.properties \
      --name $container_name \
      mc-server
    ;;
  build) # 构建镜像
    docker build -t mc-server .
    ;;
  stop) # 停止容器
    docker stop $container_name
    ;;
  start) # 启动容器
    docker start $container_name
    ;;
  restart) # 重启容器
    docker restart $container_name
    ;;
  backup) # 备份文件
    timestamp=$(date +%Y%m%d%H%M%S)
    zip -qr [backup]mc-server-$timestamp.zip world server.properties $0 Dockerfile server.jar
    ;;
  log) # 输出日志
    docker logs -f $container_name
    ;;
  sh) # 进入shell
    docker exec -it $container_name sh
    ;;
  monitor) # 监控报警服务
	$(./$0 log) | grep -E --line-buffered "error|fail|warn" |\
	while read line; 
		do json="{\"token\": \"$token\", \"title\": \"MC服务端异常报警\", \"content\": \"$line\"}"
		curl -H "Content-Type: application/json" -X POST -d "$json" $url
	done
	;;

  *) # 输出帮助信息并退出
    echo "Usage: $0 {run|build|stop|start|restart|backup|log|sh|monitor}"
    exit 1
    ;;
esac

