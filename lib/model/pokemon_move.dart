class PokemonMove {
  final String name;
  const PokemonMove({required this.name});

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    return PokemonMove(name: json['name']);
  }
}
