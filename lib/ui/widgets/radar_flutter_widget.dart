// import 'package:flutter/material.dart';
// import 'package:flutter_radar/flutter_radar.dart';
//
// class RadarFlutterWidget extends StatelessWidget {
//   const RadarFlutterWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 250,
//         height: 250,
//         child: Container(
//           color: Colors.black, // Fondo si se requiere, o eliminarlo si no.
//           child: Radar(
//             size: 250,  // Tamaño del radar
//             borderWidth: 6,  // Ancho del borde
//             borderColor: Colors.green,  // Color del borde
//             pulseColor: Colors.green.withOpacity(0.4),  // Color del pulso
//             pulseDuration: const Duration(seconds: 2),  // Duración del pulso
//           ),
//         ),
//       ),
//     );
//   }
// }