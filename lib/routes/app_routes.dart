import 'package:flutter/material.dart';
import 'package:useless_items/data/models/item_model/item_model.dart';
import 'package:useless_items/presentation/item_add_screen/item_add_screen.dart';
import 'package:useless_items/presentation/item_info_screen/item_info_screen.dart';
import 'package:useless_items/presentation/main_screen/main_screen.dart';
import 'package:useless_items/presentation/onboarding_screen/acquainted_screen.dart';
import 'package:useless_items/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:useless_items/presentation/settings_screen/settings_screen.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';

  static const String itemAddScreen = '/item_add_screen';

  static const String itemInfoScreen = '/item_info_screen';

  static const String mainScreen = '/main_screen';

  static const String settingsScreen = '/settings_screen';

  static const String acquaintedScreen = '/acquainted_screen';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: OnboardingScreen.builder,
        itemAddScreen: (context) {
          dynamic arguments = null;
          if (ModalRoute.of(context)?.settings.arguments is ItemModel) {
            arguments =
                (ModalRoute.of(context)?.settings.arguments as ItemModel);
          }
          return ItemAddScreen.builder(context, arguments);
        },
        itemInfoScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as ItemModel;
          return ItemInfoScreen.builder(context, arguments);
        },
        mainScreen: MainScreen.builder,
        settingsScreen: SettingsScreen.builder,
        acquaintedScreen: AcquaintedScreen.builder,
      };
}
