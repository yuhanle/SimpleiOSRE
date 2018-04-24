# 记录一次简单的逆向

![image](https://user-images.githubusercontent.com/10498756/39162859-2ed8aa54-47aa-11e8-9afb-1f1b989819f4.png)

由于爱奇艺会员到期，于是产生逆向APP 的想法，尚未找到解决办法。

## 安装MonkeyDev

原有iOSOpenDev的升级，非越狱插件开发集成神器！

- 可以使用Xcode开发CaptainHook Tweak、Logos Tweak 和 Command-line Tool，在越狱机器开发插件，这是原来iOSOpenDev功能的迁移和改进。
- 只需拖入一个砸壳应用，自动集成class-dump、restore-symbol、Reveal、Cycript和注入的动态库并重签名安装到非越狱机器。
- 支持调试自己编写的动态库和第三方App
- 支持通过CocoaPods第三方应用集成SDK以及非越狱插件，简单来说就是通过CocoaPods搭建了一个非越狱插件商店。

安装教程可参考：[安装](https://github.com/AloneMonkey/MonkeyDev/wiki)

## 准备砸壳安装包

一般从某助手上下载的越狱版本，就是已经砸壳的，当然也可以自行通过 [dumpdecrypted](https://github.com/stefanesser/dumpdecrypted) 工具实现。

## class-dump

### 简介

**class-dump** 是一个工具，它利用了 Objective-C 语言的运行时特性，将存储在 Mach-O 文件中的头文件信息提取出来，并生成对应的 .h 文件。

### 安装 class-dump

到 [class-dump 官网](http://stevenygard.com/projects/class-dump/) 进行下载，目前最新的版本为 3.5。

在个人目录下新建一个 `bin` 目录，并将其添加到 PATH 路径中，然后将下载后的 class-dump-3.5.dmg 里面的 class-dump 可执行文件复制到该 `bin` 目录下，赋予可执行权限：

```
$ mkdir ~/bin
$ vim ~/.bash_profile
# 编辑 ~/.bash_profile 文件，并添加如下一行
export PATH=$HOME/bin/:$PATH

# 将 class-dump 拷贝到 bin 目录后执行下面命令
$ chmod +x ~/bin/class-dump
```

### 使用 class-dump

到最后一步，以爱奇艺为例，使用 class-dump 来将微信的头文件导出：

```
$ class-dump -H iQiYiPhoneVideo.app -o Payload/
```

这样，所有的头文件就都被导出到了 `.Payload/` 目录下了。

![image](https://user-images.githubusercontent.com/10498756/39162346-a7f6fcb8-47a7-11e8-92d1-8a0e0f910036.png)


## 头文件分析

可以借助 FLEX 工具来查看APP 的层级和数据以及接口声明，可以快速定位我们要修改的位置

### 安装 FLEX

[FLEX](https://github.com/Flipboard/FLEX) 官方仓库，通过Cocoapods 安装依赖即可。

```ruby
source 'https://github.com/AloneMonkey/MonkeyDevSpecs.git'

platform :ios, '9.0'

target 'antrees' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for antrees

end

target 'antreesDylib' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  
  # 注意是安装到动态库 而不是APP
  # Pods for antreesDylib
  pod 'FLEX'
  
end
```

紧接着在程序启动以后，添加FLEX 的显示

```objective-c
CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [[FLEXManager sharedManager] showExplorer];
#ifndef __OPTIMIZE__
        CYListenServer(6666);
        CycriptManager* manager = [CycriptManager sharedInstance];
        [manager startDownloadCycript:NO];
#endif
        
    }];
}
```

### 效果演示

我们可以通过这个FLipboard 来实现操作，具体效果如下

|                             主页                             |                             菜单                             |                             视图                             |                             选择                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![image](https://user-images.githubusercontent.com/10498756/39162331-94ee0fee-47a7-11e8-8a97-aec72ffba1b7.png) | ![image](https://user-images.githubusercontent.com/10498756/39162363-c0e9febe-47a7-11e8-8569-21ddef9f1f9c.png) |  ![image](https://user-images.githubusercontent.com/10498756/39162378-d06b42b2-47a7-11e8-9687-a2e909151ea5.png) | ![image](https://user-images.githubusercontent.com/10498756/39162397-e1bfddca-47a7-11e8-8088-ac88bc83cf6b.png) |

### 小实战

比如，我们想去掉Tab 栏那个可恶的泡泡（截图部分已处理），我是非常讨厌那个功能，感觉很鸡肋，体验极差。

此时我们可以通过`select` 功能点击底部菜单栏，然后进入到视图查看层级关系，最终找到对应的实例，如下图所示

|        |                             主页                             |                            视图1                             |                            视图2                             |
| :----: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| 处理前 | ![image](https://user-images.githubusercontent.com/10498756/39162415-fa9508ca-47a7-11e8-9c25-55e8a1ccde35.png) | ![image](https://user-images.githubusercontent.com/10498756/39162445-178f1100-47a8-11e8-9d41-1b8c6bf3286a.png) | ![image](https://user-images.githubusercontent.com/10498756/39162508-7baa0f0a-47a8-11e8-92a6-1c71f6e0b48a.png) |
| 处理后 | ![image](https://user-images.githubusercontent.com/10498756/39162331-94ee0fee-47a7-11e8-8a97-aec72ffba1b7.png)  |  ![image](https://user-images.githubusercontent.com/10498756/39162490-531e8548-47a8-11e8-91aa-e3f0d9a3034f.png)  |  ![image](https://user-images.githubusercontent.com/10498756/39162508-7baa0f0a-47a8-11e8-92a6-1c71f6e0b48a.png)  |

代码实例如下

```objective-c
CHDeclareClass(TabbarView)

CHOptimizedMethod0(self, NSArray*, TabbarView, tabbarImageArray){
    //get origin value
    NSMutableArray* originArray = CHSuper(0, TabbarView, tabbarImageArray).mutableCopy;
    
    [originArray removeLastObject];
    
    //change the value
    return originArray.copy;
}

CHOptimizedMethod0(self, NSArray*, TabbarView, tabbarTitleArray){
    //get origin value
    NSMutableArray* originArray = CHSuper(0, TabbarView, tabbarTitleArray).mutableCopy;
    
    [originArray removeLastObject];
    
    //change the value
    return originArray.copy;
}

CHConstructor {
    CHLoadLateClass(TabbarView);
    CHHook0(TabbarView, tabbarImageArray);
    CHHook0(TabbarView, tabbarTitleArray);
}
```

## 总结

![image](https://user-images.githubusercontent.com/10498756/39162834-08506cf0-47aa-11e8-9712-0c86beddf7b3.png)

通过[MonkeyDev](https://github.com/AloneMonkey/MonkeyDev) 大大降低了逆向开发的门槛，使得逆向变得更加有趣和更具规范性。通过逆向，可以实现很多意想不到的功能，给你不断的惊喜！

下面是本次实践的代码示例，会员和去广告相关功能暂未实现，正在寻求其他思路~

[SimpleiOSRE](https://github.com/yuhanle/SimpleiOSRE)