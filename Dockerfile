FROM n8nio/n8n:latest

USER root

# Debian စနစ်အတွက် apt သုံးပြီး ffmpeg နှင့် python သွင်းခြင်း
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# virtual environment ဆောက်ပြီး yt-dlp သွင်းခြင်း
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -U yt-dlp

# ပတ်လမ်းကြောင်း သတ်မှတ်ချက်
ENV PATH="/opt/venv/bin:$PATH"

# Bro ရဲ့ JSON ထဲကအတိုင်း ဖိုင်တွဲဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    chown -R node:node /home/node/

USER node
