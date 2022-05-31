import 'package:campinho/components/tabuleiro_widget.dart';
import 'package:campinho/model/tabuleiro.dart';
import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';
import '../model/campo.dart';
import '../model/explosao_exception.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  late bool _venceu;
  Tabuleiro _tabuleiro = Tabuleiro(linhas: 12, colunas: 12, qtdebombas: 3);

  void _reiniciar() {
    setState(() {
      _venceu ? null : _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _gatTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();
      _tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdeColunas,
        qtdebombas: 3,
      );
    }
    return _tabuleiro;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, Constraints) {
              return TabuleiroWidget(
                  tabuleiro: _gatTabuleiro(
                    Constraints.maxHeight,
                    Constraints.maxWidth,
                  ),
                  onAbrir: _abrir,
                  onAlternarMarcacao: _alternarMarcacao);
            },
          ),
        ),
      ),
    );
  }
}
