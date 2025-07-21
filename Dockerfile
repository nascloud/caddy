# Dockerfile

# 第一阶段：使用 Caddy 官方的 builder 镜像
FROM caddy:null-builder AS builder

# 添加你需要的 DNS 插件
RUN xcaddy build --with github.com/libdns/tencentcloud \
                 --with github.com/caddy-dns/cloudflare \
                 --with github.com/caddy-dns/alidns

# 第二阶段：使用 Caddy 官方的运行时镜像
# 确保这里的版本号与 builder 阶段的完全一致
FROM caddy:null

# 从第一阶段复制构建好的、包含插件的 Caddy 二进制文件
COPY --from=builder /usr/bin/caddy /usr/bin/caddy