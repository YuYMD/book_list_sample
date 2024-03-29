import 'package:book_list_sample/add_book/add_book_page.dart';
import 'package:book_list_sample/book_list/book_list_model.dart';
import 'package:book_list_sample/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
//毎回最初にcreate: (_) => BookListModel()..fetchBookList()を読み込ませている。
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
              ),
            )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
        Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            //画面遷移の方法：builder: (context) => AddBookPage(),に移動する。
            // fullscreenDialog: true,で下からニュルっと出てくる。
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}