Pod::Spec.new do |s|
  s.name         = 'FMCategoryKit'
  s.summary      = 'A set of useful categories for Foundation and UIKit.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { '袁凤鸣' => 'yfmingo@163.com' }# 作者信息
  s.social_media_url = 'https://www.yfmingo.cn/'
  s.homepage     = 'https://github.com/yfming93/FMCategoryKit'
  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.source       = { :git => 'git@github.com:yfming93/FMCategoryKit.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'FMCategoryKit/**/*.{h,m}'
  s.public_header_files = 'FMCategoryKit/**/*.{h}'
  
  non_arc_files = 'FMCategoryKit/Foundation/NSObject+FMAddForARC.{h,m}', 'FMCategories/Foundation/NSThread+FMAdd.{h,m}'
  s.ios.exclude_files = non_arc_files
  s.subspec 'no-arc' do |sna|
    sna.requires_arc = false
    sna.source_files = non_arc_files
  end

  s.libraries = 'z'
  s.frameworks = 'UIKit', 'CoreFoundation' ,'QuartzCore', 'CoreGraphics', 'CoreImage', 'CoreText', 'ImageIO', 'Accelerate'

end
