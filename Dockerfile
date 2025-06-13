FROM nginx:alpine

# 删除默认页面
RUN rm -rf /usr/share/nginx/html/*

# 复制网站文件
COPY ./lrh_profile_html/html/ /usr/share/nginx/html/

# 复制自定义 Nginx 配置（覆盖默认）
COPY default.conf /etc/nginx/conf.d/default.conf

# 设置权限
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    mkdir -p /var/run/nginx /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/run/nginx /var/cache/nginx

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80 81

CMD ["nginx", "-g", "daemon off;"]
