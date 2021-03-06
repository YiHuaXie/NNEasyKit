#
#  Be sure to run `pod spec lint NNEasyKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "NNEasyKit"
  s.version      = "0.0.3.1"
  s.summary      = "快速开发OC项目的框架"
  s.description  = <<-DESC
  		   一个快速开发OC项目的框架，包括Extension、Network、Components
                   DESC
  s.homepage     = "https://github.com/YiHuaXie/NNEasyKit"
  s.license      = "MIT"
  s.author       = { "NeroXie" => "xyh30902@163.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/YiHuaXie/NNEasyKit.git", :tag => s.version }
  s.frameworks 	 = 'Foundation', 'UIKit'
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  # s.public_header_files = 'NNEasyKit/NNEasyKit.h'
  s.source_files  = 'NNEasyKit/NNEasyKit/NNEasyKit.h'
  
  s.subspec 'NNExtension' do |ss|
    ss.source_files = 'NNEasyKit/NNEasyKit/NNExtension/*.{h,m}'
  end

  s.subspec 'NNNetwork' do |ss|
    ss.dependency 'AFNetworking'
    ss.dependency 'NNEasyKit/NNExtension'
    ss.source_files = 'NNEasyKit/NNEasyKit/NNNetwork/*.{h,m}'
  end

  s.subspec 'NNComponent' do |ss|
    ss.dependency 'NNEasyKit/NNExtension'
    ss.source_files = 'NNEasyKit/NNEasyKit/NNComponent/**/*.{h,m}'

    # ss.subspec 'NNAlertView' do |sss|
      #sss.source_files = 'NNEasyKit/NNEasyKit/NNComponent/NNAlertView/*.{h,m}'
    #end
    
    #ss.subspec 'NNGCDTimer' do |sss|
      #sss.source_files = 'NNEasyKit/NNEasyKit/NNComponent/NNGCDTimer/*.{h,m}'
    #end
    
    #ss.subspec 'NNPFSLabel' do |sss|
      #sss.source_files = 'NNEasyKit/NNEasyKit/NNComponent/NNPFSLabel/*.{h,m}'
    #end
    
    #ss.subspec 'NNPinYin' do |sss|
      #sss.dependency 'NNEasyKit/NNExtension'
      #sss.source_files = 'NNEasyKit/NNEasyKit/NNComponent/NNPinYin/*.{h,m}'
    #end

    #ss.subspec 'NNCarousel' do |sss|
      #sss.source_files = 'NNEasyKit/NNEasyKit/NNComponent/NNCarousel/*.{h,m}'
    #end

  end

end

# 本地验证 pod lib lint --use-libraries --allow-warnings --verbose
# 共有验证 pod spec lint NNEasyKit.podspec --use-libraries --allow-warnings --verbose
# 推送远程 pod trunk push NNEasyKit.podspec --use-libraries --allow-warnings