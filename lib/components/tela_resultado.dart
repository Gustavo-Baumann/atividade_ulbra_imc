import 'package:flutter/material.dart';

class TelaResultado extends StatelessWidget {
  const TelaResultado({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? rawArgs = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic> args = rawArgs as Map<String, dynamic>;
    
    final String imc = args['imc']!;
    final String categoria = args['categoria']!;
    final String peso = args['peso'] ?? '80';
    final String altura = args['altura'] ?? '175';
    final String genero = args['genero'] ?? 'homem';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.grey),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.grey),
          onPressed: () => Navigator.pushNamed(context, '/tela_informacao'),
        ),
      ],
),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            const Text(
              'Resultado IMC',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDisplayGenero('homem', Icons.person, const Color(0xFFE3F2FD), genero),
                const SizedBox(width: 30),
                _buildDisplayGenero('mulher', Icons.person_2, const Color(0xFFFCE4EC), genero),
              ],
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                _buildInputLeitura('Seu Peso (kg)', peso),
                const SizedBox(width: 20),
                _buildInputLeitura('Sua Altura (cm)', altura),
              ],
            ),

            const SizedBox(height: 50),

            Column(
              children: [
                const Text(
                  'Seu IMC',
                  style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  imc,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  categoria,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, 
                    foregroundColor: const Color(0xFF00C4CC), 
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xFF00C4CC), width: 2),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Calcular IMC novamente',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLeitura(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Container(height: 2, color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildDisplayGenero(String generoAtual, IconData icon, Color bgColor, String? generoSelecionado) {
    final bool isSelecionado = generoSelecionado == generoAtual;
    final Color corTexto = isSelecionado
        ? (generoAtual == 'homem' ? Colors.blue : Colors.pink)
        : Colors.grey[600]!;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: isSelecionado
                ? Border.all(
                    color: generoAtual == 'homem' ? Colors.blue : Colors.pink,
                    width: 3,
                  )
                : null,
          ),
          child: Icon(
            icon,
            size: 50,
            color: corTexto,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          generoAtual == 'homem' ? 'Homem' : 'Mulher',
          style: TextStyle(
            fontSize: 16,
            color: corTexto,
            fontWeight: isSelecionado ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}