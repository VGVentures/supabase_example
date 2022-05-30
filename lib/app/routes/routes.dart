import 'package:flutter/material.dart';
import 'package:very_good_supabase/account/account.dart';
import 'package:very_good_supabase/app/bloc/app_bloc.dart';
import 'package:very_good_supabase/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];

    case AppStatus.authenticated:
      return [AccountPage.page()];
  }
}
