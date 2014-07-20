Pod::Spec.new do |s|
  s.name             = "KYCircleMenu"
  s.version          = "1.2.0"
  s.summary          = "A circle menu with toggling animation."
  s.description      = <<-DESC
                       An open source iOS UI control that allows you to build a circular menu by laying out buttons in a circle pattern adjusting from the number of buttons (1~6).
                       DESC
  s.homepage         = "https://github.com/Kjuly/KYCircleMenu"
  s.license          = 'MIT'
  s.author           = { "Kaijie Yu" => "dev@kjuly.com" }
  s.source           = { :git => "https://github.com/Kjuly/KYCircleMenu.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'KYCircleMenu'

  s.frameworks = 'UIKit', 'CoreGraphics'
end

