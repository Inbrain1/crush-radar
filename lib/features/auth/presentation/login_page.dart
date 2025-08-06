import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print("✉️ Email ingresado: '$email'");
    print("🔒 Password ingresado: '$password'");

    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref.read(authControllerProvider).login(
          email: email,
          password: password,
        );
      } catch (e) {
        print("⚠️ Error al hacer login: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⛔ Error al iniciar sesión: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                controller: _passwordController,
                label: 'Contraseña',
                isPassword: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Ingresar'),
              ),
              TextButton(
                onPressed: () {
                  context.go('/register');
                },
                child: const Text("¿No tienes cuenta? Regístrate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
