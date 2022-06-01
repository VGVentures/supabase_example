// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_supabase/account/account.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(() async {
    await initializeSupabase();
  });

  group('AccountPage', () {
    test('has a page', () {
      expect(AccountPage.page(), isA<MaterialPage>());
    });

    testWidgets('renders a AccountView', (tester) async {
      await tester.pumpApp(
        const AccountPage(),
      );
      expect(find.byType(AccountView), findsOneWidget);
    });
  });
}
