FROM debian:bookworm-slim

USER root

# ၁။ လိုအပ်သော Linux packages နှင့် Node.js အားလုံးကို Debian အစစ်ထဲ သွင်းခြင်း
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    ffmpeg \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ၂။ Node.js 18 နှင့် n8n နောက်ဆုံးဗားရှင်းကို အသေအချာ သွင်းခြင်း
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g n8n@latest

# ၃။ python virtual environment ဆောက်ပြီး yt-dlp အား အပြီးသတ်သွင်းခြင်း
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -U yt-dlp

# ပတ်လမ်းကြောင်း သတ်မှတ်ချက်
ENV PATH="/opt/venv/bin:$PATH"

# ၄။ Bro ရဲ့ JSON ထဲက ပတ်လမ်းကြောင်းအတိုင်း ရာနှုန်းပြည့် ဖိုင်တွဲဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    useradd -m -u 1000 node || true && \
    chown -R 1000:1000 /home/node/

EXPOSE 5678
USER 1000
CMD ["n8n", "start"]
