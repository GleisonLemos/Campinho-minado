import 'package:campinho/components/campo_widget.dart';
import '../model/campo.dart';
import '../model/tabuleiro.dart';
import 'package:flutter/material.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  TabuleiroWidget({
    required this.tabuleiro,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos.map((c) {
          return CampoWidget(
            campo: c,
            onAbrir: onAbrir,
            onAlternarMarcacao: onAlternarMarcacao,
          );
        }).toList(),
      ),
    );
  }
}
