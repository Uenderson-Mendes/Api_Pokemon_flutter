import 'package:flutter/material.dart';

import '../main.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  final Dados pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name!),
        backgroundColor: Color.fromARGB(255, 18, 36, 54),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Color.fromARGB(255, 142, 138, 138),
            child: Image.network(
              pokemon.img!,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "ID: ${pokemon.id}",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Nome: ${pokemon.name}",
              style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Tipo:",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pokemon.type!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "${pokemon.type![index]}",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Fraquezas:",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pokemon.weaknesses!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "${pokemon.weaknesses![index]}",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
