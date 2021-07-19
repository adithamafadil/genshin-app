import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geshin_app/bloc/genshin_data_bloc.dart';
import 'package:geshin_app/data/configurations/api/api_config.dart';
import 'package:geshin_app/data/models/genshin_data_model.dart';
import 'package:geshin_app/presentation/screens/detail_screen/detail_screen.dart';
import 'package:geshin_app/presentation/themes/colors/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Color _getButtonColor(String vision) {
    switch (vision.toLowerCase()) {
      case 'anemo':
        return GenshinColors.anemo;
      case 'geo':
        return GenshinColors.geo;
      case 'pyro':
        return GenshinColors.pyro;
      case 'cryo':
        return GenshinColors.cryo;
      case 'hydro':
        return GenshinColors.hydro;
      case 'electro':
        return GenshinColors.electro;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<GenshinDataBloc, GenshinDataState>(
          builder: (context, state) {
            return state.fetchState.maybeWhen(
              loading: () {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()));
              },
              success: () {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.characterDetailList.length,
                  itemBuilder: (context, index) {
                    CharacterModel character = state.characterDetailList[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                _getButtonColor(character.vision ?? '')),
                          ),
                          onPressed: () {
                            context.read<GenshinDataBloc>().add(
                                GenshinDataEvent.getSelectedCharacterDetail(
                                    selectedCharacterDetail: character));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(character: character),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    '$apiUrl/characters/${character.urlName.toString().toLowerCase()}/icon',
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CircularProgressIndicator(
                                        value: progress.downloaded.toDouble()),
                                  );
                                },
                              ),
                              Text(
                                character.name.toString().toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          )),
                    );
                  },
                );
              },
              orElse: () {
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
