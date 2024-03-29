FROM bit:5000/yry_tmp

ARG http_proxy=http://202.38.69.70:3129
ARG https_proxy=http://202.38.69.70:3129

RUN apt update; DEBIAN_FRONTEND=noninteractive apt install -y tzdata openssh-server rsync vim git unrar p7zip-full && \
apt autoclean && apt autoremove

ENV TZ=Asia/Shanghai

RUN which pip && pip config set global.trusted-host mirrors.aliyun.com && \
    pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/ && \
    pip install --upgrade pip --no-cache-dir && \
    pip install timm einops basicsr --no-cache-dir && \
    pip install opencv-python-headless matplotlib scikit-learn --no-cache-dir && \
    pip install bitsandbytes --no-cache-dir && \
    pip install diffusers[torch] transformers accelerate datasets --no-cache-dir && \
    pip install dists-pytorch lpips torchmetrics piq pyiqa --no-cache-dir && \
    pip install tensorboard wandb --no-cache-dir && \
    pip install gdown lmdb --no-cache-dir && \
    pip install pandas scikit-image imageio --no-cache-dir && \
    pip install omegaconf --no-cache-dir && \
    pip install python-dotenv icecream --no-cache-dir && \
    # pip install pandas yapf scikit-image future addict tomli lazy_loader PyWavelets imageio --no-cache-dir && \
    conda clean --all -y

# Add a user
RUN useradd -m yry -u 1015 -s /bin/bash && \
    echo "yry:122408" | chpasswd && \
    echo "yry ALL=(ALL) ALL" >> /etc/sudoers

USER yry
WORKDIR /home/yry