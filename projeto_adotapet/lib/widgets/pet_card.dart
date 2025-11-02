import 'package:flutter/material.dart';

class PetCard extends StatefulWidget {
  final String name;
  final String description;
  final String photoUrl;
  final Color pastelOrange;
  final Color pastelBlue;

  const PetCard({
    super.key,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.pastelOrange,
    required this.pastelBlue,
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
          // 📸 Foto grande
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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

          // ❤️ Ícones abaixo da foto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? widget.pastelOrange : Colors.grey[700],
                    size: 28,
                  ),
                  onPressed: () => setState(() => _liked = !_liked),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.pastelBlue,
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

          // 🐾 Legenda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(widget.description, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
