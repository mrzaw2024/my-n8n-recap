FROM n8nio/n8n:latest

USER root

# yt-dlp နှင့် ffmpeg ကို အပြည့်အစုံ သွင်းခြင်း
RUN apk add --no-cache ffmpeg python3 py3-pip && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -U yt-dlp

# ပတ်လမ်းကြောင်း သတ်မှတ်ချက်
ENV PATH="/opt/venv/bin:$PATH"

# Bro ရဲ့ JSON ထဲကအတိုင်း ဖိုင်တွဲဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    chown -R node:node /home/node/

USER node
