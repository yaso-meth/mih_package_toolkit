import 'package:flutter/widgets.dart'; // You need this import for IconData

/// A custom icon collection specifically designed for the MIH Toolkit.
///
/// [MihIcons] provides a set of [IconData] constants mapped to the 'MihIcons'
/// custom font family. To use these icons, ensure the following is added to
/// your application's `pubspec.yaml`:
///
/// ```yaml
/// flutter:
///   fonts:
///     - family: MihIcons
///       fonts:
///         - asset: packages/mih_package_toolkit/assets/fonts/MihIcons.ttf
/// ```
///
/// ### Example:
/// ```dart
/// Icon(MihIcons.mihLogo, color: MihColors.primary())
/// ```
class MihIcons {
  /// Private constructor to prevent instantiation of this utility class.
  MihIcons._();

  /// The font family name used for all icons in this set.
  static const _mihFontFam = 'MihIcons';

  /// The package name where the font asset is located.
  static const String _mihFontPkg = 'mih_package_toolkit';

  /// An icon representing a mine sweeper game or tool.
  static const IconData mineSweeper = IconData(
    0xe900,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi Directory service.
  static const IconData mzansiDirectory = IconData(
    0xe901,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a personal user profile.
  static const IconData personalProfile = IconData(
    0xe902,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon for the "About MIH" information section.
  static const IconData aboutMih = IconData(
    0xe903,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing security or access control settings.
  static const IconData accessControl = IconData(
    0xe904,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi Business Profile.
  static const IconData businessProfile = IconData(
    0xe905,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi AI assistant.
  static const IconData businessSetup = IconData(
    0xe906,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi digital wallet.
  static const IconData calculator = IconData(
    0xe907,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a MIH calendar.
  static const IconData calendar = IconData(
    0xe908,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing uncertainty or a "don't know" state.
  static const IconData iDontKnow = IconData(
    0xe909,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH logo, used for branding and identification.
  static const IconData mihLogo = IconData(
    0xe90a,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon reprosenting the the icons twisted circle, used for branding and identification.
  static const IconData mihRing = IconData(
    0xe90b,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi AI assistant, used for AI-related features and interactions.
  static const IconData mzansiAi = IconData(
    0xe90c,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi digital wallet, used for financial transactions and management.
  static const IconData mzansiWallet = IconData(
    0xe90d,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing notifications, used for alerts and updates within the MIH ecosystem.
  static const IconData notifications = IconData(
    0xe90e,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the patient manager, used for healthcare-related features and patient management.
  static const IconData patientManager = IconData(
    0xe90f,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the patient profile, used for healthcare-related features and patient information management.
  static const IconData patientProfile = IconData(
    0xe910,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the profile setup process, used for user onboarding and profile configuration.
  static const IconData profileSetup = IconData(
    0xe911,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );
}
