#
# Be sure to run `pod lib lint NFBeeController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NFBeeController'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NFBeeController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ninefivefly/NFBeeController'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ninefivefly' => 'ninefivefly@foxmail.com' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.source           = { :git => "https://github.com/ninefivefly/NFBeeController.git" }
  ## 这里不支持ssh的地址，只支持HTTP和HTTPS，最好使用HTTPS
  ## 正常情况下我们会使用稳定的tag版本来访问，如果是在开发测试的时候，不需要发布release版本，直接指向git地址使用
  ## 待测试通过完成后我们再发布指定release版本，使用如下方式
  #s.source          = { :git => 'https://github.com/ninefivefly/NFBeeController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'NFBeeController/**/*'
  
  # s.resource_bundles = {
  #   'NFBeeController' => ['NFBeeController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'JSONModel'
  s.dependency 'MBProgressHUD'
end
