import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/crush_profile.dart';

class ProfileCard extends StatelessWidget {
  final CrushProfile profile;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = profile.imageUrl != null &&
        profile.imageUrl!.trim().isNotEmpty; // ✅ validación segura

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blueGrey.shade100,
            foregroundImage: hasImage ? NetworkImage(profile.imageUrl!) : null,
            onForegroundImageError: (_, __) {}, // Evita crash si la URL es inválida
            child: !hasImage
                ? Text(
              profile.name[0].toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )
                : null,
          ),
          title: Text(
            '${profile.name}, ${profile.age}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'A ${profile.distance} de ti',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          trailing: Icon(Icons.favorite_border, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
