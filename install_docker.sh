#!/bin/bash

# 确保 root 权限
if [[ $EUID -ne 0 ]]; then
    echo "请使用 root 权限运行此脚本（例如 sudo）"
    exit 1
fi

# 安装 Docker（官方脚本）
echo "🚀 正在通过官方脚本安装 Docker..."
curl -fsSL https://get.docker.com | bash -s docker

# 检查安装是否成功
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 安装失败，请检查网络或源问题。"
    exit 1
fi

# 添加当前用户进 docker 组（非 root 用户执行有效）
CURRENT_USER=$(logname)
usermod -aG docker "$CURRENT_USER"
echo "✅ 已将 $CURRENT_USER 添加到 docker 用户组（需重新登录生效）"

# 设置 Docker 开机启动
systemctl enable docker

# 输出版本信息
echo "✅ Docker 安装完成，版本信息如下："
docker --version
docker compose version || docker-compose version || echo "⚠️ 未检测到 docker compose，请单独安装"

echo "🎉 全部完成！重新登录后即可无 sudo 使用 docker 命令"
