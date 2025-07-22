part of 'themes.dart';

final ThemeData _lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  extensions: <ThemeExtension<dynamic>>[
    const Assets.light(),
    TextStyles.light(),
    const ComponentColors.light(),
  ],
);
