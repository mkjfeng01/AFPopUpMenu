#
# Be sure to run `pod lib lint AFPopUpMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AFPopUpMenu'
  s.version          = '0.1.5'
  s.summary          = '类似微信弹出的分享界面小窗口，集成简单只需要一句话就可以，如果喜欢欢迎Star😄'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
类似微信弹出的分享界面小窗口，集成简单只需要一句话就可以，如果喜欢欢迎Star😄。https://github.com/mkjfeng01/AFPopUpMenu
                       DESC

  s.homepage         = 'https://github.com/mkjfeng01/AFPopUpMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mkjfeng01' => 'mkjfeng01@gmail.com' }
  s.source           = { :git => 'https://github.com/mkjfeng01/AFPopUpMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AFPopUpMenu/Classes/**/*'

  s.resources = 'AFPopUpMenu/Assets/*.bundle'

  # s.resource_bundles = {
  #   'AFPopUpMenu' => ['AFPopUpMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
