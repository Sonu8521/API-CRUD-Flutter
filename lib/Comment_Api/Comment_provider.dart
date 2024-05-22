import 'dart:convert';
import 'package:api_crud_flutter/Comment_Api/comment_datamodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentProvider extends ChangeNotifier {
  List<CommentDatamodel> _comments = [];
  bool _isLoading = false;
  String? _errorMessage;
  final Dio _dio = Dio();

  List<CommentDatamodel> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/comments');
      if (response.statusCode == 200) {
        _comments = (response.data as List)
            .map((data) => CommentDatamodel.fromJson(data))
            .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = 'Failed to load posts';
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPost(CommentDatamodel comment) async {
    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/comments',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode(comment.toJson()),
      );

      if (response.statusCode == 201) {
        final newPost = CommentDatamodel.fromJson(response.data);
        _comments.add(newPost);
        Fluttertoast.showToast(msg: 'Post Created Successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to create post');
      }
    } catch (error) {
      throw Exception('Failed to create post');
    }
  }

  Future<void> updatePost(CommentDatamodel comment) async {
    try {
      final response = await _dio.put(
        'https://jsonplaceholder.typicode.com/comments/${comment.id}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode(comment.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _comments.indexWhere((p) => p.id == comment.id);
        if (index != -1) {
          _comments[index] = comment;
          Fluttertoast.showToast(msg: 'Post Updated Successfully');
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update post');
      }
    } catch (error) {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await _dio.delete('https://jsonplaceholder.typicode.com/comments/$id');

      if (response.statusCode == 200) {
        _comments.removeWhere((post) => post.id == id);
        Fluttertoast.showToast(msg: 'Post Deleted Successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (error) {
      throw Exception('Failed to delete post');
    }
  }
}
