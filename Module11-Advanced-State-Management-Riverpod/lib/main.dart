import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'app/theme.dart';

void main() {
  runApp(
    // ProviderScope wraps the entire app to enable Riverpod
    const ProviderScope(
      child: RiverpodHubApp(),
    ),
  );
}

class RiverpodHubApp extends ConsumerWidget {
  const RiverpodHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'RiverpodHub',
      theme: AppTheme.lightTheme,
      home: const AppScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}
