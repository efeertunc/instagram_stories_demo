import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_stories_demo/cubit/home_page_cubit.dart';
import 'package:instagram_stories_demo/widget/home_card.dart';

import '../model/Story.dart';
import '../state/home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  void _fetchStories() {
    context.read<HomePageCubit>().getStories();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Instagram"),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      height: 50,
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: _stateListener,
        builder: _stateBuilder,
      ),
    );
  }

  void _stateListener(BuildContext context, HomePageState state) {
    if (state is HomePageStateFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${state.error}")),
      );
    }
  }

  Widget _stateBuilder(BuildContext context, HomePageState state) {
    if (state is HomePageStateLoading) {
      return _buildLoading();
    } else if (state is HomePageStateSuccess) {
      return _buildSuccessState(state);
    } else if (state is HomePageStateFailure) {
      return _buildErrorState(state);
    } else {
      return _buildUnexpectedState();
    }
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccessState(HomePageStateSuccess state) {
    if (state.data.isNotEmpty) {
      return _buildListView(state.data);
    } else {
      return const Center(child: Text("No stories available"));
    }
  }

  Widget _buildListView(List<Story> homeCardList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: homeCardList.length,
      itemBuilder: (context, index) {
        return HomeCard(index, homeCardList);
      },
    );
  }

  Widget _buildErrorState(HomePageStateFailure state) {
    return Center(child: Text("Error: ${state.error}"));
  }

  Widget _buildUnexpectedState() {
    return const Center(child: Text("Unexpected state"));
  }
}
