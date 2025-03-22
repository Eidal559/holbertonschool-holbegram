import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch images from Firestore
  Stream<List<String>> fetchImages() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<String>>(
        stream: fetchImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No images found"));
          }

          // Display images in a StaggeredGridView
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    snapshot.data![index],
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
    return Container(); // or any other default widget
  }
}

class StaggeredGridView {
  static countBuilder({required int crossAxisCount, required int itemCount, required ClipRRect Function(dynamic context, dynamic index) itemBuilder, required Function(dynamic index) staggeredTileBuilder, required double mainAxisSpacing, required double crossAxisSpacing}) {}
}
