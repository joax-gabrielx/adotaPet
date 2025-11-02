import 'package:flutter/material.dart';
import '../widgets/pet_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final List<Map<String, String>> _allPets = [
    {
      'name': 'Andrews',
      'photo': 'https://i.imgur.com/I1Zsu1m.jpeg',
      'description': 'Carinhoso e brincalhão, ama correr no parque.',
      'shelter': 'Abrigo São Cão',
      'age': '2 anos',
      'breed': 'SRD',
      'size': 'Médio',
    },
    {
      'name': 'Aniquilador',
      'photo': 'https://i.imgur.com/TsMeC8m.jpeg',
      'description': 'Muito obediente e protetor, ideal para família.',
      'shelter': 'Amigos dos Animais',
      'age': '3 anos',
      'breed': 'Pitbull',
      'size': 'Grande',
    },
    {
      'name': 'Melzinha',
      'photo': 'https://i.imgur.com/ZJUNyTh.png',
      'description': 'Doce e calma, se dá bem com outros pets.',
      'shelter': 'Lar Esperança',
      'age': '1 ano',
      'breed': 'Poodle',
      'size': 'Pequeno',
    },
  ];

  String _search = '';

  @override
  Widget build(BuildContext context) {
    const pastelOrange = Color(0xFFFFB74D);
    const pastelBlue = Color(0xFF64B5F6);

    final filteredPets = _allPets.where((pet) {
      final query = _search.toLowerCase();
      return pet['name']!.toLowerCase().contains(query) ||
          pet['shelter']!.toLowerCase().contains(query) ||
          pet['breed']!.toLowerCase().contains(query) ||
          pet['age']!.toLowerCase().contains(query) ||
          pet['size']!.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        // 🔍 BARRA DE PESQUISA
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por nome, abrigo, raça, idade ou tamanho...',
              prefixIcon: const Icon(Icons.search, color: pastelBlue),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: pastelBlue),
              ),
            ),
            onChanged: (value) => setState(() => _search = value),
          ),
        ),

        // 🐾 FEED DE PETS
        Expanded(
          child: ListView.builder(
            itemCount: filteredPets.length,
            itemBuilder: (context, i) {
              final pet = filteredPets[i];
              return PetCard(
                name: pet['name']!,
                description: pet['description']!,
                photoUrl: pet['photo']!,
                pastelOrange: pastelOrange,
                pastelBlue: pastelBlue,
                shelterName: pet['shelter']!,
                age: pet['age']!,
                breed: pet['breed']!,
                size: pet['size']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
