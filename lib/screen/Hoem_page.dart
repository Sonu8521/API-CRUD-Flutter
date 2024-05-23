import 'package:api_crud_flutter/Photos_Api/Photo_View.dart';
import 'package:flutter/material.dart';
import 'package:api_crud_flutter/Todos_Api/Todos_view.dart';
import 'package:api_crud_flutter/Albums_Api/Albums_view.dart';
import 'package:api_crud_flutter/Comment_Api/Comment_view.dart';
import 'package:api_crud_flutter/JsonApi/postApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JsonPostApis()));
                },
                child: const Text(
                  'Post Provider Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JsonCommentView()));
                },
                child: const Text(
                  'Comment Provider Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JsonAlbumsview()));
                },
                child: const Text(
                  'Albums Provider Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JsonPhotoview()));
                },
                child: const Text(
                  'Photos Provider Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JsonTodosView()));
                },
                child: const Text(
                  'Todos Provider Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
