import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RadarLottieWidget extends StatelessWidget {
  const RadarLottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}