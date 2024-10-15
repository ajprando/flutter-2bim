import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AbstractApi<T> {
  final _urlLocalHost = 'http://localhost:3000';

  String _recurso;

  AbstractApi(this._recurso);


  Future<List<dynamic>> getAll() async {
    var response = await http.get(Uri.parse('$_urlLocalHost/$_recurso'));

    if(response.statusCode==200){
      return (json.decode(response.body) as List)
        .map((data)=>fromJson(data))
        .toList();
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  Future<T> create(T item) async {
    var response = await http.post(
      Uri.parse('$_urlLocalHost/$_recurso'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(toJson(item)),
    );

    if (response.statusCode == 201) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar item');
    }
  }

  Future<void> update(int id, T item) async {
    var response = await http.put(
      Uri.parse('$_urlLocalHost/$_recurso/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(toJson(item)),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar item');
    }
  }

  Future<void> delete(int id) async {
    var response = await http.delete(Uri.parse('$_urlLocalHost/$_recurso/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao excluir item');
    }
  }

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);
}

