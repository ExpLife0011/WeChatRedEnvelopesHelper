## WeChatRedEnvelopesHelper
iOS版微信抢红包插件 tweak源文件

## 关于新版本功能征集
本人由于前一段时间工作比较忙，所以一直没能及时更新插件，很抱歉！
近期会更新V2.2版本，将会增加一些新功能。欢迎大家提出一些实用的功能；
可以直接提issue，或者给我发邮件；
如果功能合理，我会考虑在新版本增加。

## V2.1.0版本更新内容
- 防撤回功能增加友好提示
- 新增阻止聊天时发送正在输入，随时隐藏自己的输入状态
- 新增自动领取红包累积统计，红包提醒增加红包金额
- 修复了相关Bug

## V2.0.1版本更新内容
- 增加好友消息防撤回
- 增加虚拟定位功能
- 增加领取红包后自动回复
- 增加微信运动步数范围随机和固定步数两种模式
- 增加是否自动领取自己发的红包

## Futures
- [x] 支持微信在后台和锁屏状态下自动抢红包
- [x] 支持自定义延迟抢红包
- [x] 支持群聊过滤功能
- [x] 完全模拟用户点击红包，可有效防止微信发现作弊封号
- [x] 兼容最新版本微信，跟随微信更新及时更新迭代
- [x] 支持修改微信运动步数
- [x] 支持虚拟定位
- [x] 支持好友消息防撤回
- [x] 支持阻止发送正在输入，随时隐藏输入状态

## ScreenShots
- 微信在前台情况演示</br>
  ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/foregroundstatus.gif)

- 微信在后台情况演示</br>
  ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/backgroundstatus.gif)

- 手机锁屏情况演示</br>
  ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/lockscreenstatus.gif)

- 高清演示视频</br>
  [优酷链接](http://v.youku.com/v_show/id_XMzI3NDI3MzE2NA==.html)</br>
  [youtube链接](https://www.youtube.com/watch?v=cZH16LGaOko)

## How to install

- 越狱手机
    1.  前往cydia市场，搜索 "WeChatRedEnvelopesHelper" 进行安装 （推荐）
    2.  clone到本地，手动 make package install

- 非越狱手机
    1. 下载已打包好的ipa，使用[impactor](http://www.cydiaimpactor.com/)工具自行安装 （推荐）</br>
        ipa百度网盘[下载链接](https://pan.baidu.com/s/1dnFW9C)  密码: 5dxs </br>
      ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/stepone.gif)</br>
      ![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/steptwo.gif)</br>
    2. 从XX助手上面下载越狱版ipa --> 解压缩 --> 拷贝WeChatRedEnvelopesHelper.dylib和libsubstate.dylib到Frameworks目录 --> 向WeChat二进制文件注入dylib -> 更改 WeChatRedEnvelopesHelper.dylib 依赖 --> 打包重签名安装

## How to Setting
前往微信 “设置” —-> “微信助手设置” —-> 开启助手并保存</br>
![image](https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/stepthree.gif)

## Hope

如果觉得有用，欢迎star</br>
如果使用发现问题，欢迎issue

## 支持作者

开发插件占用了我个人大量的私人时间，如果你觉得对你有所帮助，不妨请我喝杯☕️以鼓励我开发出更优秀的插件</br>
<img src="https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/wechatpay.png" height="300" hspace="20" /> </br>
<img src="https://github.com/kevll/WeChatRedEnvelopesHelper/blob/master/screenshots/alipay.png" height="300" hspace="20" />
