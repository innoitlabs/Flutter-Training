import 'package:flutter/material.dart';
import '../features/counter/counter_page.dart';
import '../features/todos/ui/todos_page.dart';
import '../features/auth/login_page.dart';
import '../shared/widgets/app_scaffold.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold();
  }
}

