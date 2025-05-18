#!/usr/bin/env bash
# Blog: https://www.moerats.com/

Green="\033[32m"
Font="\033[0m"
Red="\033[31m" 

# root权限检查
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}Error: This script must be run as root!${Font}"
        exit 1
    fi
}

# 检测是否为 OpenVZ 架构
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}Your VPS is based on OpenVZ, not supported!${Font}"
        exit 1
    fi
}

# 添加 swap（单位：GB）
add_swap(){
    echo -e "${Green}请输入需要添加的 swap（单位：G，建议为内存的2倍）${Font}"
    read -p "请输入 swap 数值: " swapsize

    grep -q "swapfile" /etc/fstab

    if [ $? -ne 0 ]; then
        echo -e "${Green}swapfile 未发现，正在创建 ${swapsize}G 的 swapfile${Font}"
        fallocate -l ${swapsize}G /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap defaults 0 0' >> /etc/fstab
        echo -e "${Green}swap 创建成功，信息如下：${Font}"
        cat /proc/swaps
        grep Swap /proc/meminfo
    else
        echo -e "${Red}swapfile 已存在，swap 设置失败，请先运行脚本删除 swap 后重新设置！${Font}"
    fi
}

# 删除 swap
del_swap(){
    grep -q "swapfile" /etc/fstab

    if [ $? -eq 0 ]; then
        echo -e "${Green}swapfile 已发现，正在将其移除...${Font}"
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
        echo -e "${Green}swap 已删除！${Font}"
    else
        echo -e "${Red}swapfile 未发现，swap 删除失败！${Font}"
    fi
}

# 主菜单
main(){
    root_need
    ovz_no
    clear
    echo -e "———————————————————————————————————————"
    echo -e "${Green}Linux VPS 一键添加/删除 swap 脚本${Font}"
    echo -e "${Green}1、添加 swap${Font}"
    echo -e "${Green}2、删除 swap${Font}"
    echo -e "———————————————————————————————————————"
    read -p "请输入数字 [1-2]: " num
    case "$num" in
        1)
            add_swap
            ;;
        2)
            del_swap
            ;;
        *)
            clear
            echo -e "${Green}请输入正确数字 [1-2]${Font}"
            sleep 2s
            main
            ;;
    esac
}

main
