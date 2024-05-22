import 'package:api_crud_flutter/Comment_Api/Comment_provider.dart';
import 'package:api_crud_flutter/Comment_Api/comment_datamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JsonCommentView extends StatefulWidget {
  @override
  _JsonCommentViewState createState() => _JsonCommentViewState();
}

class _JsonCommentViewState extends State<JsonCommentView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Comment APIs"),
      ),
      body: Consumer<CommentProvider>(
        builder: (context, commentProvider, _) {
          if (commentProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (commentProvider.errorMessage != null) {
            return Center(child: Text(commentProvider.errorMessage!));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a new comment:',
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
                        final newComment = CommentDatamodel(
                          postId: 1,
                          id: 0,
                          name: titleController.text,
                          email: 'email@example.com',
                          body: bodyController.text,
                        );
                        await commentProvider.createPost(newComment);
                        titleController.clear();
                        bodyController.clear();
                      },
                      child: Text('Add Comment'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: commentProvider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentProvider.comments[index];
                    return ListTile(
                      title: Text(comment.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.body),
                          Text('ID: ${comment.id}'),
                          Text('Post ID: ${comment.postId}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              commentProvider.deletePost(comment.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              titleController.text = comment.name;
                              bodyController.text = comment.body;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Comment'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(labelText: 'Title'),
                                          ),
                                          TextField(
                                            controller: bodyController,
                                            decoration: const InputDecoration(labelText: 'Body'),
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
                                          final updatedComment = CommentDatamodel(
                                            postId: comment.postId,
                                            id: comment.id,
                                            name: titleController.text,
                                            email: 'email@example.com',
                                            body: bodyController.text,
                                          );
                                          commentProvider.updatePost(updatedComment);
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
