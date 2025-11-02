import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
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
      'sex': 'Macho',
    },
    {
      'name': 'Aniquilador',
      'photo': 'https://i.imgur.com/TsMeC8m.jpeg',
      'description': 'Muito obediente e protetor, ideal para família.',
      'shelter': 'Amigos dos Animais',
      'age': '3 anos',
      'breed': 'Pitbull',
      'size': 'Grande',
      'sex': 'Macho',
    },
    {
      'name': 'Melzinha',
      'photo': 'https://i.imgur.com/ZJUNyTh.png',
      'description': 'Doce e calma, se dá bem com outros pets.',
      'shelter': 'Lar Esperança',
      'age': '1 ano',
      'breed': 'Poodle',
      'size': 'Pequeno',
      'sex': 'Fêmea',
    },
  ];

  String _search = '';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => debugPrint('STATUS: $val'),
        onError: (val) => debugPrint('ERRO: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'pt_BR',
          onResult: (val) {
            setState(() {
              _search = val.recognizedWords;
              _searchController.text = _search;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

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
          pet['size']!.toLowerCase().contains(query) ||
          pet['sex']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: pastelBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SafeArea(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar pets, abrigo ou raça...',
                  hintStyle: const TextStyle(color: Colors.black54),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF64B5F6)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: const Color(0xFF64B5F6),
                    ),
                    onPressed: _listen,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onChanged: (value) => setState(() => _search = value),
              ),
            ),
          ),
        ),
      ),

      // 🐾 FEED
      body: ListView.builder(
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
            sex: pet['sex']!,
          );
        },
      ),
    );
  }
}
