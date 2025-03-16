import 'package:flutter/material.dart';

class TransportOptions extends StatefulWidget {
  final Function(String) onModeChanged;

  const TransportOptions({required this.onModeChanged, super.key});

  @override
  TransportOptionsState createState() => TransportOptionsState();
}

class TransportOptionsState extends State<TransportOptions> {
  String _selectedMode = "driving"; // Default mode is Car

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 70),
      decoration: BoxDecoration(
        color: Color(0xFF0A2647),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _transportButton("🚗 Car", "driving"),
          _transportButton("🚌 Transit", "transit"),
        ],
      ),
    );
  }

  Widget _transportButton(String label, String mode) {
    bool isSelected = _selectedMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = mode;
        });
        widget.onModeChanged(mode);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1954A6) : Color(0xFFE0E6ED),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
