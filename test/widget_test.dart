// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:search_magic/main.dart';

void main() {
  testWidgets('MainApp', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    await tester.binding.setLocale('en', 'US');
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsNothing);
    expect(find.byTooltip('Google'), findsOneWidget);

    await tester.binding.setLocale('zh', 'CN');
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(find.byTooltip('谷歌'), findsOneWidget);

    await tester.binding.setLocale('fr', 'FR');
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(find.byTooltip('Google'), findsOneWidget);

    // await tester.enterText(find.byType(TextField).first, 'hi');
    // await tester.pump();

    // expect(find.text('hi'), findsOneWidget);
  });
}
