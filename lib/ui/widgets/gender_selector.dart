import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final Function(String) onChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  Color _getColorForGender(String gender, {bool background = true}) {
    switch (gender) {
      case 'Hombre':
        return background ? Colors.blue[400]! : Colors.blue[900]!;
      case 'Mujer':
        return background ? Colors.pinkAccent[100]! : Colors.pink;
      case 'No definido':
        return background ? Colors.grey[400]! : Colors.grey[800]!;
      case 'Otro':
        return background ? Colors.deepPurple[200]! : Colors.deepPurple[800]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['Hombre', 'Mujer', 'No definido', 'Otro'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Género',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((gender) {
            final bool isSelected = selectedGender == gender;

            final Color bgColor = isSelected
                ? _getColorForGender(gender, background: true)
                : Colors.grey[200]!;

            final Color textColor = isSelected
                ? Colors.white
                : _getColorForGender(gender, background: false);

            return GestureDetector(
              onTap: () => onChanged(gender),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getColorForGender(gender, background: false),
                    width: 2,
                  ),
                ),
                child: Text(
                  gender,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
