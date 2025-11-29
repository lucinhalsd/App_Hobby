

import 'dart:io';

import 'package:app_hobby_application_1/services/firestore_service.dart';
import 'package:app_hobby_application_1/services/image_picket_service.dart';
import 'package:flutter/material.dart';

class NewEntryPage extends StatefulWidget {
  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final titleCtrl = TextEditingController();
  final textCtrl = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova Entrada")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: "Título")),
            TextField(controller: textCtrl, decoration: InputDecoration(labelText: "Texto")),
            SizedBox(height: 10),
          
            ElevatedButton(
              child: Text("Adicionar Imagem"),
              onPressed: () async {
                imagePath = await ImagePickerService().pickImage();
                setState(() {});
              },
            ),
            if (imagePath != null)
             Image.file(File(imagePath!), height: 150),
                // Lógica para salvar a nova entrada
                 ElevatedButton(
              child: Text("Salvar"),
              onPressed: () {
                FirestoreService().saveEntry(
                  titleCtrl.text,
                  textCtrl.text,
                  imagePath,
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}