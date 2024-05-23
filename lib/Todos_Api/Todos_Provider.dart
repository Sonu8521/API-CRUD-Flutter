import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Todos_datamodel.dart';

class TodosProvider extends ChangeNotifier {
  List<Todosdatamodel> _todos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Todosdatamodel> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTodos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _todos = data.map((json) => Todosdatamodel.fromJson(json)).toList();
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (error) {
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<void> createTodo(Todosdatamodel todo) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 201) {
        final newTodo = Todosdatamodel.fromJson(json.decode(response.body));
        _todos.add(newTodo);
        notifyListeners();
      } else {
        throw Exception('Failed to create todos');
      }
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'));

      if (response.statusCode == 200) {
        _todos.removeWhere((todo) => todo.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete todos');
      }
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<void> updateTodo(Todosdatamodel todo) async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 200) {
        final updatedTodo = Todosdatamodel.fromJson(json.decode(response.body));
        final index = _todos.indexWhere((t) => t.id == todo.id);
        if (index != -1) {
          _todos[index] = updatedTodo;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update todos');
      }
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }
}
