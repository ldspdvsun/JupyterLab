# 源镜像
FROM ubuntu:20.04

# 使用root用户
USER root

# 建立挂载路径以及apt换源
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir /opt/notebooks \
&& sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
&& apt update -y \
&& apt upgrade -y \
&& apt-get update -y \
&& apt-get upgrade -y \
&& apt install -y npm vim curl wget python3 python3-pip sudo gdb git build-essential -y \
&& alias python=python3 \
&& curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
&& sudo apt-get install -y nodejs


# 安装jupyterlab3及插件，并生成配置文件
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ "jupyterlab" \
&& jupyter lab --generate-config \
&& chmod -R 777 /root/.jupyter/jupyter_lab_config.py \
&& chmod -R 777 /opt/notebooks \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ jupyterlab-language-pack-zh-CN \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ jupyterlab-lsp==3.2.0 jupyter-lsp==1.1.1 \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ jupyterlab_code_formatter \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ python-language-server[all] \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ black isort \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ ipydrawio

# 安装常用库
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ pandas \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ numpy \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ plotly \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ matplotlib \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ tqdm \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ scikit-learn \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ ipywidgets \
&& pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ ipympl

# 设置挂载路径
VOLUME /opt/notebooks

# 设置映射端口
EXPOSE 8888

# 设置容器启动时运行的命令
CMD jupyter lab --notebook-dir=/opt/notebooks --ip='*' --port=8888 --allow-root --no-browser
