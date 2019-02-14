Pod::Spec.new do |s|


  s.name         = "NNEasyKit"
  s.version      = "0.0.1"
  s.summary      = "快速开发OC项目的框架"
  s.description  = <<-DESC
  		   一个快速开发OC项目的框架，包括Extension、Network、Components
                   DESC
  s.homepage     = "https://github.com/YiHuaXie/NNEasyKit"
  s.license      = "MIT"
  s.author       = { "NeroXie" => "xyh30902@163.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "git@github.com:YiHuaXie/NNEasyKit.git", :tag => "#{s.version}" }
  s.source_files  = "NNEasyKit/NNEasyKit/*.{h,m}"
  s.frameworks 	 = 'Foundation', 'UIKit'
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
end
