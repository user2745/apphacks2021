import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Execution step in flutter (think of it as the java main )

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFTs for Sale',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Buy my Unique Laptop as an NFT'),
        ),
        body: Center(
          // Load the entire code chunk 
          child: RandomWords(),
        ),
      ),
    );
  }
}

// This is akin to a react component
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
