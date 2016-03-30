# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'joynem' do
    
    pod 'pop', :git => 'https://github.com/facebook/pop.git'
    
    pod 'Koloda', '~> 2.0.10'
    
    post_install do |installer|
        `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
    end


end

