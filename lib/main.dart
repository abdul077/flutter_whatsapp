import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> contacts = [
    Contact(name: 'Ayesha', lastMessage: 'Hey! How are you?', timestamp: '2:30 PM'),
    Contact(name: 'Zoya', lastMessage: 'Let’s meet today.', timestamp: '1:00 PM'),
    Contact(name: 'Mehwish', lastMessage: 'Where are you?', timestamp: '12:45 PM'),
    Contact(name: 'Hina', lastMessage: 'Can you send me the file? Please', timestamp: '10:30 AM'),
    Contact(name: 'Rabia', lastMessage: 'Good morning! Have a nice day', timestamp: 'Yesterday'),
    Contact(name: 'Sumaira', lastMessage: 'Lets go for a walk', timestamp: '12:45 PM'),
    Contact(name: 'Ambar', lastMessage: 'Please call me back', timestamp: '10:30 AM'),
    Contact(name: 'Shazia', lastMessage: 'Waiting for you', timestamp: 'Yesterday'),
  ];

  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  // You can add filter logic here to filter contacts by the search query
                });
              },
            ),
          ),
          // List of contacts
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactTile(contact: contact);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a new chat screen when the button is pressed
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures labels are displayed
        selectedItemColor: Colors.black,  // Black color for selected icon and text
        unselectedItemColor: Colors.black54, // Light black for unselected icons and text
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
}

class Contact {
  final String name;
  final String lastMessage;
  final String timestamp;

  Contact({required this.name, required this.lastMessage, required this.timestamp});
}

class ContactTile extends StatelessWidget {
  final Contact contact;

  const ContactTile({required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Text(contact.name[0], style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(contact.timestamp),
      onTap: () {
        // Implement navigation to chat screen
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Contact> contacts = [
    Contact(name: 'John', lastMessage: 'Hey! How are you?', timestamp: '2:30 PM'),
    Contact(name: 'Sara', lastMessage: 'Let’s meet tomorrow.', timestamp: '1:00 PM'),
    Contact(name: 'Mike', lastMessage: 'Where are you?', timestamp: '12:45 PM'),
    Contact(name: 'David', lastMessage: 'Can you send me the file?', timestamp: '10:30 AM'),
    Contact(name: 'Alice', lastMessage: 'Good morning!', timestamp: 'Yesterday'),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contacts
        .where((contact) => contact.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results.map((contact) => ContactTile(contact: contact)).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = contacts
        .where((contact) => contact.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions.map((contact) => ContactTile(contact: contact)).toList(),
    );
  }
}
