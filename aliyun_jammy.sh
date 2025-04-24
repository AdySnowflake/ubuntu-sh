#!/bin/bash

# 检查是否为 root 用户
if [[ $EUID -ne 0 ]]; then
    echo "请以 root 权限运行此脚本！"
    exit 1
fi

# 自动检测系统发行版代号
DISTRO=$(lsb_release -cs)
if [[ "$DISTRO" != "jammy" ]]; then
    echo "⚠️ 检测到系统代号为 $DISTRO，本脚本推荐用于 Ubuntu 22.04（jammy）"
    read -p "是否继续？[y/N] " confirm
    [[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 1
fi

# 备份旧源
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "已备份旧 sources.list 到 sources.list.bak"

# 写入阿里云 jammy 镜像源
cat > /etc/apt/sources.list <<EOF
deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
EOF

# 更新软件源
echo "正在刷新 apt 源..."
apt update

echo "✅ 阿里云源已成功应用到 Ubuntu 22.04！"
