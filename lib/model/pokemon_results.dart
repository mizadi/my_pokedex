import 'package:my_pokedex/model/pokemon.dart';

class PokemonResults {
  List<PokemonRaw> pokemon;

  PokemonResults({required this.pokemon});

  factory PokemonResults.fromJson(Map<String, dynamic> json) {
    return PokemonResults(
        pokemon: List<PokemonRaw>.from(
            json["results"].map((element) => PokemonRaw.fromJson(element))));
  }
}
