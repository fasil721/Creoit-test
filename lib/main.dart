import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/screens/home/home.dart';
import 'package:netflix_clone/services/tmdb_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => TmdbServices(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      );
}
