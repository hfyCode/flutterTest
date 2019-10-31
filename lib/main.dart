import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair=WordPair.random();
    return MaterialApp(
      title: 'welcome to flutter',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: WordsRandom(),
    );
  }
}
class WordsRandom extends StatefulWidget{
  @override
  WordsRandomState createState() {
    // TODO: implement createState
    return WordsRandomState();
  }

}

class WordsRandomState extends State<WordsRandom>{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20.0);
  final _save = Set<WordPair>();
  void _pushSave(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        final Iterable<ListTile> iterable =_save.map(
            (WordPair wordPair){
              return ListTile(
                title: Text(
                  wordPair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
        );

        final List<Widget> divided = ListTile.divideTiles(
          context: context,
            tiles: iterable,
        ).toList();

        return new Scaffold(
          appBar: AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),

        );
      })
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair=WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSave,)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (item,i){
        if(i.isOdd) return Divider();
        final index=i~/2;
        if(index>=_suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  Widget _buildRow(WordPair wordPair){
    final bool alreadySaved=_save.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved?Icons.favorite:Icons.favorite_border,
        color: alreadySaved?Colors.red:null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _save.remove(wordPair);
          }else{
            _save.add(wordPair);
          }
        });
      },
    );
  }


}
