import 'package:api_crud_flutter/Albums_Api/Albums_view.dart';
import 'package:api_crud_flutter/Comment_Api/Comment_provider.dart';
import 'package:api_crud_flutter/Comment_Api/Comment_view.dart';
import 'package:api_crud_flutter/JsonApi/postApi.dart';
import 'package:flutter/material.dart';

class HoemPage extends StatefulWidget {
  const HoemPage({super.key});

  @override
  State<HoemPage> createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),

        body:Container(
          color: Colors.blue,
          child:  Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JsonPostApis()));
                  },
                  child: const Text('Post Provider Data',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JsonCommentView()));
                  },

                  child: const Text('Comment Provider Data',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JsonAlbumsview()));
                  },

                  child: const Text('Albums Provider Data',style: TextStyle(fontWeight: FontWeight.bold),),
                ),

              ],
            ),
          ),
        ),
    );
  }
}
