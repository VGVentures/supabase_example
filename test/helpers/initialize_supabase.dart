import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_local_storage_mock.dart';

var _isInitialized = false;

Future<void> initializeSupabase() async {
  if (_isInitialized) return;
  await Supabase.initialize(
    url: '',
    anonKey: '',
    localStorage: MockLocalStorage(),
  );
  _isInitialized = true;
}
