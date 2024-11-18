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

  final List<String> imageUrls = [
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.menu),
              ],
            ),
            Text("News App"),
            Row(
              children: [
                Icon(Icons.bookmark),
                SizedBox(width: 15),
                Icon(Icons.search),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Fixed Top Section
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
                  NewsCard(id: 001, title: "Title 1", body: "Body 1", date: "Date 1"),
                  NewsCard(id: 002, title: "Title 2", body: "Body 2", date: "Date 2"),
                  NewsCard(id: 003, title: "Title 3", body: "Body 3", date: "Date 3"),
                  NewsCard(id: 004, title: "Title 4", body: "Body 4", date: "Date 4"),
                  NewsCard(id: 005, title: "Title 5", body: "Body 5", date: "Date 5"),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
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
}
