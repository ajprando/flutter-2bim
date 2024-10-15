class TransacaoService {
  static List<Map<String, dynamic>> transacoes = [];

  static void adicionarTransacao(String titulo, double valor) {
    transacoes.add({'titulo': titulo, 'valor': valor});
  }

  static void editarTransacao(int index, String titulo, double valor) {
    transacoes[index] = {'titulo': titulo, 'valor': valor};
  }

  static void excluirTransacao(int index) {
    transacoes.removeAt(index);
  }
}
