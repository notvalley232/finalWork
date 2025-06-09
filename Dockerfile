# 使用官方Nginx镜像作为基础
FROM nginx:alpine

# 将本地html文件夹复制到容器中的Nginx默认网站目录
COPY lrh-profile/html/ /usr/share/nginx/html/

# 暴露80端口
EXPOSE 80

# 启动Nginx服务
CMD ["nginx", "-g", "daemon off;"]