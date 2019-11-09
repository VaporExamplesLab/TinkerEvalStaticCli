// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "TinkerEvalStaticCli",
    platforms: [
        // specify each minimum deployment requirement, 
        // otherwise the platform default minimum is used.
        .macOS(.v10_13), // ..v10_13 High Sierra .v10_14 Mojave, .v10_15 Catalina 
    ],
    dependencies: [
        .package(url: "git@github.com:VaporExamplesLab/TinkerEvalStaticLib.git", .branch("master") ),
    ],
    targets: [
        .target(
            name: "TinkerEvalStaticCli",
            dependencies: ["TinkerEvalStaticLib"]),
    ],
    swiftLanguageVersions: [.v5]
)
