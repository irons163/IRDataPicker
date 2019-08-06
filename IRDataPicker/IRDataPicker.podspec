Pod::Spec.new do |spec|
  spec.name         = "IRDataPicker"
  spec.version      = "1.0.0"
  spec.summary      = "A powerful DataPicker of iOS."
  spec.description  = "A powerful DataPicker of iOS."
  spec.homepage     = "https://github.com/irons163/IRDataPicker.git"
  spec.license      = "MIT"
  spec.author       = "irons163"
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/irons163/IRDataPicker.git", :tag => spec.version.to_s }
# spec.source       = { :path => '.' }
  spec.source_files  = "Class/**/*.{h,m}", "IRDataPicker/Class/**/*.{h,m}"
  spec.resource_bundles = {
    'IRDataPickerBundle' => ["../IRDataPickerBundle/**/*", "IRDataPickerBundle/**/*"]
  }
end