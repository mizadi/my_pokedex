import 'dart:convert';

import 'package:my_pokedex/model/pokemon_ability.dart';
import 'package:my_pokedex/model/pokemon_move.dart';

class Pokemon {
  final String name;
  final int id;
  final String spriteUrl;
  final List<PokemonAbility> abilities;
  final List<PokemonMove> moves;

  const Pokemon(
      {required this.name,
      required this.id,
      required this.spriteUrl,
      required this.abilities,
      required this.moves});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        id: json['id'],
        spriteUrl: json["sprites"]["front_default"],
        abilities: Pokemon.parseAbilities(json["abilities"]),
        moves: Pokemon.parseMovies(json["moves"]));
  }
  static List<PokemonAbility> parseAbilities(List<dynamic> json) {
    var pokemonAbilities = <PokemonAbility>[];
    for (Map<String, dynamic> element in json) {
      pokemonAbilities.add(PokemonAbility(name: element["ability"]["name"]));
    }
    return pokemonAbilities;
  }

  static List<PokemonMove> parseMovies(json) {
    var pokemonMoves = <PokemonMove>[];
    for (Map<String, dynamic> element in json) {
      pokemonMoves.add(PokemonMove(name: element["move"]["name"]));
    }
    return pokemonMoves;
  }
}

class PokemonRaw {
  final String url;

  const PokemonRaw({required this.url});

  factory PokemonRaw.fromJson(Map<String, dynamic> json) {
    return PokemonRaw(url: json['url']);
  }
}
