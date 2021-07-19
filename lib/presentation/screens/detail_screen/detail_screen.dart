import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geshin_app/bloc/genshin_data_bloc.dart';
import 'package:geshin_app/data/configurations/api/api_config.dart';
import 'package:geshin_app/data/models/genshin_data_model.dart';

class DetailScreen extends StatelessWidget {
  final CharacterModel character;
  const DetailScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl:
                          '$apiUrl/characters/${character.urlName}/portrait',
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.name ?? 'Failed to Load',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              character.description ?? 'Failed to Load',
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${character.rarity} ⭐',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
