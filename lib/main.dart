import 'package:demo_new/constant/theme_styling/theme_data.dart';
import 'package:demo_new/helper/pokemon_database_helper.dart';
import 'package:demo_new/logic/cubit_pokemon_list/pokemon_list_cubit.dart';
import 'package:demo_new/logic/cubit_sign_in/sign_in_state.dart';
import 'package:demo_new/logic/cubit_sign_up/sign_up_cubit.dart';
import 'package:demo_new/logic/cubit_sign_up/sign_up_state.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';
import 'package:demo_new/presentation/home_nav.dart';
import 'package:demo_new/presentation/sign_in_screen.dart';
import 'package:demo_new/utils/preference_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit_sign_in/sign_in_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool userLoggedIn = await PreferenceUtils.isLoggedIn();
  await Firebase.initializeApp();
  await PokemonDatabaseHelper().initDatabase();
  runApp(MyApp(userLoggedIn: userLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.userLoggedIn,
  }) : super(key: key);

  final bool userLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit demo',
      theme: myLightThemeData,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(SignUpInitState()),
          ),
          BlocProvider<SignInCubit>(
            create: (context) => SignInCubit(SignInInitState()),
          ),
          BlocProvider<PokemonListCubit>(
            create: (context) => PokemonListCubit(context,
                repository: PokemonListModel(
                  count: 0,
                  results: [],
                )),
          ),
        ],
        child: userLoggedIn ?  const HomeBottomNav() : const SignInScreen(),
      ),
    );
  }
}
