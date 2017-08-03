# ECMapNavigationAble

ECMapNavigationAble 是由swift编写，应用内跳转手机导航的库，依赖[JZLocationConverter](https://github.com/JackZhouCn/JZLocationConverter) 进行高德坐标、百度坐标、GPS坐标之间相互转换,支持Apple地图、高德地图、百度地图、Google地图、腾讯地图。

# 安装

```ruby
pod "ECMapNavigationAble"
``` 

# 使用案例

返回UIAlertController

``` swift
let location = ECLocation(coordinate: CLLocationCoordinate2D(latitude: 30.2853100000, longitude: 120.1001900000), type: .gcj02)  
let alert = mapNavigation(destination: location,scheme: "ecmapnavigation", app: "demo")  
present(alert, animated: true, completion: nil)
```

在UIViewController中使用 遵守ECMapNavigationAble 协议

``` swift
class ViewController: UIViewController,ECMapNavigationAble {

  override func viewDidLoad() {
     super.viewDidLoad()
        ...
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    //使用方法
    let destination = CLLocationCoordinate2D(latitude: 30.2853100000, longitude: 120.1001900000)
    showNavigationListAlert(destination: destination, locationType: .gcj02, scheme: "ecmapnavigation")
  }

```

### 注意在使用前在infoplist文件中添加
```
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>qqmap</string>
		<string>iosamap</string>
		<string>baidumap</string>
		<string>comgooglemaps</string>
	</array>
```

## Author

East-Coast, heng_sea@163.com

## License

ECMapNavigationAble is available under the MIT license. See the LICENSE file for more info.
