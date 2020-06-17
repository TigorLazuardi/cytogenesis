import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Handle status bar bullshit. Source: https://github.com/flutter/flutter/issues/4518#issuecomment-480115134
class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _defaultElevation = 4.0;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness =
        appBarTheme.brightness ?? themeData.primaryColorBrightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: appBarTheme.color ?? themeData.primaryColor,
          elevation: appBarTheme.elevation ?? _defaultElevation,
          child: Semantics(
            explicitChildNodes: true,
            child: Container(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

// Remove appbar and elevation for fullscreen app base material app
class Null extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness = appBarTheme.brightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: appBarTheme.color,
          elevation: 0,
          child: Semantics(
            explicitChildNodes: true,
            child: Container(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class Result<T, V> {
  T var1;
  V var2;
  Result(this.var1, this.var2);
}
