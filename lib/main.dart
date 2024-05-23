import 'package:api_crud_flutter/Albums_Api/Albums_Provider.dart';
import 'package:api_crud_flutter/Comment_Api/Comment_provider.dart';
import 'package:api_crud_flutter/Photos_Api/Photo_Provider.dart';
import 'package:api_crud_flutter/Todos_Api/Todos_Provider.dart';
import 'package:api_crud_flutter/screen/Hoem_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controller/UserProvider.dart';
import 'JsonApi/postApi.dart';
import 'JsonApi/post_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider(),
        ),

        ChangeNotifierProvider<CommentProvider>(
          create: (context) => CommentProvider(),
        ),

        ChangeNotifierProvider<AlbumsProvider>(
          create: (context) => AlbumsProvider(),
        ),

        ChangeNotifierProvider<PhotoProvider>(
          create: (context) => PhotoProvider(),
        ),

        ChangeNotifierProvider<TodosProvider>(
          create: (context) => TodosProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
