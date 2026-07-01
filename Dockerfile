FROM python:3.10-slim

# root အနေဖြင့် လိုအပ်သော Linux tools အားလုံး သွင်းခြင်း
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Node.js နှင့် n8n ကို တိုက်ရိုက် သွင်းခြင်း
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g n8n@latest

# yt-dlp ကို သွင်းခြင်း
RUN pip install --no-cache-dir -U yt-dlp

# Bro ရဲ့ JSON ထဲက ပတ်လမ်းကြောင်းအတိုင်း Folder ဆောက်ပြီး ခွင့်ပြုချက်ပေးခြင်း
RUN mkdir -p /home/node/.n8n-files/movie-recap && \
    useradd -u 1000 node || true && \
    chown -R 1000:1000 /home/node/

# Port ဖွင့်ခြင်းနှင့် မောင်းနှင်ခြင်း
EXPOSE 5678
USER 1000
CMD ["n8n", "start"]
