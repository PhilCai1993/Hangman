#界面
* 为了适配屏幕, 我使用了 AutoLayout, 一部分是使用 Storyboard, 也有一部分使用了 Masonry.
* 使用了简单的 UIView 动画, 界面稍微看起来不那么无聊.
* 使用了 UIColor+MLPFlatColors, 使界面看起来比较扁平.
* 使用了 YETICharacterLabel 简单的使得界面的文字有时候稍微有趣一点.

#网络
* 使用 AFNetworking, 做了一个简单的封装做请求.

#数据
* 在这个 app 里面, 我第一次使用了自己写的 [PHDynamicObject][1], 使得 NSUserDefaults 可以更简单的使用.

#开发
* 使用了 CocoaPods 管理第三方库.

#其他
* 因为自己的一些原因, 仅仅是实现了功能, 但是数据的保存等部分并没有完善.
* 因为不小心把Xcode6删了, 代码是用的 beta 版本的 Xcode 写的, 用到了ObjC 的泛型, 可能旧版本的不能编译, 需要小改.

[1]:https://github.com/PhilCai1993/PHDynamicObject "PHDynamicObject"
