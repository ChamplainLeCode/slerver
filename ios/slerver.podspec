#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint slerver.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'slerver'
  s.version          = '1.0.0'
  s.summary          = 'This plugin provides server side solution to interconnect flutter app.'
  s.description      = <<-DESC
This plugin provides server side solution to interconnect flutter app.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bixterprise' => 'champlainmarius20@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
