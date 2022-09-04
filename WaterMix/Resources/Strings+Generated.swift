// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// 추가 매수
  internal static var addStock: String { L10n.tr("Localizable", "AddStock") }
  /// 추매 수량
  internal static var addStockAmount: String { L10n.tr("Localizable", "AddStockAmount") }
  /// 추매 평단가
  internal static var addStockPrice: String { L10n.tr("Localizable", "AddStockPrice") }
  /// 총 추매 금액
  internal static var addStockTotalPrice: String { L10n.tr("Localizable", "AddStockTotalPrice") }
  /// 현재 시장가
  internal static var currentMarketPrice: String { L10n.tr("Localizable", "CurrentMarketPrice") }
  /// 현재 보유 주식
  internal static var currentStock: String { L10n.tr("Localizable", "CurrentStock") }
  /// 보유 수량
  internal static var currentStockAmount: String { L10n.tr("Localizable", "CurrentStockAmount") }
  /// 보유 주식 평단가
  internal static var currentStockPrice: String { L10n.tr("Localizable", "CurrentStockPrice") }
  /// 총 매입 금액
  internal static var currentStockTotalPrice: String { L10n.tr("Localizable", "CurrentStockTotalPrice") }
  /// 손익금
  internal static var proAndLoss: String { L10n.tr("Localizable", "proAndLoss") }
  /// 손익률
  internal static var ratio: String { L10n.tr("Localizable", "Ratio") }
  /// 물타기 계산기
  internal static var title: String { L10n.tr("Localizable", "Title") }
  /// 최종 수량
  internal static var totalAmount: String { L10n.tr("Localizable", "TotalAmount") }
  /// 최종 매수 금액
  internal static var totalPrice: String { L10n.tr("Localizable", "TotalPrice") }
  /// 최종 평단가
  internal static var totalPurchasePrice: String { L10n.tr("Localizable", "TotalPurchasePrice") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
