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

  /// An icon representing a hyperlink or external link.
  static const IconData link = IconData(
    0xe938,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing MIH-specific access controls.
  static const IconData mihAccessControls = IconData(
    0xe926,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing general access controls.
  static const IconData accessControls = IconData(
    0xe937,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing adding a business.
  static const IconData addBusiness = IconData(
    0xe900,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing adding a user.
  static const IconData addUser = IconData(
    0xe901,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Apple Music.
  static const IconData appleMusic = IconData(
    0xe902,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a generic business entity.
  static const IconData business = IconData(
    0xe903,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a calculator.
  static const IconData calculator = IconData(
    0xe904,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a calendar.
  static const IconData calendar = IconData(
    0xe905,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Discord.
  static const IconData discord = IconData(
    0xe906,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a doctor or medical professional.
  static const IconData doctor = IconData(
    0xe907,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Facebook.
  static const IconData facebook = IconData(
    0xe908,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Git/version control.
  static const IconData git = IconData(
    0xe909,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing an "I don't know" or help state.
  static const IconData iDontKnow = IconData(
    0xe90a,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing information.
  static const IconData info = IconData(
    0xe90b,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Instagram.
  static const IconData instagram = IconData(
    0xe90c,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing LinkedIn.
  static const IconData linkedin = IconData(
    0xe90d,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Loolio.
  static const IconData loolio = IconData(
    0xe90e,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Medium.
  static const IconData medium = IconData(
    0xe90f,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Messenger.
  static const IconData messenger = IconData(
    0xe910,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a minesweeper game.
  static const IconData minesweeper = IconData(
    0xe911,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Ollama.
  static const IconData ollama = IconData(
    0xe912,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a patient file or record.
  static const IconData patientFile = IconData(
    0xe913,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Patreon.
  static const IconData patreon = IconData(
    0xe914,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Pinterest.
  static const IconData pinterest = IconData(
    0xe915,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Reddit.
  static const IconData reddit = IconData(
    0xe916,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Snapchat.
  static const IconData snapchat = IconData(
    0xe917,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Spotify.
  static const IconData spotify = IconData(
    0xe918,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Substack.
  static const IconData substack = IconData(
    0xe919,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Telegram.
  static const IconData telegram = IconData(
    0xe91a,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Threads.
  static const IconData threads = IconData(
    0xe91b,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing TikTok.
  static const IconData tiktok = IconData(
    0xe91c,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing Twitch.
  static const IconData twitch = IconData(
    0xe91d,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a general user.
  static const IconData user = IconData(
    0xe91e,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a financial wallet.
  static const IconData wallet = IconData(
    0xe91f,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing WeChat.
  static const IconData wechat = IconData(
    0xe920,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing WhatsApp.
  static const IconData whatsapp = IconData(
    0xe921,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing X (formerly Twitter).
  static const IconData x = IconData(
    0xe922,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing YouTube Music.
  static const IconData youtubeMusic = IconData(
    0xe923,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing YouTube.
  static const IconData youtube = IconData(
    0xe924,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the "About MIH" information section.
  static const IconData aboutMih = IconData(
    0xe925,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a business profile.
  static const IconData businessProfile = IconData(
    0xe927,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the business setup process.
  static const IconData businessSetup = IconData(
    0xe928,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH-specific calculator.
  static const IconData mihCalculator = IconData(
    0xe929,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH-specific calendar.
  static const IconData mihCalendar = IconData(
    0xe92a,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH-specific "don't know" state.
  static const IconData mihIDontKnow = IconData(
    0xe92b,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH official logo.
  static const IconData mihLogo = IconData(
    0xe92c,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH-specific minesweeper tool.
  static const IconData mihMinesweeper = IconData(
    0xe92d,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the MIH ring branding element.
  static const IconData mihRing = IconData(
    0xe92e,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi AI assistant.
  static const IconData mzansiAi = IconData(
    0xe92f,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi Directory service.
  static const IconData mzansiDirectory = IconData(
    0xe930,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the Mzansi digital wallet.
  static const IconData mzansiWallet = IconData(
    0xe931,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing notifications.
  static const IconData notifications = IconData(
    0xe932,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the patient manager system.
  static const IconData patientManager = IconData(
    0xe933,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a patient profile.
  static const IconData patientProfile = IconData(
    0xe934,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing a personal user profile.
  static const IconData personalProfile = IconData(
    0xe935,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );

  /// An icon representing the profile onboarding/setup process.
  static const IconData profileSetup = IconData(
    0xe936,
    fontFamily: _mihFontFam,
    fontPackage: _mihFontPkg,
  );
}
