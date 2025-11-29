 

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'new_entry_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seu Diário")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewEntryPage() as Widget),
          );
        },
      ),
      body: FutureBuilder<String>(
        future: ApiService().getQuote(),
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              snapshot.hasData ? snapshot.data! : "Carregando frase...",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
