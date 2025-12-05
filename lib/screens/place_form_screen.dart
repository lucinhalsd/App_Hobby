import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File image) {
    _pickedImage = image;
  }

  Future<void> _savePlace() async {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    await Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nova Viagem")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Título"),
              controller: _titleController,
            ),
            const SizedBox(height: 10),
            ImageInput(_selectImage),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePlace,
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}
