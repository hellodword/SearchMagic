import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    desktopBindingExit();

    return const MaterialApp(
      title: "Search Magic",
      home: MainScreen(),
      // routes: {
      //   '/': (context) => const MainScreen(),
      // },
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('zh'), // Chinese
      ],
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final tabs = [
      localizations.google,
      localizations.github,
    ];

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[200],
        body: TabBarView(
          children: [for (final tab in tabs) Center(child: Text(tab))],
        ),
        floatingActionButton: Semantics(
          container: true,
          sortKey: const OrdinalSortKey(0),
          child: FloatingActionButton(
            onPressed: () {},
            tooltip: localizations.search,
            child: const Icon(Icons.search),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const _DemoBottomAppBar(
          fabLocation: FloatingActionButtonLocation.centerDocked,
          shape: CircularNotchedRectangle(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            isScrollable: true,
            tabs: [for (final tab in tabs) Tab(text: tab)],
          ),
        ),
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
          data: const IconThemeData(color: Colors.lightBlue),
          child: Row(
            children: [
              IconButton(
                tooltip: localizations.settings,
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
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
