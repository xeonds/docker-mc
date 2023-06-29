#!/bin/bash

# 定义容器名称和配置文件路径
CONTAINER_NAME=frpc
CONFIG_FILE=$(pwd)/frpc.ini

# 检查参数个数
if [ $# -eq 0 ]; then
    echo "Usage: $0 run|start|stop|restart"
    exit 1
fi

# 根据参数执行相应操作
case $1 in
    run)
        # 部署容器
        docker run --restart=always --network host -d -v $CONFIG_FILE:/etc/frp/frpc.ini --name $CONTAINER_NAME snowdreamtech/frpc
        ;;
    start)
        # 启动容器
        docker start $CONTAINER_NAME
        ;;
    stop)
        # 停止容器
        docker stop $CONTAINER_NAME
        ;;
    restart)
        # 重启容器
        docker restart $CONTAINER_NAME
        ;;
    *)
        # 无效参数
        echo "Invalid argument: $1"
        echo "Usage: $0 run|start|stop|restart"
        exit 2
        ;;
esac

# 打印容器状态
docker ps -a | grep $CONTAINER_NAME

