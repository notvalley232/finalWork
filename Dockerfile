# 使用官方Nginx镜像作为基础
FROM nginx:alpine

# 删除默认Nginx页面，防止覆盖你的index.html
RUN rm -rf /usr/share/nginx/html/*

# 复制本地html文件夹到Nginx默认网站目录
COPY ./lrh_profile_html/html/ /usr/share/nginx/html/

# 设置目录权限，确保nginx用户可读
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html
RUN mkdir -p /var/cache/nginx/client_temp && chmod -R 755 /var/cache/nginx
# 健康检查
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

EXPOSE 80

USER nginx

CMD ["nginx", "-g", "daemon off;"]