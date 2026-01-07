Pod::Spec.new do |spec|
    spec.name         = "CoursesUxMiamFramework"
    spec.version      = "5.10.8"
    spec.summary      = "Miam iOS SDK for Courses U"
    spec.description  = <<-DESC
    Miam iOS SDK for Courses U.
    DESC
    spec.homepage     = "https://www.miam.tech"
    spec.license      = "GPLv3"
    spec.author             = { "Diarmuid McGonagle" => "it@miam.tech" }
    spec.platform     = :ios, "12.0"
    spec.swift_versions = "5.8"
    spec.resources = "Sources/CoursesUxMiamFramework/Resources/**/*.png",
    "Sources/CoursesUxMiamFramework/Resources/fr.lproj",
    "Sources/CoursesUxMiamFramework/Resources/**/*.ttf"
    
    spec.source       = { :git => "https://github.com/miamtech/coursesU-x-Miam-Framework.git", :tag => "5.10.8" }
    spec.source_files = 'Sources/**/*.{h,m,swift}'
    spec.dependency 'MealziOSSDK', '5.10.8'
    spec.static_framework = true
end
