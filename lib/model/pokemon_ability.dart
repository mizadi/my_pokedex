class PokemonAbility {
  final String name;

  const PokemonAbility({required this.name});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(name: json['name']);
  }
}
