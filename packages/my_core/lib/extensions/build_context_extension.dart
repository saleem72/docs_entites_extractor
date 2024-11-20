//

import 'package:flutter/material.dart';

const double kMobileMaxSize = 600;

const double kTabletMaxSize = 1200;

extension BuildContextDetails on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);
  double get navBarHeight => kToolbarHeight;
  Orientation get orientation => mediaQuery.orientation;
  TextDirection get directionality => Directionality.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isMobile => mediaQuery.size.width < kMobileMaxSize;

  bool get isArabic => directionality == TextDirection.rtl;

  bool get isTablet =>
      mediaQuery.size.width >= kMobileMaxSize &&
      mediaQuery.size.width <= kTabletMaxSize;

  bool get isDesktop => mediaQuery.size.width > kTabletMaxSize;

  RouteSettings? get currentRoute => ModalRoute.of(this)?.settings;
}
