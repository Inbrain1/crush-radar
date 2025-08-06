import 'package:flutter/material.dart';

class RegisterStep2Page extends StatefulWidget {
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
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  final List<String> selectedInterests = [];

  final List<Map<String, String>> interests = [
    {"title": "Leer", "image": "assets/interests/book.png"},
    {"title": "Música", "image": "assets/interests/music.png"},
    {"title": "Películas", "image": "assets/interests/movie.png"},
    {"title": "Viajar", "image": "assets/interests/travel.png"},
    {"title": "Videojuegos", "image": "assets/interests/gaming.png"},
    {"title": "Fitness", "image": "assets/interests/fitness.png"},
    {"title": "Comida", "image": "assets/interests/food.png"},
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

  void _goToNextStep() {
    print("✅ Intereses seleccionados: $selectedInterests");

    // Aquí deberías navegar al siguiente paso o registrar al usuario
    // Navigator.push(...) o context.go('/register-step3')
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
                  final selected = selectedInterests.contains(item["title"]);
                  return GestureDetector(
                    onTap: () => _toggleInterest(item["title"]!),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected ? Colors.pink.shade100 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected ? Colors.pink : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item["image"]!, height: 60),
                          const SizedBox(height: 10),
                          Text(
                            item["title"]!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selected ? Colors.pink : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _goToNextStep,
              child: const Text("Siguiente"),
            )
          ],
        ),
      ),
    );
  }
}
