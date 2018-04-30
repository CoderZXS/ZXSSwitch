# ZXSSwitch
模仿iOS7风格，实现Switch控件可以自定义文字

使用
--------

```Objective-C
    ZXSSwitch *myswitch = [[ZXSSwitch alloc] initWithFrame:CGRectMake(200, 200, 80, 31)];
    [self.view addSubview:myswitch];
    [myswitch addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    myswitch.backgroundColor = [UIColor clearColor];
    myswitch.onText = @"ON";
    myswitch.offText = @"OFF";
```

效果
--------
![off](https://github.com/CoderZXS/ZXSSwitch/blob/master/ZXSSwitch1.png)
![on](https://github.com/CoderZXS/ZXSSwitch/blob/master/ZXSSwitch2.png)


结后语
--------
如果你觉得还不错的话，请点个星星吧！
作者QQ:1252935734 你要是对本框架有什么建议，欢迎加我QQ，希望与小伙伴们一起学习、成长！！！
