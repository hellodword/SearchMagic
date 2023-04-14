import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:universal_platform/universal_platform.dart';

void main() => runApp(const MainApp());

void gracefuleExit() {
  exit(0);
}

void desktopBindingExit() {
  if (UniversalPlatform.isLinux ||
      UniversalPlatform.isMacOS ||
      UniversalPlatform.isWindows) {
    // Ctrl + Q
    Keybinder.bind(
        Keybinding.from(
            {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyQ}),
        () => gracefuleExit());

    // Ctrl + W
    Keybinder.bind(
        Keybinding.from(
            {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyW}),
        () => gracefuleExit());

    // Alt + F4
    Keybinder.bind(
        Keybinding.from({LogicalKeyboardKey.altLeft, LogicalKeyboardKey.f4}),
        () => gracefuleExit());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();

  static _MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>()!;
}

class _MainAppState extends State<MainApp> {
  // https://stackoverflow.com/a/62607827
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    desktopBindingExit();

    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Search Magic',
      home: const MainScreen(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
      ],
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class TabData {
  String name;
  IconData icon;
  String base;
  bool startDate;
  bool endDate;

  TabData({
    required this.name,
    required this.icon,
    required this.base,
    required this.startDate,
    required this.endDate,
  });
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final tabs = [
      TabData(
        name: localizations.google,
        icon: MdiIcons.google,
        base: 'https://www.google.com',
        startDate: true,
        endDate: true,
      ),
      TabData(
        name: localizations.github,
        icon: MdiIcons.github,
        base: 'https://www.github.com',
        startDate: false,
        endDate: false,
      ),
    ];

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: tabs.length,
      // https://stackoverflow.com/a/52505320
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: scaffoldKey,
            body: TabBarView(
              children: [
                for (final tab in tabs)
                  Column(children: [
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: localizations.hintKeywordsToSearch,
                          ),
                          maxLines: 1,
                        )),
                    //TODO date picker
                    if (tab.startDate) Text(tab.name),
                    if (tab.endDate) Text(tab.name),
                    IconButton(
                      icon: Icon(tab.icon),
                      onPressed: () {
                        if (kDebugMode) {
                          print(tabs[DefaultTabController.of(context).index]
                              .base);
                        }
                      },
                    ),
                  ])
              ],
            ),
            floatingActionButton: Semantics(
              container: true,
              sortKey: const OrdinalSortKey(0),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey
                    : Colors.lightBlue,
                onPressed: () {},
                tooltip: localizations.search,
                child: const Icon(Icons.search),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const _DemoBottomAppBar(
              fabLocation: FloatingActionButtonLocation.centerDocked,
              shape: CircularNotchedRectangle(),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: TabBar(
                isScrollable: true,
                tabs: [
                  for (final tab in tabs)
                    Tooltip(message: tab.name, child: Tab(icon: Icon(tab.icon)))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// https://github.com/flutter/gallery/blob/b9a231cab02d4c5fcf72e2538a5bf591aa514f01/lib/demos/material/bottom_app_bar_demo.dart#L150
class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    required this.fabLocation,
    this.shape,
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Semantics(
      sortKey: const OrdinalSortKey(1),
      container: true,
      child: BottomAppBar(
        shape: shape,
        child: IconTheme(
          data: const IconThemeData(),
          child: Row(
            children: [
              IconButton(
                tooltip: localizations.settings,
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
              IconButton(
                tooltip: Theme.of(context).brightness == Brightness.dark
                    ? localizations.darkMode
                    : localizations.lightMode,
                icon: Icon(Theme.of(context).brightness == Brightness.dark
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  MainApp.of(context).changeTheme(
                      Theme.of(context).brightness == Brightness.dark
                          ? ThemeMode.light
                          : ThemeMode.dark);
                },
              ),
              const Spacer(),
              IconButton(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.pink[100]
                    : Colors.pink,
                tooltip: localizations.love,
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
