import 'package:demo_new/constant/log_print.dart';
import 'package:demo_new/logic/cubit_pokemon_list/pokemon_list_cubit.dart';
import 'package:demo_new/logic/cubit_pokemon_list/pokemon_list_state.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';
import 'package:demo_new/presentation/sign_in_screen.dart';
import 'package:demo_new/utils/preference_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonListViewScreen extends StatefulWidget {
  const PokemonListViewScreen({Key? key}) : super(key: key);

  @override
  State<PokemonListViewScreen> createState() => _PokemonListViewScreenState();
}

class _PokemonListViewScreenState extends State<PokemonListViewScreen> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonListCubit>(
      create: (context) => PokemonListCubit(context,
          repository: PokemonListModel(
            count: 0,
            results: [],
          )),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pokemon List'.toUpperCase(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: const Icon(
                  Icons.shutter_speed_sharp,
                  color: Colors.white,
                ))
          ],
        ),
        body: BlocBuilder<PokemonListCubit, PokemonState>(
          builder: (context, state) {
            return _buildContent(state, context);
          },
        ),
      ),
    );
  }

  Widget _buildContent(PokemonState state, BuildContext context) {
    switch (state.runtimeType) {
      case PokemonListLoading:
        return _loaderWidget();
      case PokemonListSuccess:
        final pokemonList = (state as PokemonListSuccess).pokemonList;
        return _listWidget(pokemonList);
      case PokemonListError:
        return Center(
          child: Text((state as PokemonListError).errorMessage),
        );
      default:
        return const Center(
          child: Text('Something went wrong!'),
        );
    }
  }

  Widget _loaderWidget() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.black),
    );
  }

  Widget _listWidget(PokemonListModel pokemonList) {
    return ListView.builder(
      itemCount: pokemonList.results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(pokemonList.results[index].name,
              style: const TextStyle(color: Colors.black)),
          subtitle: Text(pokemonList.results[index].url,
              style: const TextStyle(color: Colors.black)),
          trailing: IconButton(
            onPressed: () {
              context.read<PokemonListCubit>().toggleFavorite(
                    context,
                    pokemonList.results[index],
                  );
            },
            icon: Icon(
              Icons.favorite,
              color:
                  pokemonList.results[index].isFav! ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      PreferenceUtils.clearSharedPref();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );
    } catch (e) {
      'Error during logout: $e'.log();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during logout. Please try again.')),
      );
    }
  }
}
