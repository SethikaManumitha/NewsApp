import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../NewsCard.dart';
import '../../Services/ApiService.dart';
import '../ViewNewsScreen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  List<dynamic> topArticles = [];
  List<dynamic> latestArticles = [];
  bool isLoading = true;

  final ApiService _apiService = ApiService();

  Future<void> fetchNewsData() async {
    setState(() {
      isLoading = true;
    });

    final fetchedTopArticles = await _apiService.fetchTopNews();
    final fetchedLatestArticles = await _apiService.fetchLatestNews();

    setState(() {
      topArticles = fetchedTopArticles;
      latestArticles = fetchedLatestArticles;
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
              items: topArticles.take(4).map((article) {
                final imageUrl = article['urlToImage'] ?? 'https://via.placeholder.com/400x200';
                final title = article['title'] ?? 'No title';
                final description = article['description'] ?? 'No description';
                final date = article['publishedAt'] ?? 'No date';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewNewsScreen(
                          id: topArticles.indexOf(article),
                          title: title,
                          body: description,
                          date: date,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
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
                  ),
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
              itemCount: latestArticles.length,
              itemBuilder: (context, index) {
                final article = latestArticles[index];
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

