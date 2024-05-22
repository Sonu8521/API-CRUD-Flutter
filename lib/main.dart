import 'package:api_crud_flutter/Comment_Api/Comment_view.dart';
import 'package:api_crud_flutter/Controller/UserProvider.dart';
import 'package:api_crud_flutter/JsonApi/postApi.dart';
import 'package:api_crud_flutter/JsonApi/post_provider.dart';
import 'package:api_crud_flutter/screen/Hoem_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_crud_flutter/Comment_Api/Comment_provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider(),// Fetch posts once here
        ),
        ChangeNotifierProvider<CommentProvider>(create: (context)=> CommentProvider()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HoemPage(),
      ),
    );
  }
}