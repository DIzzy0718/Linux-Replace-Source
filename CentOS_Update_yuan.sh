#!/bin/bash  
  
# 切换到/etc/yum.repos.d/目录  
echo "正在切换到 /etc/yum.repos.d/ 目录..."  
cd /etc/yum.repos.d/ || exit 1  # 如果cd失败则直接退出

# 打印源选项  
echo "请选择要使用的源:"  
echo "1. 阿里云(Centos 7)"  
echo "2. 腾讯云(Centos 7)"  
echo "3. 华为云(Centos 7)"  
echo "4. 阿里云(Centos 8)"  
echo "5. 腾讯云(Centos 8)"  
echo "6. 华为云(Centos 8)"  
echo "输入源编号后按回车键："  
  
# 读取用户输入并存储在变量中，然后进行验证
read selected_source_id  
if ! [[ "$selected_source_id" =~ ^[1-6]$ ]]; then
    echo "无效的源选项，请输入1、2、3、4、5或6"
    exit 1
fi
  
# 根据用户选择执行相应的操作  
case $selected_source_id in  
    1|4) chosen_mirror="http://mirrors.aliyun.com/repo";;
    2|5) chosen_mirror="http://mirrors.cloud.tencent.com/CentOS";;
    3|6) chosen_mirror="http://mirrors.huaweicloud.com/centos";;
esac  

# 根据用户的选择，确定具体的版本和URL
if [ $selected_source_id -lt 4 ]; then
    VERSION="7"
else
    VERSION="8"
fi
URL="${chosen_mirror}/${VERSION}/os/x86_64/CentOS-${VERSION}.repo"

# 下载.repo文件  
echo "正在从${chosen_mirror}源下载新的 .repo 文件(Centos ${VERSION})..."  
wget -qO- "$URL" > "Centos-${VERSION}.repo" || #{ echo "下载失败！"; exit 1; }
  
# 清理yum缓存  
echo "正在清理 yum 缓存..."  
yum clean all || { echo "清理yum缓存失败！"; exit 1; }
  
# 生成yum缓存  
echo "正在生成 yum 缓存..."  
yum makecache || { echo "生成yum缓存失败！"; exit 1; }
  
# 更新系统软件包  
echo "正在更新系统软件包..."  
yum update -y || { echo "更新系统软件包失败！"; exit 1; }