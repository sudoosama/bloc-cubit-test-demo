import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:demo_new/models/pokemon_parsing_model.dart';

class PokemonDatabaseHelper {
  static final PokemonDatabaseHelper _instance = PokemonDatabaseHelper._internal();

  factory PokemonDatabaseHelper() => _instance;

  PokemonDatabaseHelper._internal();

  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'pokemon_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pokemons(name TEXT PRIMARY KEY, url TEXT, isFav INTEGER)",
        );
      },
    );
  }

  Future<void> insertPokemon(PokemonResultModel pokemon) async {
    await _database.insert(
      'pokemons',
      pokemon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePokemon(PokemonResultModel pokemon) async {
    await _database.update(
      'pokemons',
      pokemon.toMap(),
      where: 'name = ?',
      whereArgs: [pokemon.name],
    );
  }

  Future<List<PokemonResultModel>> getPokemons() async {
    final List<Map<String, dynamic>> maps = await _database.query('pokemons');
    return List.generate(maps.length, (i) {
      return PokemonResultModel(
        name: maps[i]['name'],
        url: maps[i]['url'],
        isFav: maps[i]['isFav'] == 1,
      );
    });
  }
}
