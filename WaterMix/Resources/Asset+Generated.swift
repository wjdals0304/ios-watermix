// swiftlint:disable all
/// Attention: Changes made to this file will not have any effect and will be reverted 
/// when building the project. Please adjust the Stencil template `asset_extensions.stencil` instead.
/// See https://github.com/SwiftGen/SwiftGen#bundled-templates-vs-custom-ones for more information.

import UIKit

// MARK: - Private Helper -

private final class BundleToken {}
private let bundle = Bundle(for: BundleToken.self)

// MARK: - Colors -

extension UIColor {
    static let accentColor = UIColor(named: "AccentColor", in: bundle, compatibleWith: nil)!
    static let _0075Ff = UIColor(named: "0075FF", in: bundle, compatibleWith: nil)!
    static let _131313 = UIColor(named: "131313", in: bundle, compatibleWith: nil)!
    static let _181818 = UIColor(named: "181818", in: bundle, compatibleWith: nil)!
    static let _555555 = UIColor(named: "555555", in: bundle, compatibleWith: nil)!
    static let _929292 = UIColor(named: "929292", in: bundle, compatibleWith: nil)!
    static let b8Bbbe = UIColor(named: "B8BBBE", in: bundle, compatibleWith: nil)!
    static let e5E7Ea = UIColor(named: "E5E7EA", in: bundle, compatibleWith: nil)!
    static let f8F8F8 = UIColor(named: "F8F8F8", in: bundle, compatibleWith: nil)!
    static let ff0F00 = UIColor(named: "FF0F00", in: bundle, compatibleWith: nil)!
    static let ff5C00 = UIColor(named: "FF5C00", in: bundle, compatibleWith: nil)!
    static let ffffff = UIColor(named: "FFFFFF", in: bundle, compatibleWith: nil)!
}

// MARK: - Images -

extension UIImage {
    static let undoArrow1 = UIImage(named: "undo-arrow 1", in: bundle, compatibleWith: nil)!
}

