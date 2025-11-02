import 'package:flutter/material.dart';
import '../widgets/pet_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  final List<Map<String, String>> _mockPets = const [
    {
      'name': 'Andrews',
      'photo': 'https://i.imgur.com/I1Zsu1m.jpeg',
      'description': 'Carinhoso e brincalhão, ama correr no parque.',
    },
    {
      'name': 'Aniquilador',
      'photo': 'https://i.imgur.com/TsMeC8m.jpeg',
      'description': 'Muito obediente e protetor, ideal para família.',
    },
    {
      'name': 'Melzinha',
      'photo': 'https://i.imgur.com/ZJUNyTh.png',
      'description': 'Doce e calma, se dá bem com outros pets.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const pastelOrange = Color(0xFFFFB74D);
    const pastelBlue = Color(0xFF64B5F6);

    return ListView.builder(
      itemCount: _mockPets.length,
      itemBuilder: (context, i) {
        final pet = _mockPets[i];
        return PetCard(
          name: pet['name']!,
          description: pet['description']!,
          photoUrl: pet['photo']!,
          pastelOrange: pastelOrange,
          pastelBlue: pastelBlue,
        );
      },
    );
  }
}
