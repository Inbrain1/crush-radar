import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    ref.read(authProvider).logout();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Hora, batería, etc. en blanco
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color(0xFF0D47A1), // Azul oscuro elegante
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botón cerrar sesión (ahora en la esquina)
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.exit_to_app, color: Colors.white),
                      tooltip: 'Cerrar sesión',
                      onPressed: _logout,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Radar animado
                  const Expanded(
                    flex: 3,
                    child: RadarLottieWidget(),
                  ),

                  const SizedBox(height: 20),

                  // Botón escanear
                  InkWell(
                    onTap: _scanRadar,
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6A11CB), // Morado eléctrico
                            Color(0xFF2575FC), // Azul eléctrico
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.radar, color: Colors.white, size: 28),
                            SizedBox(width: 12),
                            Text(
                              'Escanear alrededor',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Lista de perfiles cercanos
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: nearbyProfiles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
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
        ),
      ),
    );
  }
}
