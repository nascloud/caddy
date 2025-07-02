# Dockerfile

# 第一阶段：使用 Caddy 官方的 builder 镜像
# 我们指定一个明确的版本号，这样构建是可复现和稳定的
FROM caddy:2.7.6-builder AS builder

# 添加你需要的 DNS 插件
RUN xcaddy build --with github.com/caddy-dns/dnspod@latest \
                 --with github.com/caddy-dns/cloudflare@latest \
                 --with github.com/caddy-dns/alidns@latest

# 第二阶段：使用 Caddy 官方的运行时镜像
FROM caddy:2.7.6

# 从第一阶段复制构建好的、包含插件的 Caddy 二进制文件
COPY --from=builder /usr/bin/caddy /usr/bin/caddy