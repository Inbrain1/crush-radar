import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RadarLottieWidget extends StatelessWidget {
  const RadarLottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800.withOpacity(0.8),  // Fondo azul oscuro
              Colors.purple.shade700.withOpacity(0.6), // Degradado hacia morado
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: 250,
            height: 250,
            child: Lottie.asset(
              'assets/animations/radar_animation.json', // Ruta de la animación
              repeat: true,
              animate: true,
            ),
          ),
        ),
      ),
    );
  }
}