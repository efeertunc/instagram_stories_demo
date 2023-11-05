import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_stories_demo/cubit/home_page_cubit.dart';
import 'package:instagram_stories_demo/widget/home_card.dart';

import '../state/home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomePageCubit>().getStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram"),
      ),
      body: SizedBox(
        height: 50,
        child: BlocConsumer<HomePageCubit, HomePageState>(
            listener: (context, state) {
          switch (state.runtimeType) {
            case HomePageStateFailure:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("Error: ${(state as HomePageStateFailure).error}")));
              break;
          }
        }, builder: (context, state) {
          switch (state.runtimeType) {
            case HomePageStateLoading:
              return const Center(child: CircularProgressIndicator());

            case HomePageStateSuccess:
              if ((state as HomePageStateSuccess).data.isNotEmpty) {
                var homeCardList = state.data;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCardList.length,
                    itemBuilder: (context, index) {
                      return HomeCard(index, homeCardList);
                    });
              } else {
                return const Center(child: Text("No stories available"));
              }

            case HomePageStateFailure:
              return Center(
                  child:
                      Text("Error: ${(state as HomePageStateFailure).error}"));

            default:
              return const Center(child: Text("Unexpected state"));
          }
        }),
      ),
    );
  }
}
