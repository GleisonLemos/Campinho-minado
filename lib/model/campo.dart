import 'package:flutter/foundation.dart';
import 'explosao_exception.dart';

class Campo {
  final int linhas;
  final int colunas;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    required this.linhas,
    required this.colunas,
  });

  void adicionarVizinho(Campo vizinho) {
    final deltalinha = (linhas - vizinho.linhas).abs();
    final deltaColuna = (colunas - vizinho.colunas).abs();

    if (deltalinha == 0 && deltaColuna == 0) {
      return;
    }
    if (deltalinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) {
      return;
    }

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhacaSegura) {
      vizinhos.forEach((v) => v.abrir());
    }
  }

  void revelarbombas() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get resolvido {
    bool minadoEMarcado = _minado && _marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  bool get vizinhacaSegura {
    return vizinhos.every((v) => !v.minado);
  }

  int get qtdeMinasNaVizinhaca {
    return vizinhos.where((v) => v.minado).length;
  }
}
