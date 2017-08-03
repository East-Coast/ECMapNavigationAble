
Pod::Spec.new do |s|
  s.name             = 'ECMapNavigationAble'
  s.version          = '0.1.1'
  s.summary          = '调用第三方导航'


  s.description      = <<-DESC
 一句话集成 应用内调用百度、高德、腾讯导航
                       DESC

  s.homepage         = 'https://github.com/East-Coast/ECMapNavigationAble'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'East-Coast' => 'heng_sea@163.com' }
  s.source           = { :git => 'https://github.com/East-Coast/ECMapNavigationAble.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ECMapNavigationAble/Classes/**/*'
  # s.public_header_files = 'ECMapNavigationAble/Classes/**/*.{swift,h,m}'
  s.frameworks = 'UIKit', 'Foundation', 'CoreLocation'
  s.dependency 'JZLocationConverter'
end
