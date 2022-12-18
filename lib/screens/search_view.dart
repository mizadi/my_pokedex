import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pokedex/extensions/string_extension.dart';
import 'package:my_pokedex/network/pokemon_api.dart';

import '../model/pokemon.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Future<Pokemon> _searchedPokemon = PokemonAPI().searchPokemon('aaa');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Center(
            child: TextField(
              autocorrect: false,
              onSubmitted: ((value) {
                _searchedPokemon =
                    PokemonAPI().searchPokemon(value.toLowerCase());
                setState(() {});
              }),
              decoration: const InputDecoration(
                hintText: 'Enter pokemon name to search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<Pokemon>(
            future: _searchedPokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(snapshot.data!.spriteUrl),
                        height: 200,
                        width: 200,
                        fit: BoxFit.fitWidth,
                      ),
                      const Text(
                        "Abilities",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.abilities.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    snapshot.data!.abilities[index].name
                                        .capitalize(),
                                    style: const TextStyle(fontSize: 18),
                                  )),
                                );
                              })),
                      const Text(
                        "Moves",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.moves.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    snapshot.data!.moves[index].name
                                        .capitalize(),
                                    style: const TextStyle(fontSize: 18),
                                  )),
                                );
                              })),
                    ],
                  ),
                );
              } else {
                return const Text("No search results");
              }
            }),
      ),
    );
  }
}
