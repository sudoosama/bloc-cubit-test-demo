import 'package:demo_new/data/firebase_repository.dart';
import 'package:demo_new/data/pokemon_list_repository.dart';
import 'package:demo_new/helper/pokemon_database_helper.dart';
import 'package:demo_new/logic/cubit_pokemon_list/pokemon_list_state.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonListCubit extends Cubit<PokemonState> {
  PokemonListCubit(BuildContext context,{required this.repository}) : super(PokemonListInitial()) {
    fetchPokemonList(context);
  }
  final PokemonListModel repository;
  final dbHelper = PokemonDatabaseHelper();

  Future<void> fetchPokemonList(BuildContext context) async {
    emit(PokemonListLoading(true));
    try {
      final PokemonListModel? repository =await PokemonRepository(context).getPokemonList();
      final List<PokemonResultModel> userFavoritePokemons = await FirebaseRepository().getUserFavoritePokemons();
      for (var pokemon in repository!.results) {
        pokemon.isFav = userFavoritePokemons.any(
              (favPokemon) => favPokemon.name == pokemon.name && favPokemon.url == pokemon.url,
        );
      }
      emit(PokemonListSuccess(repository));
    } catch (e) {
      _fetchDataFromDatabase();
    }
  }

  Future<void> _fetchDataFromDatabase() async {
    try {
      final List<PokemonResultModel> pokemons = await dbHelper.getPokemons();
      final repository = PokemonListModel(count: pokemons.length, results: pokemons);
        emit(PokemonListSuccess(repository));
    } catch (e) {
      emit(PokemonListError('Something went wrong!'));
    }
  }

  void toggleFavorite(BuildContext context,PokemonResultModel pokemon) {
    pokemon.isFav = !pokemon.isFav!;
    if (state is PokemonListSuccess) {
      final updatedList = PokemonListModel(
        count: (state as PokemonListSuccess).pokemonList.count,
        next: (state as PokemonListSuccess).pokemonList.next,
        previous: (state as PokemonListSuccess).pokemonList.previous,
        results: (state as PokemonListSuccess)
            .pokemonList
            .results
            .map((poke) => poke.name == pokemon.name && poke.url == pokemon.url
            ? PokemonResultModel(
          name: poke.name,
          url: poke.url,
          isFav: pokemon.isFav,
        )
            : poke)
            .toList(),
      );
      emit(PokemonListSuccess(updatedList));
      if (pokemon.isFav!) {
        FirebaseRepository().addToFavorites(context,pokemon);
      }
    }
  }

}
