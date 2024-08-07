FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-devel

ARG http_proxy=http://202.38.69.70:3129
ARG https_proxy=http://202.38.69.70:3129

RUN apt update; DEBIAN_FRONTEND=noninteractive apt install -y tzdata openssh-server rsync vim git unrar p7zip-full && \
apt autoclean && apt autoremove

ENV TZ=Asia/Shanghai

RUN which pip && pip config set global.trusted-host mirrors.aliyun.com && \
    pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/ && \
    pip install --upgrade pip --no-cache-dir && \
    # pip install xformers==0.0.23.post1 --index-url https://download.pytorch.org/whl/cu121 --no-cache-dir && \
    pip install xformers==0.0.23.post1 --index-url https://mirror.sjtu.edu.cn/pytorch-wheels/cu121 --no-cache-dir && \
    pip install timm einops kornia --no-cache-dir && \
    pip install opencv-python-headless matplotlib scikit-learn --no-cache-dir && \
    pip install bitsandbytes --no-cache-dir && \
    pip install diffusers[torch] transformers accelerate datasets --no-cache-dir && \
    pip install dists-pytorch lpips torchmetrics piq pyiqa --no-cache-dir && \
    pip install tensorboard wandb --no-cache-dir && \
    pip install gdown lmdb --no-cache-dir && \
    pip install pandas scikit-image imageio scipy==1.11.1 --no-cache-dir && \
    pip install omegaconf --no-cache-dir && \
    pip install python-dotenv icecream --no-cache-dir && \
    pip install loralib peft --no-cache-dir && \
    pip install rawpy fairscale --no-cache-dir && \
    # pip install pandas yapf scikit-image future addict tomli lazy_loader PyWavelets imageio --no-cache-dir && \
    conda clean --all -y

# Add a user
RUN useradd -m lx -u 1021 -s /bin/bash && \
    echo "lx:122408" | chpasswd && \
    echo "lx ALL=(ALL) ALL" >> /etc/sudoers

USER lx
WORKDIR /home/lx