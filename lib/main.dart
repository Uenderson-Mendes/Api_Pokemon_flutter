import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_preview/device_preview.dart';
import 'package:pokemon/models/poke_deta.dart';

class Pokemons {
  List<Dados>? dados;

  Pokemons({this.dados});

  Pokemons.fromJson(Map<String, dynamic> json) {
    if (json['dados'] != null) {
      dados = <Dados>[];
      json['dados'].forEach((v) {
        dados!.add(new Dados.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dados != null) {
      data['dados'] = this.dados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dados {
  int? id;
  String? name;
  String? img;
  List<String>? type; // nova propriedade
  List<String>? weaknesses;

  Dados({
    this.id,
    this.name,
    this.img,
    this.type,
    this.weaknesses,
  });

  Dados.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    type = List<String>.from(json['type']
        .map((x) => x.toString())); 
     weaknesses = List<String>.from(json['weaknesses']
        .map((x) => x.toString()));// adicionando a propriedade type
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['type'] = this.type;
    data['weaknesses'] = this.weaknesses;
    return data;
  }
}

Future<List<Dados>> dados() async {
  final List<dynamic> result = await fetchUsers();
  //print(result);
  List<Dados> pokemons;
  pokemons = (result).map((pokemon) => Dados.fromJson(pokemon)).toList();
  return pokemons;
}

const String url =
    "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

Future<List<dynamic>> fetchUsers() async {
  var result = await http.get(Uri.parse(url));
  return jsonDecode(result.body)['pokemon'];
}

//void main() => runApp(
// DevicePreview(
// enabled: !kReleaseMode,
//builder: (context) => MyApp(), // Wrap your app
//),
// );
void main() {
  runApp(const MyApp());
}

const Color darkBlue = Color.fromARGB(255, 80, 107, 135);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Lista de Pokemons';

    return const MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: appTitle,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color.fromARGB(255, 18, 36, 54),
      ),
      body: FutureBuilder<List<Dados>>(
        future: dados(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PokemonsList(pokemons: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PokemonsList extends StatelessWidget {
  const PokemonsList({Key? key, required this.pokemons}) : super(key: key);

  final List<Dados> pokemons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120,
            child: Card(
              color: Color.fromARGB(255, 203, 202, 202),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PokemonDetails(pokemon: pokemons[index]),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.network(
                          "${pokemons[index].img}",
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                       SizedBox(width: 50,),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(height: 30, width: 80,),
                            Text(
                              "Nome: ${pokemons[index].name}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tipo: ${pokemons[index].type}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // trailing: Text("ID: ${pokemons[index].id}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
