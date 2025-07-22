/// GENERATED CODE - DO NOT MODIFY BY HAND [gen_routes.dart]
import 'package:flutter/material.dart';

import 'package:pingpong_sample/views/home/home_view.dart';
import 'package:pingpong_sample/views/login/login_view.dart';
import 'package:pingpong_sample/routes/routes.g.dart';

Widget? createView(String route) {
  switch (route) {
    case Routes.home:
      return HomeView();
    case Routes.login:
      return LoginView();
    default:
      return null;
  }
}
