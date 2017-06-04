#!/bin/bash

# Script to generate an optimized client build of BrowserQuest
# 生成一个优化的客户端

BUILDDIR="../client-build"
PROJECTDIR="../client/js"
CURDIR=$(pwd)

#删除之前生成的build目录（如果有的话）
echo "Deleting previous build directory"
rm -rf $BUILDDIR

#切换到client/js目录下，运行node命令，然后切换回当前目录
echo "Building client with RequireJS"
cd $PROJECTDIR
node ../../bin/r.js -o build.js
cd $CURDIR

#从build目录中移除不必要的js文件
echo "Removing unnecessary js files from the build directory"
find $BUILDDIR/js -type f -not \( -name "game.js" -o -name "home.js" -o -name "log.js" -o -name "require-jquery.js" -o -name "modernizr.js" -o -name "css3-mediaqueries.js" -o -name "mapworker.js" -o -name "detect.js" -o -name "underscore.min.js" -o -name "text.js" \) -delete

#从build目录中移除sprites目录
echo "Removing sprites directory"
rm -rf $BUILDDIR/sprites

#从build目录中移除config目录
echo "Removing config directory"
rm -rf $BUILDDIR/config

#移动build目录中build日志build.txt到当前目录
echo "Moving build.txt to current dir"
mv $BUILDDIR/build.txt $CURDIR

echo "Build complete"