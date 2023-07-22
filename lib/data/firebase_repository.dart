import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_new/constant/log_print.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';
import 'package:demo_new/widget/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseRepository {
  final CollectionReference _favoritesCollection =
  FirebaseFirestore.instance.collection('favorites');

  Future<void> addToFavorites(BuildContext context,PokemonResultModel pokemon) async {
    try {
      await _favoritesCollection.doc(pokemon.name).set({
        'name': pokemon.name,
        'url': pokemon.url,
        'isFav': pokemon.isFav,
      });
    } catch (e) {
      'Error adding to favorites: $e'.log();
      MyShowSnackBar.errorSnackBar(context, 'Error adding to favorites');
      throw Exception('Failed to add to favorites.');
    }
  }


  Future<List<PokemonResultModel>> getUserFavoritePokemons() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? userId = user?.uid;

    List<PokemonResultModel> favoritePokemons = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('pokemons')
          .get();

      favoritePokemons = snapshot.docs.map((doc) => PokemonResultModel.fromJson(doc.data())).toList();
    } catch (e) {
      'Error fetching user favorite Pokémon: $e'.log();
    }

    return favoritePokemons;
  }
}
