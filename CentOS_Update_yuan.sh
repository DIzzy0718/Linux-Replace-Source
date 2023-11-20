#!/bin/bash  
  
# 切换到/etc/yum.repos.d/目录  
echo "正在切换到 /etc/yum.repos.d/ 目录..."  
cd /etc/yum.repos.d/  
  
# 打印源选项  
echo "请选择要使用的源:"  
echo "1. 阿里云"  
echo "2. 腾讯云"  
echo "3. 华为云"  
echo "输入源编号后按回车键："  
  
# 读取用户输入并存储在变量中  
read selected_source  
  
# 根据用户选择执行相应的操作  
case $selected_source in  
    1)  
        echo "正在从阿里云源下载新的 .repo 文件..."  
        wget -O Centos-7.repo "http://mirrors.aliyun.com/repo/Centos-7.repo"  
        ;;  
    2)  
        echo "正在从腾讯云源下载新的 .repo 文件..."  
        wget -O Centos-7.repo "http://mirrors.cloud.tencent.com/CentOS/7/os/x86_64/CentOS-7.repo"  
        ;;  
    3)  
        echo "正在从华为云源下载新的 .repo 文件..."  
        wget -O Centos-7.repo "http://mirrors.huaweicloud.com/centos/7/os/x86_64/CentOS-7.repo"  
        ;;  
    *)  
        echo "无效的源选项"  
        exit 1  
        ;;  
esac  
  
# 清理yum缓存  
echo "正在清理 yum 缓存..."  
yum clean all  
  
# 生成yum缓存  
echo "正在生成 yum 缓存..."  
yum makecache  
  
# 更新系统软件包  
echo "正在更新系统软件包..."  
yum update -y