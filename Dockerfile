FROM node:10-alpine

ENV LANG=C.UTF-8

#安装
ADD entrypoint.sh /bin/entrypoint.sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache git \
    && npm config set unsafe-perm true \
    && npm install -g hexo-cli \
    && npm cache clear --force \
    && npm config set unsafe-perm false \
    && rm -rf /tmp/* \
    && hexo init hexo \
    && apk del git \
    && cd hexo && npm install \
    && npm install --save hexo-admin \
	&& cp -R /hexo /usr/local/



# 工作目录
WORKDIR /hexo

# 开放端口
EXPOSE 4000

# 执行命令
ENTRYPOINT ["entrypoint.sh"]
CMD ["hexo","server"]