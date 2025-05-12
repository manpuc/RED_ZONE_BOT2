FROM python:3.11

WORKDIR /bot

# 必要なパッケージとロケールを一括インストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        locales \
        ffmpeg \
        git \
        build-essential \
        libgl1 \
        libglib2.0-0 && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 環境変数設定
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    TERM=xterm

# Python依存ライブラリのインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# プロジェクト全体コピー
COPY . .

# FastAPIサーバー用にポート開放
EXPOSE 8080

# アプリの実行（main.pyがBotとFastAPIサーバーを両方起動）
CMD ["python", "app/main.py"]
