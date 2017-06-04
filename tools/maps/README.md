BrowserQuest map exporter
地图导出工具
=========================
***Disclaimer: due to popular demand we are open sourcing this tool, but please be aware that it was never meant to be publicly released. Therefore the code is messy/non-optimized and the exporting process can be very slow with large map files.***
免责声明：由于强烈的要求，我们开源此工具，但是请注意，这并不意味着可以公开发布。因为该代码凌乱/未经优化，并且对于大的map文件导出过程可能非常慢。

Editing the map
编辑map地图
---------------

Install the Tiled editor: http://www.mapeditor.org/
安装Tiled编辑器（瓦片地图）

Open the `tmx/map.tmx` file in Tiled and start editing.
用Tiled打开“tmx/map.tmx”文件并开始编辑。

**Note:** there currently is no documentation on how to edit BrowserQuest-specific objects/layers in Tiled. Please refer to `tmx/map.tmx` as an example if you want to create your own map.
注意：目前没有关于如何在Tiled中编辑该游戏中对象/层的文档。如果要创建一个你自己的map地图，请参考“tmx/map.tmx”示例。


Using the exporter
使用导出插件
------------------

This tool is to be used from the command line after the TMX file has been saved from the Tiled editor.
该工具需要在Tmx文件被保存之后，在命令行中运行

Note: This tool was written with OSX in mind. If you are using a different OS (eg. Windows), additional/different steps might be required.
注意：该工具实在osx系统下写的。如果你使用不同的操作系统（例如：windows）,则可能需要执行额外的/不同的步骤

**Prerequisites:** 最基本要求

- You need python and nodejs installed.
	安装python和nodejs
- Install pip: http://www.pip-installer.org/en/latest/installing.html
	安装pip
- Install lxml: `pip install lxml` (preferably within a virtual env)
	安装lxml:‘pip install lxml’ (最好是在一个虚拟环境下)
- Optional: Install Growl + growlnotify if you are on OSX.
	选项：如果你是OSX操作系统，安装Growl + growlnotify
**Usage:**
使用方法

1. `cd tools/maps/`
切换到“tools/maps”文件夹

2. `./export.py client` or `./export.py server`
运行“./export.py client” 或者 “./exprot.py server”

You must run both commands in order to export the client and server map files. There is no one-step export command for both map types yet.
你必须运行这两个命令，来导出客户端和服务器map地图文件。这里没有一步导出两种地图类型的命令。（客户端和服务器的map地图文件不一样么）

**Warning:** depending on the `.tmx` filesize, the exporting process can take up to several minutes.
警告：导出过程所需要的时间，与“.tmx”文件的大小有关。

Things to know
一些需要知道的事情
--------------

The client map export will create two almost identical files: `world_client.js` and `world_client.json`
These are both required because, depending on the browser, the game will load the map either by using a web worker (loading `world_client.js`), or via Ajax (loading `world_client.json`).
客户端map地图导出，将会创建两个几乎完全相同的文件：“world_client.js”和“world_client.json”
它们都是必须的，因为在浏览器下，游戏将通过web worker（加载“world_client.js”）或者通过Ajax(“加载“world_client.json””)

The client map file contains data about terrain tile layers, collision cells, doors, music areas, etc.
The server map file contains data about static entity spawning points, spawning areas, collision cells, etc.
客户端map地图文件包含了地形瓦片层，碰撞单元，门，区域音乐等等数据。
服务器map地图文件包含了静态实体出生点，出生区域，碰撞单元等等数据

Depending on what you want to change, it's therefore not always needed to export both maps. Also, each `world_server.json` file change requires a server restart.
并不是总是必须导出两者map地图文件，这要看你改了什么内容。此外，每次修改“world_server.json”文件都需要重启服务器。


**How the exporting process works:**
导出过程原理：

1. The Tiled map TMX file is converted to a temporary JSON file by `tmx2json.py`.
首先，瓦片地图TMX文件被转换为一个临时的JSON文件（通过tmx2json.py工具）
2. This file is be processed by `processmap.js` and returned as an object. This object will have different properties depending on whether we are exporting the client or the server map.
改文件由“processmap.js”处理并返回一个对象。该对象将会拥有不同的属性，具体取决于我们导出的是客户端map还是服务器map。
3. The processed map object is saved as the final world map JSON file(s) in the appropriate directories.
处理后的map对象将作为最终世界map地图JSON文件存放在相应的目录下。
4. The temporary file from step 1. is deleted.
步骤1的临时文件将被删除。


**Known bugs:**
已知bugs
 
    * There currently needs to be an empty layer at the bottom of the Tiled layer stack or else the first terrain layer will be missing.
      (ie. if you remove the "don't remove this layer" layer from the `map.tmx` file, the 'sand' tiles will be missing on the beach.)
    当前在瓦片地图的底部需要一个空的层，否则第一个地形层将会丢失。如果你从“map.tmx”文件中移除“不该移除的层”，那么“沙滩”上将会丢失“沙”图层。

Contributing / Ideas for improvement
建议和改进
------------------------------------

Here are a few ideas for anyone who might want to help make this tool better:
这里有一些建议给那些想要完善该工具的开发者：

- Remove hard-coded filenames from export.py (eg. `map.tmx`, `world_client.json`) in order to allow easier switching to different map files.
移除“export.py”中硬编码文件名（例如：“map.tmx”，“world_client.json”）,以便支持导出不同的map地图文件

- Fix known bugs (see section above)
修正已知bug（上面章节提到的）

- Write documentation on how to use the exporter on Windows.
编写如何在windows上使用该插件

- Write documentation about map editing in the Tiled editor (ie. editing BrowserQuest-specific properties of doors, chests, spawning areas, etc.)
编写关于Tiled编辑器使用文档（例如：如何编辑项目中门，箱子，出生点）

- Write documentation about the BrowserQuest map JSON format, both for client and server map types.
编写关于项目中map地图的JSON格式文档（客户端以及服务器map地图）

- Get rid of the `tmx2json.py` step which can currently take up to several minutes. Note: There is a JSON exporter built in Tiled since version 0.8.0 which could be useful. We didn't use it because our tool was written before the 0.8.0 release.
摆脱“tmx2json.py”比较耗时的步骤。注意：Tiled自0.8.0版本后增加了JSON导出功能，或许会有帮助。我们没有使用它，因为在编写该工具的时候，Titled还没有提供该功能。

- A complete rewrite of this tool using a custom Tiled plugin would surely be a better approach than the current one. Being able to export directly from Tiled would be much easier to use. Also, the export process is currently too slow.
使用自定义的Titled插件重写此工具肯定要比现在这种方式要好的多。直接从Titled编辑器中导出JSON文件更易于使用。另外，目前导出非常慢。

**Additional resources:**
额外资源

- Tiled editor wiki: https://github.com/bjorn/tiled/wiki
Tiled 编辑器wiki
- TMX map format documentation: https://github.com/bjorn/tiled/wiki/TMX-Map-Format
TMX地图格式文档

