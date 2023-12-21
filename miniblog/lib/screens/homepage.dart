import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/screens/blog_details.dart';
import 'package:miniblog/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    setState(() {
      blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text("Bloglar"),
          actions: [
            IconButton(
                onPressed: () async {
                  bool? result = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => AddBlog()));

                  if (result == true) {
                    fetchBlogs();
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: blogs.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  fetchBlogs();
                },
                child: ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BlogDetail(blogId: "${blogs[index].id}"),
                              ),
                            );
                            print("Tıklanan öğe: ${blogs[index].id}");
                          },
                          child: BlogItem(blog: blogs[index]),
                        ),
                    itemCount: blogs.length),
              ));
  }
}
