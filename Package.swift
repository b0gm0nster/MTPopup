// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "MTPopup",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(name: "MTPopup", targets: ["MTPopup"]),
  ],
  targets: [
    .target(
      name: "MTPopup",
      dependencies: [],
      path: "Classes"
    ),
  ],
  swiftLanguageVersions: [.v5]
)
