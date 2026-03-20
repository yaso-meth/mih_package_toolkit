import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';
import 'package:mih_package_toolkit/src/mih_package_tools.dart';

/// The core container for MIH application modules.
///
/// [MihPackage] acts as a high-level scaffold that manages a multi-page
/// interface. It synchronizes a set of toolbar icons ([packageTools]) with
/// a scrollable/swipeable body ([packageToolBodies]).
///
/// Features:
/// * **PageView Integration**: Seamlessly swipes between different tools.
/// * **Toolbar Sync**: Automatically updates the [MihPackageTools] state
///   when the page changes.
/// * **Double-Back Exit**: Built-in logic to prevent accidental app closure
///   on mobile devices.
/// * **Peak Animation**: A subtle visual hint that more pages exist to the right.
///
/// ### Example:
/// ```dart
/// MihPackage(
///   selectedBodyIndex: 0,
///   packageToolTitles: ['Home', 'Settings'],
///   packageTools: MihPackageTools(...),
///   packageToolBodies: [HomeWidget(), SettingsWidget()],
///   onIndexChange: (index) => print("Navigated to $index"),
///   packageActionButton: FloatingActionButton(...),
/// )
/// ```
class MihPackage extends StatefulWidget {
  /// The background  color of the package
  final Color? backgroundColor;

  /// The title  color of the package
  final Color? titleColor;

  /// The floating action button or primary action trigger for this package.
  final Widget packageActionButton;

  /// The titles displayed in the header for each corresponding page.
  final List<String> packageToolTitles;

  /// The toolbar widget containing icons that correspond to the [packageToolBodies] pages.
  final MihPackageTools packageTools;

  /// The list of main content widgets for each "page" of the package.
  final List<Widget> packageToolBodies;

  /// An optional drawer for actions.
  final Widget? actionDrawer;

  /// The initial page index to display.
  final int selectedBodyIndex;

  /// Callback triggered whenever the user swipes or navigates to a new page.
  final Function(int) onIndexChange;
  const MihPackage({
    super.key,
    this.backgroundColor,
    this.titleColor,
    required this.packageActionButton,
    required this.packageTools,
    required this.packageToolBodies,
    required this.packageToolTitles,
    this.actionDrawer,
    required this.selectedBodyIndex,
    required this.onIndexChange,
  });

  @override
  State<MihPackage> createState() => _MihPackageState();
}

class _MihPackageState extends State<MihPackage>
    with SingleTickerProviderStateMixin {
  /// The current active page index.
  late int _currentIndex;

  /// Controls the horizontal scrolling between [packageToolBodies] items.
  late PageController _pageController;
  late AnimationController _animationController;
  DateTime? lastPressedAt;

  void unfocusAll() {
    FocusScope.of(context).unfocus();
  }

  /// Triggers a "peek" animation on startup to show users that
  /// horizontal navigation is available.
  Future<void> _peakAnimation() async {
    int currentPage = _currentIndex;
    double peakOffset = _pageController.position.viewportDimension * 0.075;
    double currentOffset =
        _pageController.page! * _pageController.position.viewportDimension;
    int nextPage = currentPage + 1 < widget.packageToolBodies.length
        ? currentPage + 1
        : currentPage;
    if (nextPage != currentPage) {
      await Future.delayed(const Duration(milliseconds: 100));
      await _pageController.animateTo(
        currentOffset + peakOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      // await Future.delayed(const Duration(milliseconds: 100));
      await _pageController.animateTo(
        currentPage * _pageController.position.viewportDimension,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MihPackage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedBodyIndex != widget.selectedBodyIndex &&
        _currentIndex != widget.selectedBodyIndex) {
      _currentIndex = widget.selectedBodyIndex;
      _pageController.animateToPage(
        widget.selectedBodyIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedBodyIndex;
    _pageController = PageController(initialPage: widget.selectedBodyIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ModalRoute? currentRoute = ModalRoute.of(context);
        if (currentRoute != null) {
          currentRoute.animation?.addStatusListener((status) {
            if (status == AnimationStatus.completed && mounted) {
              _peakAnimation();
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: unfocusAll,
      child: Scaffold(
        backgroundColor: widget.backgroundColor ?? MihColors.primary(),
        drawer: widget.actionDrawer,
        body: SafeArea(
          bottom: false,
          minimum: EdgeInsets.only(bottom: 0),
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            //color: Colors.black,
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.packageActionButton,
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        // alignment: Alignment.center,
                        // alignment: Alignment.centerRight,
                        alignment: Alignment.centerLeft,
                        // color: Colors.black,
                        child: FittedBox(
                          child: Text(
                            widget.packageToolTitles[_currentIndex],
                            style: TextStyle(
                              color: widget.titleColor ?? MihColors.secondary(),
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    widget.packageTools,
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.packageToolBodies.length,
                    itemBuilder: (context, index) {
                      return widget.packageToolBodies[index];
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                      widget.onIndexChange(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
