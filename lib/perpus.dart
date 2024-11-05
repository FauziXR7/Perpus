import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Perpus extends StatelessWidget {
  const Perpus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const PerpusHome(),
    );
  }
}

class PerpusHome extends StatefulWidget {
  const PerpusHome({super.key});

  @override
  _PerpusHomeState createState() => _PerpusHomeState();
}

class _PerpusHomeState extends State<PerpusHome> {
  int _selectedIndex = 0;
  List<Map<String, String>> wishlist = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildPerpusMainHome();
      case 1:
        return _buildWishlist();
      case 2:
        return _buildTransactions();
      default:
        return _buildPerpusMainHome();
    }
  }

  Widget _buildPerpusMainHome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Library Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Explore Our Collection',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBookRow(
                    'Buffett', 'Roger Lowenstein', '4.0', 'assets/buffett.png'),
                _buildBookRow('48 Laws Of Power', 'Robert Greene', '5.0',
                    'assets/48law.png'),
                _buildBookRow(
                    'Art Of War', 'Andri Wang', '4.5', 'assets/artofwar.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookRow(
      String title, String author, String rating, String coverPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(coverPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            'Author: $author',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            'Rating: $rating',
            style: const TextStyle(fontSize: 12, color: Colors.amber),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              _addToWishlist(title, author, coverPath);
            },
            child: const Text("Add to Wishlist"),
          ),
        ],
      ),
    );
  }

  void _addToWishlist(String title, String author, String coverPath) {
    setState(() {
      wishlist.add({
        'title': title,
        'author': author,
        'coverPath': coverPath,
      });
    });
  }

  Widget _buildWishlist() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text("Your wishlist is empty."),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final book = wishlist[index];
                return ListTile(
                  leading: Image.asset(
                    book['coverPath']!,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(book['title']!),
                  subtitle: Text('Author: ${book['author']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        wishlist.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildTransactions() {
    return Scaffold();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_basket),
              title: const Text('Wish list'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Transactions'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Wish list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transactions',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
