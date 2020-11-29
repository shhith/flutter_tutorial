// ライブラリを「pubspec.yaml」に追加して、以下で読み込む
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}

// Stateful: 動的部品。
class RandomWords extends StatefulWidget {
  // StatefulWidgetの属性を引き継ぐ
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// Stateless: 静的部品、変化をしない部品
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome to Flutter',
      // 複数の部品を束ねる
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter!!'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}