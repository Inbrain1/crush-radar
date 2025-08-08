import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/ui/widgets/radar_lottie_widget.dart';
import '../../core/providers/auth_state_provider.dart';
import '../widgets/profile_card.dart';
import '../../services/fake_profile_generator.dart';
import '../../data/models/crush_profile.dart';
import '../pages/chat_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<CrushProfile> nearbyProfiles = [];

  void _scanRadar() {
    setState(() {
      nearbyProfiles = FakeProfileGenerator.generateFakeProfiles(3);
    });
  }

  void _logout() {
    ref.read(authProvider).logout(); // ✅ Cierra sesión
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Porciaca'),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Hacemos el fondo del AppBar transparente
        elevation: 0,  // Quitamos la sombra del AppBar para que se mezcle con el fondo
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.9), // Fondo negro oscuro
              Colors.blue.shade900.withOpacity(0.9), // Gradiente azul oscuro
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radar animado
              const Expanded(
                flex: 3,
                child: RadarLottieWidget(), // Asegúrate de usar Lottie o Radar adecuado aquí
              ),

              const SizedBox(height: 20),

              // Botón de escanear alrededor con icono y texto
              ElevatedButton.icon(
                onPressed: _scanRadar,
                icon: const Icon(Icons.search, size: 30),
                label: const Text(
                  'Escanear alrededor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Color de fondo
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                ),
              ),

              const SizedBox(height: 20),

              // Lista de perfiles cercanos
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: nearbyProfiles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ProfileCard(
                        profile: nearbyProfiles[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                crushName: nearbyProfiles[index].name,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}