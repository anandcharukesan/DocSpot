import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Doctors'),
      ),
      body: Center(
        child: Text(
          'Your Bookmark Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}