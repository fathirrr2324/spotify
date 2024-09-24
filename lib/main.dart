import 'package:flutter/material.dart';

void main() {
  runApp(SpotifyApp());
}

class SpotifyApp extends StatelessWidget {
  get size => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpotifyHome(),
    );
  }
}

class SpotifyHome extends StatefulWidget {
  @override
  _SpotifyHomeState createState() => _SpotifyHomeState();
}

class _SpotifyHomeState extends State<SpotifyHome>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Spotify',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Search'),
            Tab(text: 'Library'),
          ],
          indicatorColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildSearchTab(),
          _buildLibraryTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildSectionTitle('Recently Played'),
        _buildHorizontalList([
          {"title": "Viva la Vida", "imageUrl": "assets/vivalavida.jpg"},
          {"title": "Yellow", "imageUrl": "assets/coldplay.jpg"},
          {"title": "Radio", "imageUrl": "assets/lanadelrey.jpg"},
          {"title": "Just the Way You Are", "imageUrl": "assets/bruno.jpg"},
        ]),
        SizedBox(height: 16),
        _buildSectionTitle('Your Playlists'),
        _buildGrid([
          {"title": "Chill Vibes", "imageUrl": "assets/chill.jpg"},
          {"title": "Oasis juga A?", "imageUrl": "assets/oasis.jpg"},
          {"title": "Party Hits", "imageUrl": "assets/fly.jpg"},
          {"title": "Focus", "imageUrl": "assets/random.jpg"},
        ]),
        SizedBox(height: 16),
        _buildSectionTitle('Popular Albums'),
        _buildHorizontalList([
          {
            "title": "Future Nostalgia",
            "imageUrl": "assets/futurenostalgia.jpg"
          },
          {"title": "After Hours", "imageUrl": "assets/afterhours.jpg"},
          {"title": "Hollywood's Bleeding", "imageUrl": "assets/hollywood.jpg"},
        ]),
      ],
    );
  }

  Widget _buildSearchTab() {
    return Center(
      child: Text(
        'Search Tab',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildLibraryTab() {
    return Center(
      child: Text(
        'Library Tab',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHorizontalList(List<Map<String, String>> items) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    item["imageUrl"]!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item["title"]!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(List<Map<String, String>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 2 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return GestureDetector(
          onTap: () {
            // Action on playlist tap
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item["imageUrl"]!,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                item["title"]!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
