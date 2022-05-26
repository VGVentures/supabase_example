// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_supabase/app/app.dart';

void main() {
  group('AppState', () {
    test('returns same object when no properties are passed', () {
      expect(AppState().copyWith(), AppState());
    });

    group('unauthenticated', () {
      test('has correct status', () {
        expect(
          AppState(),
          AppState(),
        );
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        expect(
          AppState(status: AppStatus.authenticated),
          AppState(status: AppStatus.authenticated),
        );
      });
    });
  });
}
