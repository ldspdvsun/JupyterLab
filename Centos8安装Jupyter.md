# Centos安装jupyterlab

```sh
https://blog.51cto.com/u_15749390/5648449
如何后台运行
https://blog.csdn.net/stevenac/article/details/109278188
[root@Centos8 ~]# nohup jupyter notebook --allow-root > jupyter.log 2>&1 &

How to use centos install jupyter lab
>https://zhuanlan.zhihu.com/p/545212798
```

## 安装Miniconda

### 下载Miniconda
```sh
[root@Centos8 opt]# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
```

### 配置minicoda
```sh
执行下面的代码，进行安装
[root@Centos8 opt]# ll
总用量 752648
-rw-r--r--  1 root  root  667976437 11月 20 2018 Anaconda3-5.3.1-Linux-x86_64.sh
drwx--x--x  4 root  root         28 9月   2 10:39 containerd
-rw-r--r--  1 root  root      70822 8月  22 09:04 index.html
drwxrwxrwx  8 root  root        160 9月  22 17:38 lx
-rw-r--r--  1 root  root   76607678 5月  17 04:02 Miniconda3-py39_4.12.0-Linux-x86_64.sh
-rw-r--r--  1 root  root      14100 1月  14 2022 mysql80-community-release-el8-3.noarch.rpm
-rw-r--r--  1 root  root      14100 1月  14 2022 mysql80-community-release-el8-3.noarch.rpm.1
drwxr-xr-x 17 admin admin      4096 9月  22 14:53 Python-3.10.7
-rw-r--r--  1 root  root   26006589 9月  22 09:50 Python-3.10.7.tgz
drwxr-xr-x  2 root  root         22 8月  19 17:55 PythonFile
[root@Centos8 opt]# bash Miniconda3-py39_4.12.0-Linux-x86_64.sh 


安装过程中，有需要输入enter的地方，直接输入即可
Please, press ENTER to continue
>>> 
======================================
End User License Agreement - Miniconda
======================================
...
Do you accept the license terms? [yes|no]
[no] >>> yes
..
Miniconda3 will now be installed into this location:
/root/miniconda3

  - Press ENTER to confirm the location
  - Press CTRL-C to abort the installation
  - Or specify a different location below

[/root/miniconda3] >>> 
PREFIX=/root/miniconda3
Unpacking payload ...
Collecting package metadata (current_repodata.json): done                                           
Solving environment: done
...
Do you wish the installer to initialize Miniconda3
by running conda init? [yes|no]
[no] >>> yes


1. 输入yes确认接受许可协议 Do you accept the license terms? [yes|no] [no] >>> yes
确认Anaconda的安装位置, 可改可不改
安装完成后，出现询问是否在用户的.bashrc文件中初始化Anaconda3的相关内容。
Do you wish the installer to initialize Anaconda3 by running conda init? [yes|no] [no] >>> yes
最后执行下：source ~/.bashrc，之后就可以正常使用了。
[root@Centos8 opt]# source ~/.bashrc
```

## 使用Conda安装Jupyter lab

```sh
# 首先使用conda执行代码jupyterlab的安装代码
(JupyterNotebook) [anaconda@centos7 ~]$ conda install -c conda-forge jupyterlab
# 中间遇到需要确认的地方按提示输入即可。安装完成后，开始配置Jupyter Lab
```

## 如何配置jupyter lab

```sh
# 首先生成一个配置文件,每次生成的配置文件位置不一样，根据实际修改
(JupyterNotebook) [anaconda@centos7 ~]$ jupyter lab --generate-config
# 收到下面的提示，表示jupyter生成了一个配置文件在下面的路径，接下来我们只需要打开该文件进行配置即可
# Writing default config to: /root/.jupyter/jupyter_lab_config.py

# 追加如下配置文件
# 将ip设置为*，允许任何IP访问
c.ServerApp.ip = '*'
# 密码root
c.ServerApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8$fh/0pPku1hS7e/BQbf7lag$E2R0I2r6bePzFzswXaoW8A' 
# 禁止用host的浏览器打开jupyter
c.ServerApp.open_browser = False 
# 监听端口设置为8888或其他
c.ServerApp.port = 8888
# 允许远程访问 
c.ServerApp.allow_remote_access = True
# 文件存储位置，如果没有，可以使用mkdir命令创建一个
c.ServerApp.root_dir = '/home/anaconda/JupyterNotebook/'
# 允许root用户执行
c.ServerApp.allow_root = True
```

## 启动 

* 配置完成后，启动jupyter lab，并进行远程访问了！可以执行下面的命令，让jupyter在后台自动运行
```sh
# 输出日志
nohup jupyter lab --allow-root > /home/jupyter_lab/jupyter.log 2>&1 & 
# 不输出日志
nohup jupyter lab --allow-root & 
```

* 访问http://你的公网IP:8888



# Centos安装jupyter notebook（anaconda执行）

## 下载
```sh
下载
pip install notebook
```

## 生成配置文件
```sh
生成配置文件
jupyter notebook --generate-config --allow-root
```

## 编辑生成后的配置文件
```sh
vim /vim /home/anaconda/.jupyter/jupyter_notebook_config.py

# 追加配置文件
# 对外提供访问的ip
c.NotebookApp.ip = '*'
# 对外提供访问的端口
c.NotebookApp.port = 8888
# 启动不打开浏览器
c.NotebookApp.open_browser = False
# 秘钥（root）
c.NotebookApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8$fh/0pPku1hS7e/BQbf7lag$E2R0I2r6bePzFzswXaoW8A'
# 设置jupyter启动后默认文件夹
c.NotebookApp.notebook_dir = '/home/anaconda/JupyterNotebook/'
# 允许root用户执行
c.NotebookApp.allow_root = True
```

## 后台启动
```sh
# 生成日志
nohup jupyter notebook --ip 0.0.0.0 --no-browser --allow-root > /home/anaconda/JupyterNotebook/log/jupyter-notebook.log 2>&1 &
# 不生成日志
nohup jupyter notebook --ip 0.0.0.0 --no-browser --allow-root &
```

# Docker安装Jupyter

> link:https://www.zhihu.com/search?type=content&q=docker%E9%83%A8%E7%BD%B2jupyter%20notebook

## docker版本
[root@Centos8 jupyter_notebook]# docker version
    Client: Docker Engine - Community
     Version:           19.03.1
     API version:       1.40
     Go version:        go1.12.5
     Git commit:        74b1e89
     Built:             Thu Jul 25 21:21:07 2019
     OS/Arch:           linux/amd64
     Experimental:      false


    Server: Docker Engine - Community
     Engine:
      Version:          19.03.1
      API version:      1.40 (minimum version 1.12)
      Go version:       go1.12.5
      Git commit:       74b1e89
      Built:            Thu Jul 25 21:19:36 2019
      OS/Arch:          linux/amd64
      Experimental:     false
     containerd:
      Version:          1.2.6
      GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
     runc:
      Version:          1.0.0-rc8
      GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
     docker-init:
      Version:          0.18.0
      GitCommit:        fec3683


## 新建文件存放目录, 同时更改文件权限 -> 否则会因为权限问题网页访问不了
[root@Centos8 jupyter_notebook]# mkdir /root/jupyter_notebook
[root@Centos8 jupyter_notebook]# chmod 777 /root/jupyter_notebook


## 安装或运行容器，使用镜像 jupyter/minimal-notebook 作为演示
## root 权限运行
```sh
[root@Centos8 jupyter_notebook]# docker run \
  -d --name notebook \
  --hostname jupyter \
  -p 10001:8888 \
  -e JUPYTER_ENABLE_LAB=no \
  -e RESTARTABLE=yes \
  -e GRANT_SUDO=yes \
  --user root \
  --restart unless-stopped \
  -v /root/jupyter_notebook:/home/jovyan \
  jupyter/minimal-notebook \
  start-notebook.sh --NotebookApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$fh/0pPku1hS7e/BQbf7lag$E2R0I2r6bePzFzswXaoW8A'
```
>备注：docker jupyter环境变量设置见网页 -> https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html

## 运行情况

```sh
[root@Centos8 jupyter_notebook]# docker ps | grep notebook
994ffce371c2        jupyter/minimal-notebook       "tini -g -- start-no…"   20 seconds ago      Up 19 seconds               0.0.0.0:10001->8888/tcp                             notebook
```

* 本地浏览器网页访问，192.168.100.120 是我局域网内安装的机器IP
http://192.168.100.120:10001/tree
* 密码：root


## 更改jupyter lab密码

### 方法一
#### 1.jupyter 生成密码

```py
jupyter notebook password

Enter password:

Verify password:

会生成 .jupyter/jupyter_notebook_config.json文件，里面存的是加密过后的密码。
```

#### 2.使用vim打开上面的文件：

```sh
vim  .jupyter/jupyter_notebook_config.json
```

#### 3.把里面的一串代码复制出来，比如：

```sh
"argon2:$argon2id$v=19$m=10240,t=10,p=8$yqX7AhTpZL3LTVSyGCnoYQ$3FGc8c3gVpQT609QpVZxiA"
```

#### 4.修改config文件

```sh
jupyter notebook --generate-config

vim  .jupyter/jupyter_notebook_config.json
```

#### 5.在 jupyter_notebook_config.py 中找到c.NotebookApp.password 取消注释并修改如下：

```sh
c.NotebookApp.password = u'sha:$argon2id......(换成你的秘钥)' 
就是把生成的密码json文件里面的一串密码放这里
```

### 方法二
#### 1.Python生成密码

```sh
在终端输入python：

python

In [1]: from notebook.auth import passwd

In [2]: passwd()

Enter password:

Verify password:

Out[2]:'argon2:$argon2id$v=19$m=10240,t=10,p=8$yqX7AhTpZL3LTVSyGCnoYQ$3FGc8c3gVpQT609QpVZxiA'
```

#### 2.执行上面方法一的4和5步。

> 链接：https://www.jianshu.com/p/17dca6584dfe




# Jupyter设置开机自动启动

>https://www.cnblogs.com/Tsingwaa/articles/14681660.html

```sh
sudo vim /etc/systemd/system/jupyter.service
```

* lighthouse为我的用户名，注意修改
* jupyter-lab路径，可通过 which jupyter-lab查看
* WorkingDirectory 可自行设定

```sh
[Unit]
Description=Jupyterlab
After=network.target
[Service]
Type=simple
ExecStart=/home/lighthouse/.conda/envs/Jupyter/bin/jupyter-lab --config=/home/lighthouse/.jupyter/jupyter_lab_config.py --no-browser
User=lighthouse
Group=lighthouse
WorkingDirectory=/usr/local/lighthouse/softwares/cloudreve/uploads/1/JupyterNotebook/
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
```


```sh
# 开机自启动
sudo systemctl enable jupyter 
# 启动
sudo systemctl start jupyter
# 服务状态
sudo systemctl status jupyter
```

```sh
root@VM-24-11-centos cloudreve]# systemctl enable jupyter
[root@VM-24-11-centos cloudreve]# systemctl start jupyter
[root@VM-24-11-centos cloudreve]# systemctl status jupyter
● jupyter.service - Jupyterlab
   Loaded: loaded (/etc/systemd/system/jupyter.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2022-11-28 13:39:27 CST; 16min ago
 Main PID: 198867 (jupyter-lab)
    Tasks: 1 (limit: 23995)
   Memory: 97.1M
   CGroup: /system.slice/jupyter.service
           └─198867 /home/lighthouse/.conda/envs/Jupyter/bin/python3.11 /home/lighthouse/.conda/envs/Jupyter/bin/jupyter-lab --config=/home/lighthouse/.jupyter/jupyter_lab_config.py --no-browser

Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.449 ServerApp] [Jupytext Server Extension] Deriving a JupytextContentsManager from LargeFileManager
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.450 ServerApp] jupytext | extension was successfully loaded.
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.453 ServerApp] nbclassic | extension was successfully loaded.
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.453 ServerApp] The port 9090 is already in use, trying another port.
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.454 ServerApp] Serving notebooks from local directory: /usr/local/lighthouse/softwares/cloudreve/uploads/1/JupyterNotebook
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.454 ServerApp] Jupyter Server 1.23.3 is running at:
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.454 ServerApp] http://localhost:9091/lab
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.454 ServerApp]  or http://127.0.0.1:9091/lab
Nov 28 13:39:29 VM-24-11-centos jupyter-lab[198867]: [I 2022-11-28 13:39:29.454 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
```
## 修改配置，重启服务

```sh
[root@VM-24-11-centos cloudreve]# vim /etc/systemd/system/jupyter.service
[root@VM-24-11-centos cloudreve]# systemctl restart jupyter
Warning: The unit file, source configuration file or drop-ins of jupyter.service changed on disk. Run 'systemctl daemon-reload' to reload units.
[root@VM-24-11-centos cloudreve]# systemctl daemon-reload
[root@VM-24-11-centos cloudreve]# 
[root@VM-24-11-centos cloudreve]# systemctl restart jupyter
[root@VM-24-11-centos cloudreve]# systemctl status jupyter
● jupyter.service - Jupyterlab
   Loaded: loaded (/etc/systemd/system/jupyter.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2022-11-28 14:03:55 CST; 7s ago
 Main PID: 204435 (jupyter-lab)
    Tasks: 1 (limit: 23995)
   Memory: 70.3M
   CGroup: /system.slice/jupyter.service
           └─204435 /home/lighthouse/.conda/envs/Jupyter/bin/python3.11 /home/lighthouse/.conda/envs/Jupyter/bin/jupyter-lab --config=/home/lighthouse/.jupyter/jupyter_lab_config.py --no-browser

Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.052 LabApp] JupyterLab application directory is /home/lighthouse/.conda/envs/Jupyter/share/jupyter/lab
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.055 ServerApp] jupyterlab | extension was successfully loaded.
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.055 ServerApp] [Jupytext Server Extension] Deriving a JupytextContentsManager from LargeFileManager
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.056 ServerApp] jupytext | extension was successfully loaded.
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.059 ServerApp] nbclassic | extension was successfully loaded.
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.060 ServerApp] Serving notebooks from local directory: /usr/local/lighthouse/softwares/cloudreve/uploads/1/JupyterNotebook
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.060 ServerApp] Jupyter Server 1.23.3 is running at:
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.060 ServerApp] http://localhost:9090/lab
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.060 ServerApp]  or http://127.0.0.1:9090/lab
Nov 28 14:03:56 VM-24-11-centos jupyter-lab[204435]: [I 2022-11-28 14:03:56.060 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[root@VM-24-11-centos cloudreve]# 
```

# 密码配置

```py
from notebook.auth import passwd
passwd()
```