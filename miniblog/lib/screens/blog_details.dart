import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class BlogDetail extends StatefulWidget {
  final String blogId;

  const BlogDetail({Key? key, required this.blogId}) : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late Blog _blog;

  @override
  void initState() {
    super.initState();
    _blog = Blog(); // Başlangıç değeri atanabilir
    fetchBlogDetails();
  }

  void fetchBlogDetails() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      setState(() {
        _blog = Blog.fromJson(jsonData);
      });
    } else {
      print('Hata oluştu! ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_blog.id == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Yükleniyor...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(_blog.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Text('ID: ${_blog.id}'),
              Text('${_blog.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              AspectRatio(
                  aspectRatio: 16 / 9, child: Image.network(_blog.thumbnail!)),
              const SizedBox(
                height: 20,
              ),
              Text('${_blog.content}',
                  style: const TextStyle(
                    fontSize: 18.0,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${_blog.author}',
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
