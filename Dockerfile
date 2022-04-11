FROM bit:5000/luoxin_py3.8_pytorch1.10.1_cu11.3_devel_lightning_hydra_mmcv_wandb

RUN which pip && pip install --upgrade pip --no-cache-dir && \
                 pip install -i https://pypi.mirrors.ustc.edu.cn/simple/ timm --no-cache-dir && \
                 conda clean --all -y