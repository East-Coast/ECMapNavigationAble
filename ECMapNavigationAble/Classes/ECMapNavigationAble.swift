

import Foundation
import MapKit
import CoreLocation
import JZLocationConverter



//导航坐标
struct ECLocation {
  var coordinate:CLLocationCoordinate2D
  var type:ECLocationType
}


/**
 * WGS-84  GPS原始坐标
 * GCJ-02  火星坐标 适用于高德、腾讯,google中国地图
 * BD-09   百度坐标
 */

enum ECLocationType {
  case wgs84
  case gcj02
  case bd09
}

/**
 * coordinateGPS  GPS坐标
 * coordinateGCJ  火星坐标 适用于高德、腾讯地图
 * coordinateBD   百度坐标
 */

protocol ECCoordinateType {
  var wgs84Coordinate:CLLocationCoordinate2D {get}
  var gcj02Coordinate:CLLocationCoordinate2D {get}
  var bd09Coordinate:CLLocationCoordinate2D {get}
}


extension ECLocation: ECCoordinateType {
  
  var wgs84Coordinate: CLLocationCoordinate2D{
    switch type {
    case .bd09:
      return JZLocationConverter.bd09(toWgs84: coordinate)
    case .gcj02:
      return JZLocationConverter.gcj02(toWgs84: coordinate)
    case .wgs84:
      return coordinate
      
    }
  }
  
  var gcj02Coordinate: CLLocationCoordinate2D{
    switch type {
    case .bd09:
      return JZLocationConverter.bd09(toGcj02: coordinate)
    case .gcj02:
      return coordinate
    case .wgs84:
      return JZLocationConverter.wgs84(toGcj02: coordinate)
      
    }
  }
  
  
  var bd09Coordinate: CLLocationCoordinate2D{
    switch type {
    case .bd09:
      return coordinate
    case .gcj02:
      return JZLocationConverter.gcj02(toBd09: coordinate)
    case .wgs84:
      return JZLocationConverter.wgs84(toBd09: coordinate)
      
    }
  }
  
  
}

struct ECMapResult {
  var name:String!
  var urlStr:String!
}


protocol ECMapNavigationAble {
  
  /**
   * 调用第三方导航从当前位置出发
   * destination:  目的地坐标（GCJ-02）
   * scheme: 用于返回APP
   */
  func mapNavigation(destination:ECLocation,scheme:String,app:String) -> UIAlertController
  
  
  /**
   * 调用第三方导航
   * origin:  起点坐标 （GCJ-02）
   * destination:  目的地坐标（GCJ-02）
   * scheme: 用于返回APP
   */
  //func mapNavigation(origin:ECLocation,destination:ECLocation,scheme:String)
}


extension ECMapNavigationAble {

  func mapNavigation(destination:ECLocation,scheme:String,app:String) -> UIAlertController{
    
    let array =  [baidumapNavigation(destination: destination),
            qqmapNavigation(destination: destination, app: app),
            amapNavigation(destination: destination, scheme: scheme, app: app),
            googlemapNavigation(destination: destination)]
    
    let alert = UIAlertController(title: "选择地图", message: nil, preferredStyle: .actionSheet)
    
    let mapAction = UIAlertAction(title: "苹果地图", style: .default) { (_) in
      self.applemapNavigation(destination: destination)
    }
    alert.addAction(mapAction)
    
    alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
    
    for result in array {
      
      if let result = result {
        let action = UIAlertAction(title: result.name, style: .default, handler: { (_) in
          self.openUrl(string: result.urlStr)
        })
        alert.addAction(action)
      }
    }
    
    return alert
  }
  
  
  func openUrl(string:String){
    
    let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    
    UIApplication.shared.openURL(url!)
  }
  
  //调用苹果地图
  func applemapNavigation(destination:ECLocation){
    let coordinate = destination.gcj02Coordinate
    let start = MKMapItem.forCurrentLocation()
    let end = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
    MKMapItem.openMaps(with: [start,end], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:true])
  }
  
  
  //调用百度地图导航
  func baidumapNavigation(destination:ECLocation) -> ECMapResult?{
    
    if !UIApplication.shared.canOpenURL(URL(string:"baidumap://")!) {
      return nil
    }
    
    let coordinate = destination.bd09Coordinate
    let string = "baidumap://map/direction?origin={{我的位置}}&destination=name:目的地|latlng:\(coordinate.latitude),\(coordinate.longitude)&mode=driving&coord_type=bd09ll"
    return ECMapResult(name: "百度地图", urlStr: string)
  }
  
  //调用高德地图导航
  func amapNavigation(destination:ECLocation,scheme:String,app:String) -> ECMapResult?{
    if !UIApplication.shared.canOpenURL(URL(string:"iosamap://")!) {
      return nil
    }
    let coordinate = destination.gcj02Coordinate
    let string = "iosamap://path?sourceApplication=\(app)&backScheme=\(scheme)&did=BGVIS2&dname=目的地&dlat=\(coordinate.latitude)&dlon=\(coordinate.longitude)&dev=0&m=0&t=0"
    return ECMapResult(name: "高德地图", urlStr: string)
  }
  
  //Google地图
  func googlemapNavigation(destination: ECLocation) -> ECMapResult?{
    
    if !UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
      return nil
    }
    
    let coordinate = destination.gcj02Coordinate
    let string = "comgooglemaps://?saddr=&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving"
    return ECMapResult(name: "Google地图", urlStr: string)
  }
  
  //腾讯地图
  func qqmapNavigation(destination:ECLocation,app: String) -> ECMapResult?{
    
    if !UIApplication.shared.canOpenURL(URL(string:"qqmap://")!) {
      return nil
    }
    
    let coordinate = destination.gcj02Coordinate
    let string = "qqmap://map/routeplan?type=drive&from=我的位置&to=目的地&tocoord=\(coordinate.latitude),\(coordinate.longitude)&referer=\(app)&coord_type=2&policy=0"
    return ECMapResult(name: "腾讯地图", urlStr: string)
  }

}
