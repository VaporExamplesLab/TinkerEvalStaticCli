// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TinkerEvalStaticCli",
    dependencies: [
        .package(url: "git@github.com:VaporExamplesLab/TinkerEvalStaticLib.git", .branch("master") ),
    ],
    targets: [
        .target(
            name: "TinkerEvalStaticCli",
            dependencies: ["TinkerEvalStaticLib"]),
    ],
    swiftLanguageVersions: [4]
)
