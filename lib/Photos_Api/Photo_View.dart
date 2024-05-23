import 'package:api_crud_flutter/Photos_Api/Photo_Provider.dart';
import 'package:api_crud_flutter/Photos_Api/Photo_datamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JsonPhotoview extends StatefulWidget {
  @override
  _JsonPhotoviewState createState() => _JsonPhotoviewState();
}

class _JsonPhotoviewState extends State<JsonPhotoview> {
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PhotoProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Photo APIs"),
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, photoProvider, _) {
          if (photoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (photoProvider.errorMessage != null) {
            return Center(child: Text(photoProvider.errorMessage!));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a new Album:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final newphoto = PhotoDatamodel(
                          albumId: 1,
                          id: 0,
                          title: titleController.text,
                          url: '',
                          thumbnailUrl: '',
                        );
                        await photoProvider.createPost(newphoto);
                        titleController.clear();
                      },
                      child: Text('Add Album'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: photoProvider.photo.length,
                  itemBuilder: (context, index) {
                    final album = photoProvider.photo[index];
                    return ListTile(
                      leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            album.url.toString(),
                          ),
                        ),
                      ),
                      title: Text('Title: ${album.title}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${album.id}'),
                          Text('Album ID: ${album.albumId}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              photoProvider.deletePost(album.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              titleController.text = album.title;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Album'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                                labelText: 'Title'),
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
                                        onPressed: () async {
                                          final updatedAlbum = PhotoDatamodel(
                                            albumId: album.albumId,
                                            id: album.id,
                                            title: titleController.text,
                                            url: album.url,
                                            thumbnailUrl: album.thumbnailUrl,
                                          );
                                          await photoProvider
                                              .updatePost(updatedAlbum);
                                          titleController.clear();
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
