FROM nginx:alpine

# 删除默认页面
RUN rm -rf /usr/share/nginx/html/*

# 复制网站文件
COPY ./lrh_profile_html/html/ /usr/share/nginx/html/

# 设置权限（nginx 用户需要写权限的目录）
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    mkdir -p /var/run/nginx /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/run/nginx /var/cache/nginx

# 使用 curl 进行健康检查（alpine 默认有 curl）
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80

# 最后切换到 nginx 用户
USER nginx

CMD ["nginx", "-g", "daemon off;"]