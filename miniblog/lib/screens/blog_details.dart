import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';

class BlogDetail extends StatefulWidget {
  final String id;

  const BlogDetail({Key? key, required this.id}) : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Eğer detay daha önce yüklenmediyse, yükle
    if (!isLoaded) {
      context.read<ArticleBloc>().add(FetchArticleDetail(id: widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detay")),
      body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
        if (state is ArticlesInitial) {
          context.read<ArticleBloc>().add(FetchArticleDetail(id: widget.id));
          isLoaded = true;
          return Text("İstek atılmalı..");
        }
        if (state is ArticlesDetailLoaded) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Text('ID: ${_blog.id}'),
              Text('${state.blog.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(state.blog.thumbnail!)),
              const SizedBox(
                height: 20,
              ),
              Text('${state.blog.content}',
                  style: const TextStyle(
                    fontSize: 18.0,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${state.blog.author}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ));
        }

        return Center(
          child: Text(widget.id),
        );
      }),
    );
  }
}
