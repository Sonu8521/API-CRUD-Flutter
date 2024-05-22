import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_crud_flutter/JsonApi/datamodel.dart';
import 'package:api_crud_flutter/JsonApi/post_provider.dart';

class JsonPostApis extends StatefulWidget {
  @override
  _JsonPostApisState createState() => _JsonPostApisState();
}

class _JsonPostApisState extends State<JsonPostApis> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JsonPlaceholder APIs"),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          if (postProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (postProvider.errorMessage != null) {
            return Center(child: Text(postProvider.errorMessage!));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a new post:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: bodyController,
                      decoration: const InputDecoration(labelText: 'Body'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final newPost = Post(
                          userId: 1,
                          id: 0,
                          title: titleController.text,
                          body: bodyController.text,
                        );
                        await postProvider.createPost(newPost);
                        titleController.clear();
                        bodyController.clear();
                      },
                      child: Text('Add Post'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    final post = postProvider.posts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Column(children: [Text(post.body),Text(post.id.toString()),Text(post.userId.toString())],),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              postProvider.deletePost(post.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              titleController.text = post.title;
                              bodyController.text = post.body;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Post'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                                labelText: 'Title'),
                                          ),
                                          TextField(
                                            controller: bodyController,
                                            decoration: const InputDecoration(
                                                labelText: 'Body'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          final updatedPost = Post(
                                            userId: post.userId,
                                            id: post.id,
                                            title: titleController.text,
                                            body: bodyController.text,
                                          );
                                          postProvider.updatePost(updatedPost);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
