import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _orientationController = TextEditingController();
  final _interestsController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _orientationController.dispose();
    _interestsController.dispose();
    super.dispose();
  }

  void _register() async {
    print("✅ Entrando a _register");

    if (_formKey.currentState!.validate()) {
      print("✅ Validación completada");

      try {
        await ref
            .read(authControllerProvider)
            .signUp(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              name: _nameController.text.trim(),
              gender: _genderController.text.trim(),
              age: int.parse(_ageController.text.trim()),
              location: _locationController.text.trim(),
              orientation: _orientationController.text.trim(),
              interests: _interestsController.text.trim().split(','),
            );

        // ✅ Redirigir al home después de registrar
        if (mounted) {
          context.go('/home');
        }
      } catch (e) {
        print("⚠️ Error al registrar: $e");
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("⛔ Error al registrar: $e")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Ingresa un email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Género'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
              ),
              TextFormField(
                controller: _orientationController,
                decoration: const InputDecoration(labelText: 'Orientación'),
              ),
              TextFormField(
                controller: _interestsController,
                decoration: const InputDecoration(
                  labelText: 'Gustos (separados por coma)',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Crear cuenta'),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text("¿Ya tienes cuenta? Inicia sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
