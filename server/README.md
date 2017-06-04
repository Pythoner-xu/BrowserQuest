BrowserQuest server documentation
服务端文档
=================================

The game server currently runs on nodejs v0.4.7 (but should run fine on the latest stable as well) and requires the latest versions of the following npm libraries:
游戏服务器需要nodejs v0.4.7版本（在最新版本上运行也可以），需要下面几个npm最新库

- underscore
- log
- bison
- websocket
- websocket-server
- sanitizer
- memcache (only if you want metrics)

All of them can be installed via `npm install -d` (this will install a local copy of all the dependencies in the node_modules directory)
上面的库可以通过“npm install -d”来安装，这将在node_modules目录下安装一所有依赖的拷贝

Configuration
配置
-------------

The server settings (number of worlds, number of players per world, etc.) can be configured.
服务器设置（世界服务器数量，每个世界服务器的玩家数）可以被配置
Copy `config_local.json-dist` to a new `config_local.json` file, then edit it. The server will override default settings with this file.
拷贝“config_local.json-dist”到一个新文件“config_local.json”中，然后编辑它。服务器将会使用改文件覆盖默认设置。

Deployment
部署
----------

In order to deploy the server, simply copy the `server` and `shared` directories to the staging/production server.
为了部署服务器，只需要复制“server”和“shared”目录到staging/production服务器

Then run `node server/js/main.js` in order to start the server.
运行“node server/js/main.js”来启动服务器

Note: the `shared` directory is the only one in the project which is a server dependency.
注意：“shared”目录是项目中唯一一个存放服务器依赖的目录

Monitoring
监视
----------

The server has a status URL which can be used as a health check or simply as a way to monitor player population.
服务器拥有一个状态查询URL，可以用作服务器服务状态检查或者监视玩家人数。

Send a GET request to: `http://[host]:[port]/status`
发送get请求

It will return a JSON array containing the number of players in all instanced worlds on this game server.
它将会返回一个json数组，包含了玩家数量（游戏服务器中所有的世界服务器实例中）
