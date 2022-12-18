import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:my_pokedex/model/pokemon.dart';
import 'package:my_pokedex/network/pokemon_api.dart';
import 'package:my_pokedex/screens/pokemon_page.dart';
import 'package:my_pokedex/screens/search_view.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _pokemonPage(Pokemon pokemon) {
      //Navigator.pushNamed(context, "/PokemonPage", arguments: pokemon);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PokemonPage(pokemon: pokemon)));
    }

    return MaterialApp(
      initialRoute: '/',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Pokedex'),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchView())),
                icon: const Icon(Icons.search))
          ],
        ),
        body: Center(
          child: FutureBuilder<List<Pokemon>>(
            future: PokemonAPI().fetchPokemonResults(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              _pokemonPage(snapshot.data![index]);
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                Text(snapshot.data![index].id.toString()),
                                const SizedBox(width: 15),
                                FadeInImage(
                                    width: 150,
                                    height: 150,
                                    placeholder: const AssetImage(
                                        'images/placeholder.png'),
                                    image: NetworkImage(
                                        snapshot.data![index].spriteUrl)),
                                const SizedBox(width: 15),
                                Text(
                                  snapshot.data![index].name.capitalize(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
