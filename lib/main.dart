// ライブラリを「pubspec.yaml」に追加して、以下で読み込む
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class _RandomWordsState extends State<RandomWords> {
  @override
  // buildの外で定義しないとエラーが出る
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  // buildメソッドが呼ばれる
  Widget build(BuildContext context) {
    // wordPairを作る
    // final wordPair = WordPair.random();
    // PascalCaseに変換してテキストを返す
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

// Stateful: 動的部品。状態が変わるとbuildで更新される。
class RandomWords extends StatefulWidget {
  // StatefulWidgetの属性を引き継ぐ
  @override
  // createStateというメソッドを定義し、_RandomWordsStateのインスタンスを一つ作成
  _RandomWordsState createState() => _RandomWordsState();
}

// Stateless: 静的部品。アプリ実行後に一度だけ処理がされる。
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 複数の部品を束ねる
      home: RandomWords(),
    );
  }
}