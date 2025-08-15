import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money/ui/widgets/custom_text_field.dart';
import '../../../ui/widgets/gender_selector.dart';
import 'register_step2.dart';

class RegisterStep1Page extends ConsumerStatefulWidget {
  const RegisterStep1Page({super.key});

  @override
  ConsumerState<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends ConsumerState<RegisterStep1Page> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedGender = '';
  DateTime? _birthdate;

  String? _genderError;
  String? _birthdateError;
  String? _formErrorMessage;

  void _selectBirthdate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 18); // mínimo 18 años sugerido
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (newDate != null) {
      setState(() {
        _birthdate = newDate;
        _birthdateError = null;
      });
    }
  }

  void _goToNextStep() {
    FocusScope.of(context).unfocus();

    final formState = _formKey.currentState;
    final isFormValid = formState?.validate() ?? false;

    // Validación de género
    final isGenderValid = _selectedGender.isNotEmpty;
    _genderError = isGenderValid ? null : 'Selecciona tu género';

    // Validación de fecha de nacimiento
    bool isBirthdateValid = false;
    if (_birthdate == null) {
      _birthdateError = 'Selecciona tu fecha de nacimiento';
    } else {
      final age = DateTime.now().year - _birthdate!.year;
      if (age < 13) {
        _birthdateError = 'Debes tener al menos 13 años';
      } else {
        isBirthdateValid = true;
        _birthdateError = null;
      }
    }

    // Forzar actualización visual
    setState(() {});

    if (!isFormValid || !isGenderValid || !isBirthdateValid) {
      setState(() {
        _formErrorMessage = '❗ Corrige los errores antes de continuar';
      });
      return;
    }

    // Limpia mensaje de error si todo está bien
    setState(() {
      _formErrorMessage = null;
    });

    // Navegar al siguiente paso
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterStep2Page(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          gender: _selectedGender,
          birthDate: _birthdate!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              // 🔴 BANNER DE ERROR
              if (_formErrorMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border(
                      left: BorderSide(color: Colors.red.shade400, width: 4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade400),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _formErrorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        color: Colors.red.shade300,
                        onPressed: () {
                          setState(() {
                            _formErrorMessage = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),

              // Campos del formulario
              CustomTextField(
                controller: _nameController,
                label: 'Nombre completo',
                validator: (value) =>
                value == null || value.trim().isEmpty ? 'Ingresa tu nombre' : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _emailController,
                label: 'Correo electrónico',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Ingresa tu correo';
                  if (!value.endsWith('@gmail.com')) {
                    return 'El correo debe terminar en @gmail.com';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _passwordController,
                isPassword: true,
                label: 'Contraseña',
                validator: (value) =>
                value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 20),
              GenderSelector(
                selectedGender: _selectedGender,
                onChanged: (gender) {
                  setState(() {
                    _selectedGender = gender;
                    _genderError = null;
                  });
                },
              ),
              if (_genderError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Text(
                    _genderError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Fecha de nacimiento'),
                subtitle: Text(
                  _birthdate == null
                      ? 'Seleccionar fecha'
                      : '${_birthdate!.day}/${_birthdate!.month}/${_birthdate!.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectBirthdate(context),
              ),
              if (_birthdateError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Text(
                    _birthdateError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.go('/login'),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Atrás"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _goToNextStep,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Siguiente"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
