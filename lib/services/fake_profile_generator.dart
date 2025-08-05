import 'dart:math';
import '../data/models/crush_profile.dart';

class FakeProfileGenerator {
  static final List<String> _names = [
    'Valentina',
    'Thiago',
    'Camila',
    'Gael',
    'Lucía',
    'Dylan',
    'Zoe',
    'Mateo',
    'Isabella',
    'Bruno',
    'Luna',
    'Joaquín'
  ];

  static final List<String> _images = [
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=12',
    'https://i.pravatar.cc/150?img=23',
    'https://i.pravatar.cc/150?img=30',
    'https://i.pravatar.cc/150?img=45',
    'https://i.pravatar.cc/150?img=60',
  ];

  static List<CrushProfile> generateFakeProfiles(int count) {
    final random = Random();
    return List.generate(count, (index) {
      return CrushProfile(
        name: _names[random.nextInt(_names.length)],
        age: 18 + random.nextInt(15),
        imageUrl: _images[random.nextInt(_images.length)],
        distance: '${random.nextInt(500)} m',
      );
    });
  }
}