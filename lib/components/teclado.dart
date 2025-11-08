import 'package:flutter/material.dart';

class TecladoNumerico extends StatelessWidget {
  final Function(String) onDigit;
  final VoidCallback onDelete;
  final VoidCallback onDone;
  final bool showDecimal;

  const TecladoNumerico({
    super.key,
    required this.onDigit,
    required this.onDelete,
    required this.onDone,
    this.showDecimal = true,
  });

  static const double _spacing = 5.0;

 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row(['1', '2', '3']),
          _row(['4', '5', '6']),
          _row(['7', '8', '9']),
          _row(['.', '0', 'backspace']),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onDone,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C4CC),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('OK', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(List<String> keys) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _spacing), 
      child: Row(
        children: keys.map((k) {
          if (k == 'backspace') {
            return _key(Icon(Icons.backspace_outlined, color: Colors.white70, size: 22), onDelete);
          }
          if (k.isEmpty) return const Expanded(child: SizedBox());
          return _key(Text(k, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500)), () => onDigit(k));
        }).toList(),
      ),
    );
  }

  Widget _key(Widget child, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(_spacing), 
        child: Material(
          color: const Color(0xFF424242),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              height: 50, 
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}