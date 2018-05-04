#
#  Be sure to run `pod spec lint OnestapSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "OnestapSDK"
  s.version      = "1.1.2"
  s.summary      = "one[s]tap Authorization SDK"
  s.description  = <<-DESC
It connects to one[s]tap API using OAuth
                   DESC
  s.homepage     = "http://www.stone.com.br"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "Munir Wanis"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/stone-payments/onestap-sdk-ios.git", :tag => "#{s.version}" }
  s.source_files  = "OnestapSDK", "OnestapSDK/**/*.{h,swift}"
end
