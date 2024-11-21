import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'NewsCard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<String> imageUrls = [
    'https://via.placeholder.com/400x200/FF0000/FFFFFF?text=Image+1',
    'https://via.placeholder.com/400x200/00FF00/FFFFFF?text=Image+2',
    'https://via.placeholder.com/400x200/0000FF/FFFFFF?text=Image+3',
    'https://via.placeholder.com/400x200/FFFF00/FFFFFF?text=Image+4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("News App"),
        actions: const [
          Icon(Icons.bookmark),
          SizedBox(width: 15),
          Icon(Icons.search),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("Bookmarks"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Search"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Help"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
              items: imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Latest News",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NewsCard(
                    id: 1,
                    title: "Animals get boost from Southampton tree vandals",
                    body: "Details of the news here...",
                    date: "15 minutes ago",
                    imageUrl: "https://via.placeholder.com/100", // Replace with your image URL
                  ),
                  NewsCard(
                    id: 2,
                    title: "Animals get boost from Southampton tree vandals",
                    body: "Details of the news here...",
                    date: "15 minutes ago",
                    imageUrl: "https://via.placeholder.com/100", // Replace with your image URL
                  ),
                  NewsCard(
                    id: 3,
                    title: "Animals get boost from Southampton tree vandals",
                    body: "Details of the news here...",
                    date: "15 minutes ago",
                    imageUrl: "https://via.placeholder.com/100", // Replace with your image URL
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  _buildHeader(){
      return const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.orange
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text("MENU",style: TextStyle(color: Colors.white, fontSize: 30),)
            ],
          )
      );
  }
}
