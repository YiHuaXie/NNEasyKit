#
#  Be sure to run `pod spec lint NNEasyKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "NNEasyKit"
  s.version      = "0.0.1.3"
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
  s.source_files  = "NNEasyKit/NNEasyKit/NNEasyKit.h"
  
  s.subspec 'NNExtension' do |ss|
    ss.source_files = 'NNEasyKit/NNEasyKit/NNExtension/*.{h,m}'
  end

  s.subspec 'NNComponent' do |ss|
    ss.source_files = 'NNEasyKit/NNEasyKit/NNComponent'
  end

end
