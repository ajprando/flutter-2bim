import 'package:flutter/material.dart';
import '../service/transacao.dart';

class Formulario extends StatefulWidget {
  final Map<String, dynamic>? transacaoExistente; 
  final int? indice; 

  Formulario({this.transacaoExistente, this.indice});

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.transacaoExistente != null) {
      _tituloController.text = widget.transacaoExistente!['titulo'];
      _valorController.text = widget.transacaoExistente!['valor'].toString();
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _salvarTransacao() {
    if (_formKey.currentState!.validate()) {
      final titulo = _tituloController.text;
      final valor = double.tryParse(_valorController.text) ?? 0.0;

      if (widget.indice == null) {
        TransacaoService.adicionarTransacao(titulo, valor);
      } else {
        TransacaoService.editarTransacao(widget.indice!, titulo, valor);
      }

      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transacaoExistente == null ? 'Nova Transação' : 'Editar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarTransacao,
                child: Text(widget.transacaoExistente == null ? 'Adicionar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
