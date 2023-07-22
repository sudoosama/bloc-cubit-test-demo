import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_new/main.dart';
import 'package:flutter/material.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';

class FavoritePokemonListScreen extends StatefulWidget {

   FavoritePokemonListScreen({Key? key}) : super(key: key);

  @override
  State<FavoritePokemonListScreen> createState() => _FavoritePokemonListScreenState();
}

class _FavoritePokemonListScreenState extends State<FavoritePokemonListScreen> {
  final CollectionReference _favoritesCollection =
  FirebaseFirestore.instance.collection('favorites');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Favorite Pokemon List'.toUpperCase(),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _favoritesCollection
            .doc(USERTOKEN)
            .collection('pokemons')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final favoritePokemonDocs = snapshot.data!.docs;
          final favoritePokemonList = favoritePokemonDocs
              .map((doc) => PokemonResultModel(
            name: doc['name'],
            url: doc['url'],
            isFav: doc['isFav'],
          ))
              .toList();
          return ListView.builder(
            itemCount: favoritePokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = favoritePokemonList[index];
              return ListTile(
                title: Text(pokemon.name),
                subtitle: Text(pokemon.url),
                trailing: Icon(
                  Icons.favorite,
                  color: pokemon.isFav! ? Colors.red : Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
