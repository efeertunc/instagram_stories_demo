import 'package:flutter/material.dart';

import '../model/Story.dart';

class StoryAvatar extends StatelessWidget {
  final Story? user;

  StoryAvatar({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          _buildAvatar(user?.profileUrl),
          const SizedBox(
            height: 4,
          ),
          _buildUsername(user?.username),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    return Container(
      width: 85,
      height: 85,
      decoration: _outerGradientDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: _imageContainer(imageUrl),
          ),
        ),
      ),
    );
  }

  BoxDecoration _outerGradientDecoration() {
    return const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(243, 18, 119, 1.0),
          Color.fromRGBO(129, 52, 175, 1.0),
          Color.fromRGBO(236, 28, 117, 1.0),
          Color.fromRGBO(245, 133, 41, 1.0),
          Color.fromRGBO(254, 218, 119, 1.0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  Widget _imageContainer(String? imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildUsername(String? username) {
    return Text(
      username ?? '',
    );
  }
}
