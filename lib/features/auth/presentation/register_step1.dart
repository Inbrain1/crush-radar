  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void _selectBirthdate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 18); // por defecto 18 años
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (newDate != null) {
      setState(() {
        _birthdate = newDate;
      });
    }
  }

  void _goToNextStep() {
    if (_formKey.currentState!.validate() && _selectedGender.isNotEmpty && _birthdate != null) {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❗ Completa todos los campos antes de continuar")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator: (value) => value == null || value.isEmpty ? 'Ingresa tu nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) =>
                value == null || !value.contains('@') ? 'Correo inválido' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) =>
                value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 20),
              GenderSelector(
                selectedGender: _selectedGender,
                onChanged: (gender) {
                  setState(() => _selectedGender = gender);
                },
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _goToNextStep,
                child: const Text("Siguiente"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
