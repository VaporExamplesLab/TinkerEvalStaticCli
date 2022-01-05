// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "TinkerEvalStaticCli",
    platforms: [
        // specify each minimum deployment requirement, 
        // otherwise the platform default minimum is used.
        .macOS(.v10_15), // Catalina 
    ],
    dependencies: [
        .package(url: "git@github.com:VaporExamplesLab/TinkerEvalStaticLib.git", .branch("master") ),
    ],
    targets: [
        .executableTarget(
            name: "TinkerEvalStaticCli",
            dependencies: ["TinkerEvalStaticLib"]),
    ],
    swiftLanguageVersions: [.v5]
)
