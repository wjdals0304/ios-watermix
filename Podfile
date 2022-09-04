# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
inhibit_all_warnings!
def common_pods
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
end


target 'WaterMix' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  common_pods
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint'  
  pod 'SnapKit', '~> 5.6.0'
  pod 'TextFieldEffects'

  target 'WaterMixTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WaterMixUITests' do
    # Pods for testing
  end

end
