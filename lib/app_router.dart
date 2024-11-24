// ignore_for_file: public_member_api_docs, sort_constructors_first

import "package:bloc_course/data/models/character.dart";
import "package:bloc_course/data/web_services/characters_web_services.dart";
import "package:flutter/material.dart";

import "package:bloc_course/core/config/constants/strings.dart";
import "package:bloc_course/data/repository/characters_repository.dart";
import "package:bloc_course/logic/cubit/characters_cubit.dart";
import "package:bloc_course/presentation/screens/character_details_screen.dart";
import "package:bloc_course/presentation/screens/characters_screen.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen(character: character));
    }
    return null;
  }
}
