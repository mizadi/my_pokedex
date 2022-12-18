import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_pokedex/model/pokemon_results.dart';
import '../model/pokemon.dart';

class PokemonAPI {
  static final PokemonAPI shared = PokemonAPI._internal();
  static late List<Pokemon> pokemonList = <Pokemon>[];
  int offset = 10;

  factory PokemonAPI() {
    return shared;
  }

  PokemonAPI._internal();

  Future<List<Pokemon>> fetchPokemonResults() async {
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?limit=${offset.toString()}'));
    if (response.statusCode == 200) {
      await fetchPokemonFromUrl(
          PokemonResults.fromJson(jsonDecode(response.body)));
      offset = offset + 10;
      return pokemonList;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchPokemonFromUrl(PokemonResults results) async {
    for (PokemonRaw raw in results.pokemon) {
      await Future.delayed(const Duration(seconds: 1));
      fetchPokemon(raw.url);
    }
  }

  void fetchPokemon(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      pokemonList.add(Pokemon.fromJson(jsonDecode(response.body)));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Pokemon> searchPokemon(String pokemonName) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
