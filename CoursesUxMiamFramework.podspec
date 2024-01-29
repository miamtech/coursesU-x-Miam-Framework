Pod::Spec.new do |spec|

  spec.name         = "CoursesUxMiamFramework"
  spec.version      = "2.0.0-beta"
  spec.summary      = "Miam iOS SDK for Courses U"
  spec.description  = <<-DESC
Miam iOS SDK for Courses U.
                   DESC

  spec.homepage     = "https://www.miam.tech"
  spec.license      = "GPLv3"
  spec.author             = { "Diarmuid McGonagle" => "it@miam.tech" }
  spec.platform     = :ios, "11.0"
  spec.swift_version = "5.8"
  spec.resources = "Sources/CoursesUxMiamFramework/Resources/**/*.png"

  
  spec.source       = { :git => "https://github.com/miamtech/coursesU-x-Miam-Framework.git", :tag => "#{spec.version}" }

 
   spec.source_files = 'Sources/**/*.{h,m,swift}'
   
spec.dependency 'MiamIOSFramework', '~> 4.0.0-beta'
spec.dependency 'miamCore', '~> 4.0.0-beta'

end
