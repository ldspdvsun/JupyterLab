# Jupyter插件

## JupyterLab代码自动提示
1. 安装jupyter-lsp
```sh
pip install jupyter-lsp
```
2. 安装python-lsp-server
```sh
pip install python-lsp-server[all]
```
3. 启动jupyter lab，在插件中搜索lsp，点击@krassowski/jupyterlab-lsp下的install安装，安装完之后重新启动jupyterlab

4. 启动后依次点击Settings-->Advanced Settings Editor

5. 选择Code Completion，在右侧输入如下代码，并保存，即可开启Hinterland mode
```sh
{
"continuousHinting": true
}
```

>https://blog.csdn.net/aboshu/article/details/121864655

## JupyterNoteBook自动提示
1. 安装代码自动补全提示插件nbextensions
```sh
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user --skip-running-check
```
2. 安装完后重新启动JupyterNotebook，发现多了一个插件nbextensions，勾选Hinterland即可启用代码自动补全

>https://blog.csdn.net/qq_37781464/article/details/123257076

## 执行时间
```sh
pip install jupyter_scheduler
```

## 图片交互
```sh
conda install -y nodejs
pip install ipympl
pip install --upgrade jupyterlab
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install jupyter-matplotlib
jupyter nbextension enable --py widgetsnbextension

# 然后在代码块的前面加上%matplotlib widget
```

