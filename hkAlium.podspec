Pod::Spec.new do |s|
  s.name             = 'hkAlium'
  s.version          = '1.0.4'
  s.summary          = 'Make an UICollectionView with cells that have different heights.'
 
  s.description      = <<-DESC
This library provides a way to create an UICollectionView with cells that have different heights.
                       DESC
 
  s.homepage         = 'https://github.com/heuristisk/hkAlium.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anderson Santos Gusmão' => 'heuristisking@gmail.com' }
  s.source           = { :git => 'https://github.com/heuristisk/hkAlium.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '8.0'
  s.source_files = 'hkAlium/*'
 
end