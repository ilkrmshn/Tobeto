import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Blog>> fetchAllBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    return jsonData.map((json) => Blog.fromJson(json)).toList();
  }

  Future<Blog> fetchBlogById(String id) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/" + id);
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    return Blog.fromJson(jsonData);
  }

  submitForm(Blog blog, BuildContext context) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    request.files
        .add(await http.MultipartFile.fromPath("File", blog.thumbnail.toString()));

    request.fields['Title'] = blog.title.toString();
    request.fields['Content'] = blog.content.toString();
    request.fields['Author'] = blog.author.toString();

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }
}
