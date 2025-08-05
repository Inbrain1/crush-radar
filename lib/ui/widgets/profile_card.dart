// lib/ui/widgets/profile_card.dart
import 'package:flutter/material.dart';
import '../../data/models/crush_profile.dart';

class ProfileCard extends StatelessWidget {
  final CrushProfile profile;
  final VoidCallback onTap; // 👈 Añade esto

  const ProfileCard({super.key, required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        onTap: onTap, // 👈 Aquí se llama
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profile.imageUrl),
          radius: 25,
        ),
        title: Text('${profile.name}, ${profile.age}'),
        subtitle: Text('A ${profile.distance} de ti'),
        trailing: const Icon(Icons.favorite_border),
      ),
    );
  }
}