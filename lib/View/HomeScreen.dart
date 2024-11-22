import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Models/NewsCard.dart';
import '../Services/ApiService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<dynamic> articles = [];
  bool isLoading = true;

  final ApiService _apiService = ApiService();

  Future<void> fetchNewsData() async {
    setState(() {
      isLoading = true;
    });
    final fetchedArticles = await _apiService.fetchNews();
    setState(() {
      articles = fetchedArticles;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

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
            _buildDrawerItem(Icons.home, "Home", () {}),
            _buildDrawerItem(Icons.bookmark, "Bookmarks", () {}),
            _buildDrawerItem(Icons.search, "Search", () {}),
            _buildDrawerItem(Icons.settings, "Settings", () {}),
            const Divider(),
            _buildDrawerItem(Icons.help, "Help", () {}),
            _buildDrawerItem(Icons.info, "About", () {}),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : articles.isEmpty
          ? const Center(child: Text("No news available."))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
              items: articles.take(4).map((article) {
                final imageUrl = article['urlToImage'] ?? 'https://via.placeholder.com/400x200';
                final title = article['title'] ?? 'No title';
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'https://via.placeholder.com/400x200',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(thickness: 2, indent: 20, endIndent: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Latest News", style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsCard(
                  id: index,
                  title: article['title'] ?? 'No title',
                  body: article['description'] ?? 'No description',
                  date: article['publishedAt'] ?? 'No date',
                  imageUrl: article['urlToImage'] ?? 'https://via.placeholder.com/100',
                );
              },
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(color: Colors.orange),
      child: Center(
        child: Text("MENU", style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
