import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Provider
import 'providers/great_places.dart';

// Telas
import 'screens/login_screen.dart';
import 'screens/places_list_screen.dart';
import 'screens/place_form_screen.dart';

// Rotas
import 'utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicia Firebase (seu projeto: luluz)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

// App principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meu Diário de Viagens',

        // Tema simples para iniciantes
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Tela inicial → login
        home: const LoginScreen(),

        routes: {
          AppRoutes.placeList: (_) => PlacesListScreen(),
          AppRoutes.placeForm: (_) => const PlaceFormScreen(),
        },
      ),
    );
  }
}
