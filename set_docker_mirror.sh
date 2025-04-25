#!/bin/bash

# 必须用 root 权限运行
if [[ $EUID -ne 0 ]]; then
    echo "请使用 sudo 运行此脚本！"
    exit 1
fi

# 检查 Docker 是否已安装
if ! command -v docker &> /dev/null; then
    echo "⚠️ Docker 未安装，请先运行 install_docker.sh 安装"
    exit 1
fi

# 创建 /etc/docker 目录（如果不存在）
# mkdir -p /etc/docker

# 写入镜像加速配置
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://docker.xuanyuan.me"
  ]
}
EOF

echo "✅ 镜像源已写入 /etc/docker/daemon.json"

# 重新加载 systemd 配置并重启 Docker
systemctl daemon-reload
systemctl restart docker

echo "🎉 Docker 镜像源设置完成！你现在使用的是加速的镜像源。"
