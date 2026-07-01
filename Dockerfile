FROM n8nio/n8n:1.0.5

USER root

# တည်ငြိမ်သော Debian Base မို့ apt-get အသုံးပြု၍ ffmpeg နှင့် python သွင်းခြင်း
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

# Bro ရဲ့ JSON ထဲက ပတ်လမ်းကြောင်းအတိုင်း Folder ဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    chown -R node:node /home/node/

USER node
