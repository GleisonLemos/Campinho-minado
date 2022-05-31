import "package:flutter/material.dart";

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool venceu;
  final Function onReiniciar;

  ResultadoWidget({
    required this.venceu,
    required this.onReiniciar,
  });

  Color _getCor() {
    if (venceu == null) {
      return Color.fromARGB(255, 255, 230, 0);
    } else if (venceu) {
      return Color.fromARGB(255, 0, 250, 12);
    } else {
      return Color.fromARGB(255, 255, 0, 0);
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  _getIcon(),
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  onReiniciar;
                }),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
