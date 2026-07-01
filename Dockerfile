FROM docker.io/n8nio/n8n:latest

USER root

# Alpine Linux စနစ်အတွက် အလုပ်လုပ်မည့် စစ်မှန်သော ကွန်ဖစ်
RUN apk add --no-cache ffmpeg python3 py3-pip || (apt-get update && apt-get install -y --no-install-recommends ffmpeg python3 python3-pip python3-venv)

# python virtual environment ကို စနစ်တကျ တည်ဆောက်ခြင်း
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -U yt-dlp

# ပတ်လမ်းကြောင်း သတ်မှတ်ချက်
ENV PATH="/opt/venv/bin:$PATH"

# Bro ရဲ့ JSON ထဲက ပတ်လမ်းကြောင်းအတိုင်း Folder ဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    chown -R node:node /home/node/ || chown -R 1000:1000 /home/node/

USER node
