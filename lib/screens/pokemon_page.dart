import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pokedex/extensions/string_extension.dart';

import '../model/pokemon.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key, this.pokemon});

  final Pokemon? pokemon;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (widget.pokemon != null) ? widget.pokemon!.name.capitalize() : ""),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Image(
              image: NetworkImage(
                  (widget.pokemon != null) ? widget.pokemon!.spriteUrl : ""),
              height: 200,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            const Text(
              "Abilities",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: (widget.pokemon != null)
                        ? widget.pokemon!.abilities.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                          (widget.pokemon != null)
                              ? widget.pokemon!.abilities[index].name
                                  .capitalize()
                              : "",
                          style: const TextStyle(fontSize: 18),
                        )),
                      );
                    })),
            const Text(
              "Moves",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: (widget.pokemon != null)
                        ? widget.pokemon!.moves.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                          (widget.pokemon != null)
                              ? widget.pokemon!.moves[index].name.capitalize()
                              : "",
                          style: const TextStyle(fontSize: 18),
                        )),
                      );
                    })),
          ],
        )),
      ),
    );
  }
}
