// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MTPopup",
  platforms: [
	.iOS(SupportedPlatform.IOSVersion.v11)
  ],
  products: [
    .library(name: "MTPopup", targets: ["MTPopup"]),
  ],
  targets: [
    .target(
      name: "MTPopup",
      dependencies: [],
      path: "MTPopup"
    ),
  ]
)
