import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/widgets/auth_state_notifier.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier();
});