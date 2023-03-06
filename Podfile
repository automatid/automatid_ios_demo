source 'git@github.com:automatid/automatid_specs.git'
source 'https://github.com/CocoaPods/Specs.git'

install! 'cocoapods', :deterministic_uuids => false
use_frameworks!
platform :ios, '12.0'


target 'AutomatID_Example' do
    pod 'AutomatID'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
            target.build_configurations.each do |config|
              config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            end
          end
        end
    end
end