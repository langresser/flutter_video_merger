# 基于Flutter的视频缓存合并工具

可以将视频缓存文件以及m3u8文件合并为完整的mp4文件。  
支持视频播放预览，支持简单的浏览器功能。  
由于文件访问权限的原因，暂时只有在Android平台发布。

## 开发环境搭建

* 安装Flutter SDK (其实就是一个github仓库，直接从github上clone也是可以的)  
  解压到任意非中文目录。
```
  https://flutter.dev/docs/development/tools/sdk/releases#windows
```
* 配置中国镜像源，避免无法下载插件或者下载过慢的问题。Windows下直接配置环境变量即可。
```
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```
* 将flutter/bin目录加入到环境变量的Path下，以便可以全局使用flutter命令。
* Android Studio和VSCode都有Flutter插件。分别安装Flutter插件和Dart插件即可。
* 安装国际化插件。vscode-flutter-i18n-json。提供多语言支持。
* 配置自动格式化，在vscode的setting.json中添加：
  ```
  "[dart]": {
    "editor.tabSize": 2,
    "editor.formatOnSave": true,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false
  }
  ```


## 目录结构

## 常用命令说明
### 环境检测和配置

* flutter config --no-analytics  
  禁用通过 Google Analytics 发送数据（以免国内网络连接失败问题）
* flutter docter  
  检测环境配置

### 创建项目

* flutter create xxx  
  创建项目，项目名需要小写+下划线格式

### 运行项目

* flutter run  
  运行项目到手机或者模拟器上
  
### 发布项目

## 技术选型

* 之前在做编辑器的技术选型的时候考虑过Flutter，不过因为编辑器是面向Win端的，而Flutter的Desktop平台并不成熟，有很多问题（比如输入法不兼容）。生态也不健全（很多有价值的库都没有或者完成度很低，比如pdf显示，excel加载等等）。所以编辑器的技术选型我们并没有选择Flutter。
* 在做移动端App的技术选型的时候，Flutter就成了第一优先的选择。它有这么几个优点：
* 1、跨平台（Android和iOS平台都比较成熟），开发成本低。大多数App的开发还是UI的开发量居多，这里能够跨平台的话，开发量会大幅降低。否则就要Android和iOS各有一套代码，各一组人进行开发。
* 2、性能高。因为Dart是编译型语言，且所有控件都是自绘，所以不存在大量的和Native的交互。Flutter的目标是支持稳定60帧的渲染。
* 3、兼容性好。可以把Flutter当成一个渲染引擎，由于所有元素都是自绘的，所以可以像素级控制显示。由于并没有依赖于Native控件，所以也不会出现不同平台代码一致但是表现不一致的情况。
* 4、开发效率高。Flutter可以实现亚秒级的有状态的热重载，修改了界面代码可以实时看到修改后的效果。

#### React Native的比较
* 前端技术和库的更新日新月异，这个某种程度上说是好事，体现了生态繁荣。但是对于追求稳定的项目来说，npm的大量依存关系会让维护变得困难和不确定。
* React Native也是跨平台App开发的选择之一。不过React Native的缺陷有两个，一个是兼容性问题，同样的代码可能Android是好的，但是iOS就不行了，或者不同平台显示不一致。另外一个是性能，因为RN还是使用Javascript开发界面，所以很多时候需要JS和Native进行交互，而交互都是通过json封装消息进行通信，这个会大大影响性能，尤其是长列表滑动的时候。

## 经验心得

### Flutter

* 总体思想上Flutter和React很像。Widget是UI，State是状态。通过setState改变状态，影响UI的显示。
* 万事万物皆是Widget。比如控件、布局。
* StatefulWidget和StatelessWidget。

### Dart

* Dart中行尾分号不能省略。
* Dart不是脚本语言。可以定义全局变量，但是不能直接执行全局函数。
* import 'xxx/xxx.dart' 可以导入本项目的文件。路径是相对于本文件的路径。
* import 'package:pkg_name/xxx/xxx.dart' 可以导入其他模块的文件。package需要在pubspec.yaml中声明。

### 状态管理

* 跟React一样，一旦应用复杂起来，状态管理就必不可少了。
* 简单理解，状态管理的主要目的就是数据改变的时候，通知到对应的Widget，让其调用setState更新状态，进而刷新UI。
* 通过setState可以控制UI的刷新。但是如果子孙界面或者没有父子关系的界面里面某个全局状态改变，需要通知对应的其他界面刷新。  
  这种情况如果简单通过setState或者回调来设置就会大大降低程序的可维护性。全局的状态管理解决的就是这个问题。
* 最简单的形式是使用信号插槽的观察者模式。在父界面里面注册事件，在子界面修改状态的时候触发事件。

### Flutter国际化/多语言支持

* 安装插件vscode-flutter-i18n-json
* Flutter I18n Json: Initialize  初始化
* Flutter I18n Json: Add locale  添加一个语言
* Flutter I18n Json: Update  更新语言
* I18n.of(context).hello