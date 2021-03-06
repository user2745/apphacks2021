import 'package:english_words/english_words.dart';
import 'package:apphacks2021/Wallet.dart';
import 'package:flutter/material.dart';

// This class 'StatefulWidget' is immutable & gets thrown out on reload
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// This is akin to a react component -- is mutable
class _RandomWordsState extends State<RandomWords> {
  // private fields
    // Getting the value and object or contract_linking
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

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
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
        }, // ...to here.
      ),
    );
  }

  void _viewWallet() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) => Wallet()));
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
      // Getting the value and object or contract_linking
    return Scaffold(
      appBar: AppBar(
        title: Text('List of my Stuff'),
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
              icon: Icon(Icons.account_circle_rounded), onPressed: _viewWallet),
        ),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
