# ubuntu-sh
# Ubuntu 快捷脚本集合

这是一个用于 Ubuntu 系统的 Bash 脚本集合，支持一键配置国内镜像源与安装常用开发组件。目前已支持：

- Ubuntu 22.04 LTS (jammy)
- Ubuntu 24.04 LTS (noble)

---

## 📦 脚本列表

### 1. Ubuntu 22.04 - 更换为阿里云镜像源

```bash
curl -fsSL https://gitee.com/andyrio/bash/raw/master/aliyun_jammy.sh | sudo bash
````

### 2. Ubuntu 24.04 - 更换为阿里云镜像源

```bash
curl -fsSL https://gitee.com/andyrio/bash/raw/master/aliyun_noble.sh | sudo bash
```

### 3. 安装 Docker（适用于所有支持的 Ubuntu 版本）

```bash
curl -fsSL https://gitee.com/andyrio/bash/raw/master/install_docker.sh | sudo bash
```

### 4. 添加/删除 Swap 文件（适用于非 OpenVZ 的 Ubuntu VPS）

```bash
curl -fsSL https://gitee.com/andyrio/bash/raw/master/swap.sh | sudo bash
```

---

## 🛠 脚本功能说明

### 镜像源更换脚本

- 自动检测系统版本代号（如 `jammy`, `noble`)
    
- 自动备份原始 `/etc/apt/sources.list`
    
- 自动写入阿里云加速源配置
    
- 自动执行 `apt update`
    
- 安全提示：非目标版本会要求确认
    

### Docker 安装脚本

- 使用 Docker 官方安装脚本安装最新版 Docker
    
- 自动将当前用户添加到 `docker` 组
    
- 自动设置 Docker 开机自启
    
- 显示安装后版本信息
    

### Swap 脚本

- 添加 Swap：支持以 GB 为单位输入大小，自动创建并挂载 `/swapfile`
    
- 删除 Swap：自动卸载并移除 swap 文件及 `/etc/fstab` 配置
    
- 自动检测是否为 OpenVZ 架构，避免不兼容系统执行
    
- 适合 VPS 内存不足场景临时扩展虚拟内存
    

---

## 📂 目录结构

```
.
├── aliyun_jammy.sh      # Ubuntu 22.04 镜像源脚本
├── aliyun_noble.sh      # Ubuntu 24.04 镜像源脚本
├── install_docker.sh    # 一键安装 Docker 脚本
├── swap.sh              # 添加/删除 Swap 脚本
└── README.md            # 项目说明文件
```
