import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_state_provider.dart';
import '../data/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: repo, ref: ref);
});

class AuthController {
  final AuthRepository authRepository;
  final Ref ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await authRepository.login(email: email, password: password);
    ref.read(authProvider).login(); // ✅ ahora con ChangeNotifier
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String gender,
    required int age,
    required String location,
    required String orientation,
    required List<String> interests,
  }) async {
    await authRepository.signUp(
      email: email,
      password: password,
      name: name,
      gender: gender,
      age: age,
      location: location,
      orientation: orientation,
      interests: interests,
    );
    ref.read(authProvider).login(); // ✅ login después de registro
  }

  Future<void> logout() async {
    await authRepository.logout();
    ref.read(authProvider).logout(); // ✅ cerrar sesión
  }
}