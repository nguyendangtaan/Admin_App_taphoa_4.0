import 'package:admin_app/controllers/MyMenuController.dart';
import 'package:admin_app/inner_screens/add_prod.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

import 'providers/dark_theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyMenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const MainScreen(),
              routes: {
                UploadProductForm.routeName: (context) =>
                const UploadProductForm(),
              }
          );
        },
      ),
    );
  }
}
