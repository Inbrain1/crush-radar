import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/controller/auth_controller.dart'; // ✅ asegúrate de importar bien

class RegisterStep2Page extends ConsumerStatefulWidget {
  final String name;
  final String email;
  final String password;
  final String gender;
  final DateTime birthDate;

  const RegisterStep2Page({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.birthDate,
  });

  @override
  ConsumerState<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends ConsumerState<RegisterStep2Page> {
  final List<String> selectedInterests = [];

  final List<Map<String, dynamic>> interests = [
    {"title": "Leer", "image": "assets/interests/leer.jpg", "color": Colors.indigo},
    {"title": "Música", "image": "assets/interests/musica.jpg", "color": Colors.deepPurple},
    {"title": "Películas", "image": "assets/interests/peliculas.jpg", "color": Colors.teal},
    {"title": "Viajar", "image": "assets/interests/vieaje.jpg", "color": Colors.orange},
    {"title": "Videojuegos", "image": "assets/interests/videojuegos.jpg", "color": Colors.redAccent},
    {"title": "Fitness", "image": "assets/interests/fittness.jpg", "color": Colors.green},
    {"title": "Comida", "image": "assets/interests/comida.jpg", "color": Colors.brown},
    {"title": "Animales", "image": "assets/interests/anumales.jpg", "color": Colors.blueGrey},
  ];

  void _toggleInterest(String title) {
    setState(() {
      if (selectedInterests.contains(title)) {
        selectedInterests.remove(title);
      } else {
        selectedInterests.add(title);
      }
    });
  }

  Future<void> _registerUser(WidgetRef ref) async {
    try {
      await ref.read(authControllerProvider).signUp(
        email: widget.email,
        password: widget.password,
        name: widget.name,
        gender: widget.gender,
        age: DateTime.now().year - widget.birthDate.year,
        location: "No especificado",
        orientation: "No especificado",
        interests: selectedInterests,
      );

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⛔ Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('¿Qué te gusta?')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selecciona tus intereses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: interests.map((item) {
                  final String title = item["title"];
                  final bool selected = selectedInterests.contains(title);
                  final Color color = item["color"];

                  return GestureDetector(
                    onTap: () => _toggleInterest(title),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item["image"],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: selected ? color.withOpacity(0.6) : Colors.black26,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(16),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            width: double.infinity,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
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
                  child: Consumer(
                    builder: (context, ref, _) {
                      return ElevatedButton.icon(
                        onPressed: () => _registerUser(ref),
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Continuar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}