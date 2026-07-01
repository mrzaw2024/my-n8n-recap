FROM n8nio/n8n:latest-alpine

USER root

# တရားဝင် Alpine base မို့ apk သုံးပြီး ffmpeg နှင့် python ကို အပြည့်အစုံသွင်းခြင်း
RUN apk add --no-cache ffmpeg python3 py3-pip && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -U yt-dlp

# ပတ်လမ်းကြောင်း သတ်မှတ်ချက်
ENV PATH="/opt/venv/bin:$PATH"

# Bro ရဲ့ JSON ထဲက ပတ်လမ်းကြောင်းအတိုင်း Folder ဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    chown -R node:node /home/node/

USER node
