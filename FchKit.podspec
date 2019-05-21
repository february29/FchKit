#
# Be sure to run `pod lib lint FchKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FchKit'
  s.version          = '0.2.4'
  s.summary          = 'A short description of FchKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/february29/FchKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'february29' => 'baiyahui@fchsoft.com' }
  s.source           = { :git => 'https://github.com/february29/FchKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

 

 s.subspec 'FchSwiftKit' do |ss|
     # ss.source_files = 'FchKit/Classes/FchSwiftKit/**/*'
    
    ss.subspec 'Adapter' do |sss|
        sss.source_files = 'FchKit/Classes/FchSwiftKit/Adapter/**/*'
        
    end
    
    ss.subspec 'BBaseClass' do |sss|
        sss.source_files = 'FchKit/Classes/FchSwiftKit/BBaseClass/**/*'
        
    end
    
    ss.subspec 'BTools' do |sss|
        sss.source_files = 'FchKit/Classes/FchSwiftKit/BTools/**/*'
        
    end
    
    ss.subspec 'CommonViews' do |sss|
        sss.source_files = 'FchKit/Classes/FchSwiftKit/CommonViews/**/*'
        
    end
    
    ss.subspec 'BNetWorking' do |sss|
        sss.source_files = 'FchKit/Classes/FchSwiftKit/BNetWorking/BAlamofireManager.swift'
        
        sss.dependency 'Alamofire'
        # sss.dependency 'HandyJSON'
        #sss.dependency 'RxSwift'
        
    end

    ss.dependency 'SnapKit'
    ss.dependency 'BAlert'
  
  end

 s.subspec 'FchOCKit' do |ss|
     
    #ss.source_files = 'FchKit/Classes/FchOCKit/*.{h,m}'

    
    
    ss.subspec 'BNetWorking' do |sss|
      sss.source_files = 'FchKit/Classes/FchOCKit/BNetWorking/**/*'
          
      sss.dependency 'AFNetworking'
          
    end
      
    ss.subspec 'BToolKit' do |sss|
      sss.source_files = 'FchKit/Classes/FchOCKit/BToolKit/**/*'
          
          
          
    end
    
    ss.subspec 'BaseClass' do |sss|
      sss.source_files = 'FchKit/Classes/FchOCKit/BaseClass/**/*'
        
        
        
    end
    
    # ss.subspec 'BHUD' do |sss|
    #   sss.source_files = 'FchKit/Classes/FchOCKit/BHUD/**/*'
        
    # end
    
    # ss.subspec 'CommenLib' do |sss|
    # sss.source_files = 'FchKit/Classes/FchOCKit/CommenLib/**/*'
        
        # sss.dependency  'SDWebImage'
        #end
    
    ss.subspec 'CommenViews' do |sss|
      sss.source_files = 'FchKit/Classes/FchOCKit/CommenViews/**/*'
        
        # sss.dependency  'SDWebImage'
    end
    
   
    
    
    
    ss.dependency 'Masonry'
    # ss.dependency 'BHUD'
    ss.dependency 'BlocksKit'
  end
 

 
  

 
  s.swift_version = '4.2'


  # s.source_files = 'FchKit/Classes/**/*'

  # s.resource_bundles = {
  #   'FchKit' => ['FchKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
 
 


end
