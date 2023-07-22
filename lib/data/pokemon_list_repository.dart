import 'package:demo_new/helper/pokemon_database_helper.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';
import 'package:demo_new/service/api.dart';
import 'package:demo_new/service/url.dart';
import 'package:demo_new/widget/my_snackbar.dart';
import 'package:flutter/material.dart';

class PokemonRepository{
  final BuildContext context;

  PokemonRepository(this.context);

  Future<PokemonListModel?> getPokemonList() async {
    PokemonListModel? repository;
    await APIServices.getDataWithResponseApi(
      context: context,
      url: ServerURLs.pokemonListAPI+'/?limit=25',
      successResponse: (snap){
        PokemonListModel pokemonList = PokemonListModel.fromJson(snap!);
        repository = pokemonList;
        saveToLocalStorage(pokemonList.results);
      },
      errorResponse: (error){
        MyShowSnackBar.errorSnackBar(context, error['errorType']);
      },
    );
    return repository;
  }

  Future<void> saveToLocalStorage(List<PokemonResultModel> pokemons) async {
    final dbHelper = PokemonDatabaseHelper();
    await dbHelper.initDatabase();

    for (var pokemon in pokemons) {
      final pokemonModel = PokemonResultModel(
        name: pokemon.name,
        url: pokemon.url,
        isFav: false,
      );

      await dbHelper.insertPokemon(pokemonModel);
    }
  }
}
