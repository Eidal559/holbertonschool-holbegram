import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('favorites').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }

          // Display saved images in a StaggeredGridView
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                String imageUrl = doc['imageUrl'];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(
                2,
                index.isEven ? 2 : 3,
              ),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          );
        },
      ),
    );
  }
}

class StaggeredTile {
  static Widget count(int i, int j) {
    return Container(); // Return an empty container or any other widget
  }
}

class StaggeredGridView {
  static countBuilder({required int crossAxisCount, required int itemCount, required ClipRRect Function(dynamic context, dynamic index) itemBuilder, required Function(dynamic index) staggeredTileBuilder, required double mainAxisSpacing, required double crossAxisSpacing}) {}
}
