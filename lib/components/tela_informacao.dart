import 'package:flutter/material.dart';

class TelaInformacao extends StatelessWidget {
  const TelaInformacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Categorias de IMC',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoriaItem(
              valor: 'Menos de 18.5',
              descricao: 'Você está abaixo do peso.',
            ),
            SizedBox(height: 32),
            _CategoriaItem(
              valor: '18.5 até 24.9',
              descricao: 'Você está com peso normal.',
            ),
            SizedBox(height: 32),
            _CategoriaItem(
              valor: '25 até 29.9',
              descricao: 'Você está com sobrepeso.',
            ),
            SizedBox(height: 32),
            _CategoriaItem(
              valor: '30 ou mais',
              descricao: 'Obesidade.',
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriaItem extends StatelessWidget {
  final String valor;
  final String descricao;

  const _CategoriaItem({required this.valor, required this.descricao});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valor,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          descricao,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}