import 'package:flutter/material.dart';

class ProfileBlog extends StatefulWidget {
  const ProfileBlog({super.key});

  @override
  State<ProfileBlog> createState() => _ProfileBlogState();
}

class _ProfileBlogState extends State<ProfileBlog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Profile'),),
    );
  }
}