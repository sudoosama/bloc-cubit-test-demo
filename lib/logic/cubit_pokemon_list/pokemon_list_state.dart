import 'package:demo_new/models/pokemon_parsing_model.dart';
import 'package:equatable/equatable.dart';

abstract class PokemonState extends Equatable {}

class PokemonListInitial extends PokemonState {
  @override
  List<Object> get props => [];
}

class PokemonListLoading extends PokemonState {
  final bool isLoading;

  PokemonListLoading(this.isLoading);
  @override
  List<Object?> get props => [isLoading];
}

class PokemonListSuccess extends PokemonState {
  final PokemonListModel pokemonList;

  PokemonListSuccess(this.pokemonList);

  @override
  List<Object?> get props => [pokemonList];
}

class PokemonListError extends PokemonState {
  final String errorMessage;

  PokemonListError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
