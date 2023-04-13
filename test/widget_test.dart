// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:search_magic/main.dart';

void main() {
  testWidgets('SignUpApp', (WidgetTester tester) async {
    await tester.pumpWidget(const SignUpApp());
    await tester.pumpAndSettle();

    await tester.binding.setLocale('en', 'US');
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsNWidgets(2));
    expect(find.text('Sign In'), findsNothing);

    await tester.binding.setLocale('zh', 'CN');
    await tester.pumpAndSettle();

    expect(find.text('登录'), findsNWidgets(2));
    expect(find.text('注销'), findsNothing);

    await tester.binding.setLocale('fr', 'FR');
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsNWidgets(2));
    expect(find.text('Sign In'), findsNothing);

    await tester.enterText(find.byType(TextField).first, 'hi');
    await tester.pump();

    expect(find.text('hi'), findsOneWidget);
  });
}
