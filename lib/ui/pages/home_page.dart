import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/controller/auth_controller.dart';
import '../../core/providers/auth_state_provider.dart';
import '../widgets/radar.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(flex: 3, child: RadarWidget()),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _scanRadar,
            icon: const Icon(Icons.radar),
            label: const Text('Escanear alrededor'),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: nearbyProfiles.length,
              itemBuilder: (context, index) {
                return ProfileCard(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}