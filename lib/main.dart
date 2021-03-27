import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Execution step in flutter (think of it as the java main )

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFTs for Sale',
      home: RandomWords(),
    );
  }
}

// This class 'StatefulWidget' is immutable & gets thrown out on reload
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// This is akin to a react component -- is mutable
class _RandomWordsState extends State<RandomWords> {
  // private fields
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};

  // Private method
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd)
            return Divider(
              color: Colors.amber,
            );
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  void _pushedSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final tiles = _saved.map(
          (WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: _biggerFont),
            )
          }
        )
      })
    )
  }

  // Private method
  Widget _buildRow(WordPair pair) {
    final alreadySaved =
        _saved.contains(pair); // double check that it hasn't been added to favs
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.purple.shade200 : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  // This is akin to the react build section
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('List of My Stuff'),
        actions: [
          IconButton(icon: Icon(Icons.account_balance_wallet_rounded), onPressed: _pushedSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
