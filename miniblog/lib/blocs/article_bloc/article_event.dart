import 'package:flutter/widgets.dart';
import 'package:miniblog/models/blog.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class FetchArticleDetail extends ArticleEvent {
  String id;

  FetchArticleDetail({required this.id});
}

class ResetEvent extends ArticleEvent {}

class AddArticle extends ArticleEvent {
  final Blog blog;
  final BuildContext context;

  AddArticle({required this.blog, required this.context});
}
