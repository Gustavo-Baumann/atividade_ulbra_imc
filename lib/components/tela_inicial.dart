import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc/components/teclado.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> with RouteAware{
  String? generoSelecionado;
  String peso = '80';
  String altura = '175';
  String? campoAtivo; 
  bool editandoPeso = false;  
  bool editandoAltura = false;

  void _resetarCampos() {
    setState(() {
      generoSelecionado = null;
      peso = '80';
      altura = '175';
      campoAtivo = null;
      editandoPeso = false;
      editandoAltura = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _resetarCampos();
  }

  @override
  void didPopNext() {
    _resetarCampos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      final observer = Navigator.of(context).widget.observers
          .whereType<RouteObserver>()
          .firstOrNull;
      observer?.subscribe(this as RouteAware, route);
    }
  }

  @override
  void dispose() {
    final observer = Navigator.of(context).widget.observers
        .whereType<RouteObserver>()
        .firstOrNull;
    observer?.unsubscribe(this as RouteAware);
    super.dispose();
  }

  void _abrirTeclado(String campo) {
    setState(() {
      campoAtivo = campo;
      if (campo == 'peso' && !editandoPeso) {
        peso = '';
        editandoPeso = true;
      }
      if (campo == 'altura' && !editandoAltura) {
        altura = '';
        editandoAltura = true;
      }
    });
  }

  void _fecharTeclado() {
    setState(() {
      campoAtivo = null;

      if (campoAtivo == 'peso' && peso.isEmpty) {
        peso = '80';
        editandoPeso = false;
      }
      if (campoAtivo == 'altura' && altura.isEmpty) {
        altura = '175';
        editandoAltura = false;
      }
    });
  }

  void _digito(String digit) {
    setState(() {
      if (campoAtivo == 'peso') {
        editandoPeso = true; 
        peso += digit;
      } else if (campoAtivo == 'altura') {
        editandoAltura = true;
        altura += digit;
      }
    });
  }

  void _apagar() {
    setState(() {
      if (campoAtivo == 'peso' && peso.isNotEmpty) {
        peso = peso.substring(0, peso.length - 1);
      } else if (campoAtivo == 'altura' && altura.isNotEmpty) {
        altura = altura.substring(0, altura.length - 1);
      }
    });
  }

  void _calcularIMC() {
    final p = double.tryParse(peso.replaceAll(',', '.')) ?? 0;
    final a = double.tryParse(altura) ?? 0;

    if (generoSelecionado != null && p > 0 && a > 0) {
      final imc = p / ((a * a) / 10000);
      final categoria = _getCategoriaIMC(imc);
      Navigator.pushNamed(
      context,
      '/tela_resultado',
      arguments: {
        'imc': imc.toStringAsFixed(1),
        'categoria': categoria,
        'peso': peso,
        'altura': altura,
        'genero': generoSelecionado,
      },
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente')),
      );
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.grey),
          onPressed: () => Navigator.pushNamed(context, '/tela_informacao'),
        ),
      ],
    ),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8), 

                const Text(
                  'Calculadora IMC',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                ),

                const SizedBox(height: 24), 

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBotaoGenero('homem', 'Homem', Icons.person, const Color(0xFFE3F2FD)),
                    const SizedBox(width: 30),
                    _buildBotaoGenero('mulher', 'Mulher', Icons.person_2, const Color(0xFFFCE4EC)),
                  ],
                ),

                const SizedBox(height: 32), 

                Row(
                  children: [
                    _buildCampoInput('Seu Peso (kg)', peso, () => _abrirTeclado('peso'), editandoPeso),
                    const SizedBox(width: 20),
                    _buildCampoInput('Sua Altura (cm)', altura, () => _abrirTeclado('altura'), editandoAltura),
                  ],
                ),

                const SizedBox(height: 32),

                Center(
                  child: ElevatedButton(
                    onPressed: _calcularIMC,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C4CC),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                      shadowColor: const Color(0xFF00C4CC).withOpacity(0.4),
                    ),
                    child: const Text('Calcular IMC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ),

                const SizedBox(height: 16), 
              ],
            ),
          ),
        ),

    AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: campoAtivo != null ? null : 0, 
      child: campoAtivo != null
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0xFF212121),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, -3)),
                ],
              ),
              child: TecladoNumerico(
                showDecimal: true,
                onDigit: _digito,
                onDelete: _apagar,
                onDone: _fecharTeclado,
              ),
            )
          : const SizedBox.shrink(),
    ),
      ],
    ),
  );
}

  Widget _buildBotaoGenero(String genero, String label, IconData icon, Color bgColor) {
    bool selecionado = generoSelecionado == genero;
    return GestureDetector(
      onTap: () => setState(() => generoSelecionado = genero),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: selecionado ? bgColor : Colors.grey[100],
              shape: BoxShape.circle,
              border: Border.all(
                color: selecionado ? (genero == 'homem' ? Colors.blue : Colors.pink) : Colors.transparent,
                width: 3,
              ),
            ),
            child: Icon(icon, size: 50, color: selecionado ? (genero == 'homem' ? Colors.blue : Colors.pink) : Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: selecionado ? FontWeight.bold : FontWeight.normal, color: selecionado ? Colors.black87 : Colors.grey[600])),
        ],
      ),
    );
  }

   Widget _buildCampoInput(String label, String value, VoidCallback onTap, bool editando) {
    final bool ePlaceholder = !editando && 
        ((label.contains('Peso') && value == '80') || 
         (label.contains('Altura') && value == '175'));

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: ePlaceholder ? Colors.grey[400]! : Colors.black87,
              ),
            ),
            Container(
              height: 2,
              color: campoAtivo == (label.contains('Peso') ? 'peso' : 'altura')
                  ? const Color(0xFF00C4CC)
                  : Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoriaIMC(double imc) {
    if (imc < 18.5) return 'Abaixo do peso';
    if (imc <= 24.9) return 'Peso Normal';
    if (imc <= 29.9) return 'Sobrepeso';
    return 'Obesidade';
  }
}