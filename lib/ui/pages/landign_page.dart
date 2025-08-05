// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../core/providers/auth_state_provider.dart';
// import '../../features/auth/presentation/login_page.dart';
// import 'home_page.dart';
//
// class LandingPage extends ConsumerWidget {
//   const LandingPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authAsync = ref.watch(authStateChangesProvider);
//
//     return authAsync.when(
//       data: (user) {
//         if (user == null) {
//           return const LoginPage();
//         } else {
//           return const HomePage();
//         }
//       },
//       loading: () => const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       ),
//       error: (e, _) => Scaffold(
//         body: Center(child: Text('Error: $e')),
//       ),
//     );
//   }
// }