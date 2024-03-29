import 'package:book_list_sample/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本を追加'),
        ),

        //長いけど構成としてはTextFieldが２つとElevatedButtonが１つあるだけである。
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  //hintTextでヒントテキストを記入する。
                  //onChangedで値を取得する。
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      model.author = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // try catch文である。成功すれば緑でエラーが出たら赤
                      try {
                        await model.addBook();
                        Navigator.of(context).pop(true);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('成功です'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        //snackbar（下に出てくるflashみたいなメッセージ）を作る
                        //ScaffoldMessengerでsnakbarを表示させる
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('追加する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}