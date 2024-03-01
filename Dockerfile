FROM registry.cn-hangzhou.aliyuncs.com/yry/pytorch-2.2.0-cuda12.1-cudnn8-devel-xformers:v1
ENV NV_CUDA_COMPAT_PACKAGE=
ENV NVIDIA_REQUIRE_CUDA=
ENV NV_CUDA_CUDART_VERSION=
ENV CUDA_VERSION=
RUN rm /usr/local/cuda-11.8/compat -rfv
RUN apt update; DEBIAN_FRONTEND=noninteractive apt install -y tzdata openssh-server rsync vim git unrar && \
apt autoclean && apt autoremove

ENV TZ=Asia/Shanghai

RUN which pip && pip config set global.trusted-host mirrors.aliyun.com && \
    pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/ && \
    pip install --upgrade pip --no-cache-dir && \
    pip install timm einops basicsr --no-cache-dir && \
    pip install opencv-python-headless matplotlib scikit-learn --no-cache-dir && \
    pip install bitsandbytes --no-cache-dir && \
    pip install diffusers[torch]==0.23.3 transformers accelerate datasets --no-cache-dir && \
    pip install dists-pytorch lpips torchmetrics piq pyiqa --no-cache-dir && \
    pip install tensorboard wandb --no-cache-dir && \
    pip install gdown lmdb --no-cache-dir && \
    pip install pandas scikit-image imageio --no-cache-dir && \
    pip install omegaconf --no-cache-dir && \
    pip install python-dotenv icecream --no-cache-dir && \
    # pip install pandas yapf scikit-image future addict tomli lazy_loader PyWavelets imageio --no-cache-dir && \
    conda clean --all -y

# Add a user
RUN useradd -m yry -u 1647 -s /bin/bash && \
    echo "yry:122408" | chpasswd && \
    echo "yry ALL=(ALL) ALL" >> /etc/sudoers

USER yry
WORKDIR /home/yry