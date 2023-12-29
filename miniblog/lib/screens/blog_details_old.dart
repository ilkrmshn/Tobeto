import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';

class BlogDetail extends StatelessWidget {
  final Blog blog;

  const BlogDetail({Key? key, required this.blog, required String id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Text('ID: ${blog.id}'),
              Text('${blog.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              AspectRatio(
                  aspectRatio: 16 / 9, child: Image.network(blog.thumbnail!)),
              const SizedBox(
                height: 20,
              ),
              Text('${blog.content}',
                  style: const TextStyle(
                    fontSize: 18.0,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${blog.author}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
