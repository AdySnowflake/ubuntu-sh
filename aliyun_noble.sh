#!/bin/bash

# 确保使用 root 权限运行
if [[ $EUID -ne 0 ]]; then
    echo "请以 root 权限运行此脚本！"
    exit 1
fi

DISTRO=$(lsb_release -cs)
if [[ "$DISTRO" != "noble" ]]; then
    echo "⚠️ 当前系统版本为 $DISTRO，建议用于 Ubuntu 24.04（noble）"
    read -p "是否继续？[y/N] " confirm
    [[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 1
fi

# 备份旧的 sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "✅ 备份旧源为 /etc/apt/sources.list.bak"

# 写入阿里云源
cat > /etc/apt/sources.list <<EOF
deb http://mirrors.aliyun.com/ubuntu/ noble main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ noble main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ noble-security main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ noble-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ noble-updates main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ noble-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ noble-backports main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ noble-backports main restricted universe multiverse
EOF

# 更新软件源缓存
echo "📦 更新软件源列表..."
apt update

echo "🎉 Ubuntu 24.04 的阿里云源更换完成！"
