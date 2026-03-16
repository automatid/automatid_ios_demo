source 'git@github.com:automatid/automatid_specs.git'
source 'https://github.com/CocoaPods/Specs.git'

install! 'cocoapods', :deterministic_uuids => false
use_frameworks!
platform :ios, '15.0'


target 'AutomatID_Example' do
  pod 'AutomatID'
  pod 'lottie-ios', '~>4'
  pod 'Firebase/Core', '10.29.0'
  pod 'Firebase/Crashlytics', '10.29.0'
end

post_install do |installer|
  installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
                config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
                config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
             end
        end
  end
end