// ライブラリを「pubspec.yaml」に追加して、以下で読み込む
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class _RandomWordsState extends State<RandomWords> {
  @override
  // buildの外で定義しないとエラーが出る
  // Listは重複可能なデータセット
  // Setは重複のないデータセット
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
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
        actions: [
          // onPressed: アイコンがタップされたときに_pushSaved(関数)を呼び出す
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  void _pushSaved() {
    // Navigatorのstackにページをpushする
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          // NEW lines from here...
          builder: (BuildContext context) {
            // お気に入りに追加済のデータを取得し、PascalCaseで表示
            final tiles = _saved.map(
                  (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            // お気に入りのリストが入っている変数を宣言し、toListでList型の変数に変換
            final divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestions'),
              ),
              body: ListView(children: divided),
            );
          },
        ),
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
    // お気に入りに追加されているかどうか。
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // もし保存されていたら、アイコンに色を付ける。true : false
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
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