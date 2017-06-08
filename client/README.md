BrowserQuest client documentation `客户端文档`
=================================

The client directory should never be directly deployed to staging/production. Deployment steps:
客户端目录不能被直接部署到生产环境，部署步骤：

1) Configure the websocket host/port:
配置websocket主机IP和端口

In the client/config/ directory, copy config_build.json-dist to a new config_build.json file.
Edit the contents of this file to change host/port settings.
在client/config/目录下，复制config_build.json-dist到一个新的config_build.json文件中。
并编辑这个文件的内容（host/port）

2) Run the following commands from the project root:
在项目根目录下运行下面的命令

(Note: nodejs is required to run the build script)
需要安装nodejs

* cd bin
* chmod +x build.sh
* ./build.sh

This will use the RequireJS optimizer tool to create a client-build/ directory containing a production-ready version of BrowserQuest.
将会调用RequireJS优化工具，创建一个client-build/目录，里面包含了一个可部署到生产环境的版本

A build log file will also be created at bin/build.txt.
还会在bin目录下生成build日志文件build.txt

The client-build directory can be renamed and deployed anywhere. It has no dependencies to any other file/folder in the repository.
该client-build目录可以重命名并部署在任何地方。它不依赖于任何代码仓库中其他文件/文件夹