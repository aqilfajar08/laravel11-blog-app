import 'package:flutter/material.dart';
import 'package:flutter_laravel_blog/pages/logout_blog_page.dart';
import 'package:flutter_laravel_blog/pages/posts_blog_page.dart';
import 'package:flutter_laravel_blog/pages/profile_blog.dart';
import 'package:flutter_laravel_blog/services/user_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Tambahkan variabel untuk melacak tab aktif

  List<Content> content = [
    Content(
      nama: 'Fahri',
      title: 'Lorem Ipsum',
      image: 'images/foto.jpg',
    ),
    Content(
      nama: 'Ariq',
      title: 'Lorem Ipsum',
      image: 'images/foto.jpg',
    ),
    Content(
      nama: 'Aqil',
      title: 'Lorem Ipsum',
      image: 'images/foto.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Blog App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                logut().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context)=> LogoutBlogPage()), (route) => false)
                    });
              },
              icon: const Icon(Icons.exit_to_app),
              color: Colors.white,
            ),
          )
        ],
      ),
      body: _currentIndex == 0 ? PostsBlogPage() : ProfileBlog(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
          currentIndex: _currentIndex,
          onTap: (val) {
            setState(() {
              _currentIndex = val;
            });
          },
        ),
      ),
    );
  }
}

class Content {
  String nama;
  String title;
  String image;

  Content({required this.nama, required this.title, required this.image});
}
