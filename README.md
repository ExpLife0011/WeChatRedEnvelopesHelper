## WeChatRedEnvelopesHelper
iOS版微信抢红包插件 tweak源文件

## Futures
- [x] 支持微信在后台和锁屏状态下自动抢红包
- [x] 支持自定义延迟抢红包
- [x] 完全模拟用户点击红包，可有效防止微信发现作弊封号
- [x] 兼容最新版本微信，跟随微信更新及时更新迭代
- [x] 支持修改微信运动步数

## ScreenShots
- 微信在前台情况演示
![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/foregroundstatus.gif)

- 微信在后台情况演示
![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/backgroundstatus.gif)

- 手机锁屏情况演示
![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/lockscreenstatus.gif)

- 助手配置截图
<img src="https://github.com/kevll/WeChatRedEnvelopesHelper/raw/master/screenshots/step.png" style="zoom:20%;">

## How to install

- 越狱手机
    1.  前往cydia市场，搜索 "WeChatRedEnvelopesHelper" 进行安装 （推荐）
    2.  clone到本地，手动 make package install
    
- 非越狱手机
    1. 下载已打包好的ipa，使用impactor工具自行安装 （推荐）
    ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/stepone.gif)
    ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/steptwo.gif)
    ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/stepthree.gif)
    2. 从XX助手上面下载越狱版ipa --> 解压缩 --> 拷贝WeChatRedEnvelopesHelper.dylib和libsubstate.dylib到Frameworks目录 --> 向WeChat二进制文件注入dylib -> 更改 WeChatRedEnvelopesHelper.dylib 依赖 --> 打包重签名安装
    
## Hope

如果觉得有用，欢迎star
如果使用发现问题，欢迎issue
