# TinkerEvalStaticCli

**Question:** After `generate-xcodeproj`, what Xcode settings are needed to statically link a Swift Package Library into a simple command line executable … similar to what is produced by corresponding `swift build`?

**Goal:** Produce a statically linked executable with Xcode like what is produced by `swift build` from the command line _… for the same module product._ 

The issue is that the `generate-xcodeproj` produced project creates a dynamically linked product (not expected) while `swift build` produces a statically linked product (as expected).

**Example:** Consider two Swift Manager Packages (SPM) packages:

1. static library: [`TinkerEvalStaticLib`⇗](https://github.com/VaporExamplesLab/TinkerEvalStaticLib) with `swift package init --type library` as the starting point.
2. command line executable: [`TinkerEvalStaticCli`⇗](https://github.com/VaporExamplesLab/TinkerEvalStaticCli) with `swift package init --type executable` as the starting point.

`TinkerEvalStaticLib` is simple and expressly set to a type `.static`.

_TinkerEvalStaticLib.swift_

``` swift
public class TinkerEvalStaticLib {
    public static func printSomething() -> String {
        let s = "Library says, 'Hello.'"
        print(s)
        return s
    }
} 
```
    
_Package.swift_

``` swift
…
products: [
    .library(name: "TinkerEvalStaticLib", 
    type: .static, // expressly set to be a static library
    …
```

`TinkerEvalStaticCli` is also simple and has `TinkerEvalStaticLib` as a dependency.

_main.swift_

``` swift
import TinkerEvalStaticLib
let _ = TinkerEvalStaticLib.printSomething() 
```

_Package.swift_

``` swift
…
name: "TinkerEvalStaticCli",
dependencies: [
  .package(
    url: "git@github.com:VaporExamplesLab/TinkerEvalStaticLib.git",
    .branch("master") ),
],
…
```

**Observation:**

1. In the `TinkerEvalStaticCli` directory, `swift build` will create a standalone relocatable, statically linked executable.

```
prompt> ./TinkerEvalStaticCli_spm 
Library says, 'Hello.'
```

2. However, the Xcode project created with `swift package generate-xcodeproj` creates a dynamically linked executable that requires the separate library.

```
prompt> ./TinkerEvalStaticCli_xc 
dyld: Library not loaded: @rpath/TinkerEvalStaticLib.framework/Versions/A/TinkerEvalStaticLib
  Referenced from: /Users/…/./TinkerEvalStaticCli_xc
  Reason: image not found
Abort trap: 6
```

**Note:** One would expect that an `swift package generate-xcodeproj` generated Xcode project would build a static linked binary (instead of a dynamic linked binary) similar to the static linked binary produced by the corresponding `swift build`. So, this question is for a workaround to a current SPM `generate-xcodeproj` limitation. 
