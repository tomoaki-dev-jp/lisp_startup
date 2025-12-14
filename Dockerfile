# Common Lisp 開発環境（SBCL + Quicklisp）
FROM debian:bookworm-slim

# 基本パッケージ + ビルドツール + CA証明書
RUN apt-get update && apt-get install -y \
    sbcl \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリ設定
WORKDIR /workspace

# REPL を起動
CMD ["sbcl"]
