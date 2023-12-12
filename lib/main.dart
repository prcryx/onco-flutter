import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/app_constants.dart';
import 'package:onco_connect/common/bindings/bindings.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';
import 'package:onco_connect/presentation/theme/color_theme/app_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/app_text_theme.dart';
import 'package:onco_connect/presentation/widgets/loader_widget.dart';

import 'common/utils/global_navigator.dart';
import 'common/utils/scroll_behavior.dart';
import 'firebase_options.dart';
import 'presentation/app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: mtAppGlobalKey);
  static GlobalKey mtAppKey = GlobalKey();
  static GlobalKey mtAppGlobalKey = GlobalKey();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorStateGlobalKey =
      GlobalNavigator.navigatorStateGlobalKey;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ScrollConfiguration(
        behavior: MyBehavior(),
        child: _appBuilder(context),
      ),
    );
  }

  GetMaterialApp _appBuilder(context) => GetMaterialApp(
        navigatorKey: _navigatorStateGlobalKey,
        key: MyApp.mtAppKey,
        title: AppConstants.appName,
        themeMode: ThemeMode.light,
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            lightTheme,
            textTheme,
          ],
        ),
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        initialRoute: RouteName.splashScreen,
        unknownRoute: AppRoutes.unknownRoute(),
        getPages: AppRoutes.appRoutes(),
        builder: (context, child) {
          return LoaderWidget(
            child: child!,
          );
        },
      );
}
