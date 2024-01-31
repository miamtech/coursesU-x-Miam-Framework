Pod::Spec.new do |spec|

    spec.name         = "CoursesUxMiamFramework"
    spec.version      = "2.0.0-beta1"
    spec.summary      = "Miam iOS SDK for Courses U"
    spec.description  = <<-DESC
    Miam iOS SDK for Courses U.
    DESC
    spec.homepage     = "https://www.miam.tech"
    spec.license      = "GPLv3"
    spec.author             = { "Diarmuid McGonagle" => "it@miam.tech" }
    spec.platform     = :ios, "12.0"
    spec.swift_versions = "5.8"
    spec.resources = "Sources/CoursesUxMiamFramework/Resources/**/*.png"
    spec.source       = { :git => "https://github.com/miamtech/coursesU-x-Miam-Framework.git", :tag => "#{spec.version}" }
    spec.source_files = 'Sources/**/*.{h,m,swift}'
    spec.dependency 'MealzUIModuleIOS', '~> 1.0.0-beta2'
    spec.static_framework = true
end
