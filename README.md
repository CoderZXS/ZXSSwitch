# ZXSSwitch
模仿iOS7风格，实现Switch控件可以自定义文字

如何使用
--------

```Objective-C
ZXSSwitch *myswitch = [[ZXSSwitch alloc] initWithFrame:CGRectMake(200, 200, 80, 31)];
[self.view addSubview:myswitch];
[myswitch addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
myswitch.backgroundColor = [UIColor clearColor];
myswitch.onText = @"ON";
myswitch.offText = @"OFF";
```

UI界面
--------
![ZXSSwitch](https://github.com/CoderZXS/ZXSSwitch/blob/master/ZXSSwitch.png)
