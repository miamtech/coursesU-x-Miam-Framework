import miamCore

public struct CoursesUxMiamFramework {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public static var bundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle.main
#endif
    }
}
