import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  //?でnull許容にする。
  String? title;
  String? author;

  Future addBook() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
      //もしnullだったらthrowで上記のメッセージを投げる。
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    // firestoreに追加する
    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}