// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_supabase/app/app.dart';

void main() {
  group('AppEvent', () {
    group('AppAuthenticated', () {
      test('supports value comparisons', () {
        expect(
          AppAuthenticated(),
          AppAuthenticated(),
        );
      });
    });

    group('AppLogoutRequested', () {
      test('supports value comparisons', () {
        expect(
          AppLogoutRequested(),
          AppLogoutRequested(),
        );
      });
    });
  });
}
