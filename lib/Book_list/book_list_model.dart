import 'package:book_list_sample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books;

  void fetchBookList() async {
    //コレクションに接続する。snapショットに値が入る。
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('books').get();
　　//snapshotのdocsに入っているdocumentをmapでString, dynamicに変換してdataに入れる
   //DocumentSnapshotからbooks型に変換したいのでmapでdataに変換をする。
    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data['title'];
      final String author = data['author'];
　　//data['title']で値を取得できる。
　　//今現在は２つ値があるのでBook(title, author)でイニシャライズ（単体に）する。
　　//mapのなかでclass Bookを使ってreturnする。
　　//DocumentSnapshotだったものがList<Book> booksになる。
      return Book(title, author);
    }).toList();
　　//最後にできた値にthis宣言すればList<Book>? booksに値が入る。
   // notifyListeners()で全体にお知らせをすれば、
    // booklistpageのConsumerが発火してrebuildされる。
    // なお、fetchBookluistがない場合はCircularProgressIndicator()が動く。
    //create: (_) => BookListModel()..fetchBookList(),
    this.books = books;
    notifyListeners();
  }
}


//BookListPageでは毎回最初にcreate: (_) => BookListModel()..fetchBookList()を読み込ませている。