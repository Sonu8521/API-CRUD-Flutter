import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  // Define your state variables
  List<String> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter for users
  List<String> get users => _users;

  // Getter for loading status
  bool get isLoading => _isLoading;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Method to fetch users (example implementation)
  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate a network request
      await Future.delayed(Duration(seconds: 2));

      // Simulate fetched data
      _users = ['User 1', 'User 2', 'User 3'];
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  // Method to add a user
  void addUser(String user) {
    _users.add(user);
    notifyListeners();
  }

  // Method to remove a user
  void removeUser(String user) {
    _users.remove(user);
    notifyListeners();
  }
}
