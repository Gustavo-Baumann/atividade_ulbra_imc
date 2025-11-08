import 'package:flutter/material.dart';
import 'components/tela_inicial.dart';
import 'components/tela_resultado.dart';
import 'components/tela_informacao.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      initialRoute: '/tela_inicial',
      navigatorObservers: [routeObserver],
      routes: {
        '/tela_inicial': (context) => const TelaInicial(),
        '/tela_resultado': (context) => const TelaResultado(),
        '/tela_informacao': (context) => const TelaInformacao()
      },
    );
  }
}