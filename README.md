# ECMapNavigationAble

ECMapNavigationAble 是由swift编写，应用内跳转手机导航的库，依赖[JZLocationConverter](https://github.com/JackZhouCn/JZLocationConverter) 进行高德坐标、百度坐标、GPS坐标之间相互转换,支持Apple地图、高德地图、百度地图、Google地图、腾讯地图。

# 安装

```ruby
pod "ECMapNavigationAble"
``` 

# 使用案例


``` swift
let location = ECLocation(coordinate: CLLocationCoordinate2D(latitude: 30.2853100000, longitude: 120.1001900000), type: .gcj02)  
let alert = mapNavigation(destination: location,scheme: "ecmapnavigation", app: "demo")  
present(alert, animated: true, completion: nil)
```


## Author

East-Coast, heng_sea@163.com

## License

ECMapNavigationAble is available under the MIT license. See the LICENSE file for more info.
