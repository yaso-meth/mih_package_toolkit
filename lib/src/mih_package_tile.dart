import 'dart:io' show Platform;
import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mih_package_toolkit/src/mih_button.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';
import 'package:mih_package_toolkit/src/mih_package_window.dart';
import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_single_child_scroll.dart';

/// A touchable "App Tile" used for launching modules within the MIH ecosystem.
///
/// [MihPackageTile] provides a standardized way to display application icons
/// and names. It includes sophisticated features like:
/// * **Biometric Ready**: Integrated with `local_auth` for secure access.
/// * **Video Hints**: Can display a help window with a YouTube video if [ytVideoID] is provided.
/// * **Responsive Scaling**: Uses [FittedBox] to ensure the [packageIcon] and [packageName]
///   fit perfectly within the specified [iconSize].
///
/// ### Example:
/// ```dart
/// MihPackageTile(
///   packageName: "Settings",
///   packageIcon: Icon(Icons.settings, size: 50),
///   iconSize: 100.0,
///   textColor: Colors.white,
///   onTap: () => print("Opening Settings..."),
///   ytVideoID: "dQw4w9WgXcQ", // Optional help video
/// )
/// ```
class MihPackageTile extends StatefulWidget {
  /// The name of the package displayed below the icon.
  final String packageName;

  // final String? ytVideoID;
  /// The icon of the package displayed above the name.
  final Widget packageIcon;

  /// The callback triggered when the tile is tapped.
  final void Function() onTap;

  /// The total height and width of the tile container.
  final double iconSize;

  /// The color of the [packageName] text.
  final Color textColor;

  /// Does the package require local auth check before opennings.
  final bool? authenticateUser;
  const MihPackageTile({
    super.key,
    required this.onTap,
    required this.packageName,
    // this.ytVideoID,
    required this.packageIcon,
    required this.iconSize,
    required this.textColor,
    this.authenticateUser,
  });

  @override
  State<MihPackageTile> createState() => _MihPackageTileState();
}

class _MihPackageTileState extends State<MihPackageTile> {
  final LocalAuthentication _auth = LocalAuthentication();

  // void displayHint() {
  //   if (widget.ytVideoID != null) {
  //     showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return MihPackageWindow(
  //           fullscreen: false,
  //           windowTitle: widget.packageName,
  //           // windowTools: const [],
  //           onWindowTapClose: () {
  //             Navigator.pop(context);
  //           },
  //           windowBody: SizedBox(),
  //           //MIHYTVideoPlayer(videoYTLink: widget.ytVideoID!),
  //         );
  //       },
  //     );
  //   }
  // }

  Future<bool> isUserAuthenticated() async {
    final bool canAuthWithBio = await _auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthWithBio || await _auth.isDeviceSupported();
    if (canAuthenticate) {
      try {
        final bool didBioAuth = await _auth.authenticate(
          localizedReason: "Authenticate to access ${widget.packageName}",
          options: const AuthenticationOptions(biometricOnly: false),
        );
        if (didBioAuth) {
          return true;
        } else {
          authErrorPopUp();
        }
      } catch (error) {
        authErrorPopUp();
      }
    } else {
      authErrorPopUp();
    }
    return false;
  }

  void authErrorPopUp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MihPackageWindow(
          fullscreen: false,
          windowTitle: null,
          onWindowTapClose: null,
          backgroundColor: MihColors.red(),
          windowBody: MihSingleChildScroll(
            scrollbarOn: true,
            child: Column(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 150,
                  color: MihColors.secondary(),
                ),
                Text(
                  "Biometric Authentication Required",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MihColors.secondary(),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    "Hi there! To jump into the ${widget.packageName} Package, you'll need to authenticate yourself with your devices biometrics, please set up biometric authentication (like fingerprint, face ID, pattern or pin) on your device first.\n\nIf you have already set up biometric authentication, press \"Authenticate now\" to try again or press \"Set Up Authentication\" to go to your device settings.",
                    style: TextStyle(
                      color: MihColors.secondary(),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.center,
                    children: [
                      MihButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        buttonColor: MihColors.secondary(),
                        width: 300,
                        child: Text(
                          "Dismiss",
                          style: TextStyle(
                            color: MihColors.primary(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MihButton(
                        onPressed: () {
                          AppSettings.openAppSettings(
                            type: AppSettingsType.security,
                          );
                          Navigator.of(context).pop();
                        },
                        buttonColor: MihColors.primary(),
                        width: 300,
                        child: Text(
                          "Set Up Authentication",
                          style: TextStyle(
                            color: MihColors.secondary(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MihButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          authenticateUser();
                        },
                        buttonColor: MihColors.green(),
                        width: 300,
                        child: Text(
                          "Authenticate Now",
                          style: TextStyle(
                            color: MihColors.primary(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> authenticateUser() async {
    if (widget.authenticateUser != null &&
        widget.authenticateUser! &&
        !kIsWeb &&
        !Platform.isLinux) {
      if (await isUserAuthenticated()) {
        widget.onTap();
      }
    } else {
      widget.onTap();
    }
    // widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      // color: Colors.black,
      width: widget.iconSize,
      height: widget.iconSize,
      child: GestureDetector(
        onTap: () async {
          authenticateUser();
        },
        onLongPress: null, // Do this later
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.center,
                child: widget.packageIcon,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              // Add a little padding for better visual spacing
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: FittedBox(
                child: Text(
                  widget.packageName,
                  textAlign: TextAlign.center, // This centers the text content
                  maxLines: 1, // Allow up to 2 lines to prevent clipping
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
