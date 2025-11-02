import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PetCard extends StatefulWidget {
  final String name;
  final String description;
  final String photoUrl;
  final Color pastelOrange;
  final Color pastelBlue;
  final String shelterName; // órgão doador
  final String age;
  final String breed;
  final String size;

  const PetCard({
    super.key,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.pastelOrange,
    required this.pastelBlue,
    this.shelterName = "Abrigo São Cão",
    this.age = "2 anos",
    this.breed = "SRD",
    this.size = "Médio",
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🏷️ ÓRGÃO DOADOR (Topo do Card)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.home_work, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.shelterName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),

          // 📸 FOTO GRANDE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
            child: Image.network(
              widget.photoUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.pets, size: 60, color: Colors.grey),
              ),
            ),
          ),

          // ❤️ ÍCONES DE INTERAÇÃO (CURTIR + COMPARTILHAR + ADOTAR)
          // ❤️ ÍCONES DE INTERAÇÃO (CURTIR + COMPARTILHAR + ADOTAR)
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          IconButton(
            icon: Icon(
              _liked ? Icons.favorite : Icons.favorite_border,
              color: _liked ? widget.pastelOrange : Colors.grey[700],
              size: 28,
            ),
            onPressed: () => setState(() => _liked = !_liked),
          ),
          IconButton(
            icon: Icon(Icons.share, color: widget.pastelOrange, size: 26),
            onPressed: () {
              Share.share(
                '🐾 Olha só o ${widget.name}! ${widget.description}\nAdote também no AdotaPet 💕',
              );
            },
          ),
        ],
      ),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.pastelOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Solicitação de adoção enviada para ${widget.name}!')),
          );
        },
        icon: const Icon(Icons.pets, color: Colors.white, size: 18),
        label: const Text('Adotar', style: TextStyle(color: Colors.white)),
      ),
    ],
  ),
),

          // 🐾 NOME E DESCRIÇÃO ABAIXO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(widget.description, style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 10),

                // 🏷️ CATEGORIAS (idade, raça, tamanho)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildChip('Idade: ${widget.age}', widget.pastelBlue),
                    _buildChip('Raça: ${widget.breed}', widget.pastelOrange),
                    _buildChip('Tamanho: ${widget.size}', Colors.teal),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
