import 'package:flutter/material.dart';
import '../service/transacao.dart';
import 'formulario.dart'; 

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  
  void _confirmarExclusao(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tem certeza que deseja excluir?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  TransacaoService.excluirTransacao(index); 
                });
                Navigator.of(context).pop(); 
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _editarTransacao(int index) {
    final transacao = TransacaoService.transacoes[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Formulario(
          transacaoExistente: transacao, 
          indice: index,                 
        ),
      ),
    ).then((_) {
      setState(() {}); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Transações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: TransacaoService.transacoes.length,
                itemBuilder: (context, index) {
                  final transacao = TransacaoService.transacoes[index];
                  return Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmarExclusao(index); 
                        },
                      ),
                      title: Text(transacao['titulo']),
                      subtitle: Text('Valor: ${transacao['valor']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editarTransacao(index); 
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Formulario()),
                ).then((_) {
                  setState(() {}); 
                });
              },
              child: Text('Adicionar Nova Transação'),
            ),
          ],
        ),
      ),
    );
  }
}
