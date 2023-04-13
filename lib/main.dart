import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const SignUpApp());

void gracefuleExit() {
  exit(0);
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('zh'), // Chinese
      ],
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  final double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text(AppLocalizations.of(context)!.signUp,
              style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.firstName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.lastName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.userName),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: () {
              if (kDebugMode) {
                print(_firstNameTextController.text);
                print(_lastNameTextController.text);
                print(_usernameTextController.text);
              }
            },
            child: Text(AppLocalizations.of(context)!.signUp),
          ),
        ],
      ),
    );
  }
}
