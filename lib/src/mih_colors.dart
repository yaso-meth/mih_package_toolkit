import 'package:flutter/material.dart';

/// A centralized design token class for the MIH Toolkit color palette.
///
/// [MihColors] provides static methods to retrieve consistent brand colors
/// that adapt based on the application's brightness (Dark Mode vs Light Mode).
///
/// Most methods accept an optional `darkMode` boolean. If not provided,
/// the color defaults to its **Dark Mode** variant.
class MihColors {
  /// Toggle flag for internal theme variations (e.g., Women4Change).
  bool women4Change = true;

  /// Returns the primary brand color.
  ///
  /// Dark: `0XFF3A4454` | Light: `0XFFbedcfe`
  static Color primary({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0XFF3A4454); // Original
      // return const Color(0XFF6641b2); // Women4change
    } else {
      return const Color(0XFFbedcfe); // Original
      // return const Color(0xFFE0D1FF); // Women4change
    }
  }

  /// Returns the secondary brand color.
  ///
  /// Dark: `0XFFbedcfe` | Light: `0XFF3A4454`
  static Color secondary({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0XFFbedcfe); // Original
      // return const Color(0xFFE0D1FF); // Women4change
    } else {
      return const Color(0XFF3A4454); // Original
      // return const Color(0XFF6641b2); // Women4change
    }
  }

  /// Returns an inverted version of the secondary color for high-contrast elements.
  static Color secondaryInverted({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0XFF412301); // Original
      // return const Color(0XFF1f2e00); // Women4change
    } else {
      return const Color(0XFFc5bbab); // Original
      // return const Color(0XFF99be4d); // Women4change
    }
  }

  /// Returns the highlight/accent color used to draw attention to specific UI elements.
  static Color highlight({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0XFF9bc7fa);
      // return const Color(0xFFC8AFFB); // Women4change
    } else {
      return const Color(0XFF354866);
      // return const Color(0XFF6641b2); // Women4change
    }
  }

  /// Returns a neutral grey shade.
  static Color grey({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0XFFc8c8c8);
    } else {
      return const Color(0XFF747474);
    }
  }

  /// Semantic green color typically used for success states or positive indicators.
  static Color green({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xff8ae290);
    } else {
      return const Color(0xFF41B349);
    }
  }

  /// Semantic red color typically used for error states, warnings, or deletions.
  static Color red({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xffD87E8B);
    } else {
      return const Color(0xffbb3d4f);
    }
  }

  /// Semantic pink color typically used for decorative or accent elements.
  static Color pink({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xffdaa2e9);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xffdaa2e9);
    }
  }

  /// Semantic orange color typically used for decorative or accent elements.
  static Color orange({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xffd69d7d);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xFFBD7145);
    }
  }

  /// Semantic yellow color typically used for decorative or accent elements.
  static Color yellow({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xfff4e467);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xffd4af37);
    }
  }

  /// Semantic bluish-purple color typically used for decorative or accent elements.
  static Color bluishPurple({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xff6e7dcc);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xFF5567C0);
    }
  }

  /// Semantic purple color typically used for decorative or accent elements.
  static Color purple({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xffb682e7);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xFF9857D4);
    }
  }

  /// Semantic gold color typically used for decorative or accent elements.
  static Color gold({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xFFD4AF37);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xffFFD700);
    }
  }

  /// Semantic silver color typically used for decorative or accent elements.
  static Color silver({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xffC0C0C0);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xFFA6A6A6);
    }
  }

  /// Semantic bronze color typically used for decorative or accent elements.
  static Color bronze({bool? darkMode}) {
    if (darkMode == true || darkMode == null) {
      return const Color(0xffB1560F);
    } else {
      // Add a different shade of pink for light mode
      return const Color(0xFFCD7F32);
    }
  }
}
