import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:campinho/model/campo.dart';

main() {

  group('Campo', () {

    test('Abrir Campo COM Explosão', () {
      Campo c = Campo(linhas: 0, colunas: 0);
      c.minar();

      expect(c.abrir, throwsException);
    });

    test('Abrir Campo SEM Explosão', () {
      Campo c = Campo(linhas: 0, colunas: 0);
      c.abrir();
      expect(c.aberto, isTrue);
    });

    test('Adicionar NÃO Vizinho', () {
      Campo c1 = Campo(linhas: 0, colunas: 0);
      Campo c2 = Campo(linhas: 1, colunas: 3);
      c1.adicionarVizinho(c2);
      expect(c1.vizinhos.isEmpty, isTrue);
    });

    test('Minas na Vizinhaça', () {
      Campo c1 = Campo(linhas: 3, colunas: 3);

      Campo c2 = Campo(linhas: 3, colunas: 4);
      c2.minar();

      Campo c3 = Campo(linhas: 2, colunas: 2);


      Campo c4 = Campo(linhas: 4, colunas: 4);
      c4.minar();

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);

      expect(c1.qtdeMinasNaVizinhaca, 2);
    });
  
});
  
}