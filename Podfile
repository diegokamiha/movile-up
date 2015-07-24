source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

target 'MovileProject', :exclusive => true do
   pod 'Alamofire'
   pod 'Result'
   pod 'Kingfisher'
   pod 'TraktModels', :git => 'https://github.com/marcelofabri/TraktModels.git'
end

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Nimble'
  pod 'OHHTTPStubs'
end

