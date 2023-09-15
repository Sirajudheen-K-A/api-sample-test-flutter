import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_sample_test/search_bar_widget.dart';
import 'package:flutter_api_sample_test/wishlist_card.dart';
import 'package:http/http.dart' as http;

class WishlistItem {
  final String title;
  final String description;
  final double price;
  final String picture;

  WishlistItem({
    required this.title,
    required this.description,
    required this.price,
    required this.picture,
  });
}

class HomePage extends StatefulWidget {
  final String authToken;

  const HomePage(
      this.authToken, {
        super.key,
      });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WishlistItem> wishlistItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWishlistItem();
  }

  Future<void> _fetchWishlistItem() async {
    final response = await http.get(
      Uri.parse("https://codespence.com/public/api/savedPosts?embed=post"),
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final items = responseBody['result']['data'];

      final wishlist = List<WishlistItem>.from(
        items.map(
              (item) {
            return WishlistItem(
                title: item['post']['title'],
                description: item['post']['description'],
                price: double.parse(item['post']['price']),
                picture: item['post']['picture']['url']['big']);
          },
        ),
      );

      setState(() {
        wishlistItems = wishlist;
      });
    } else {
      print("Failed to fetch wishlist items");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Wishlist",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Expanded(child: _buildWishList()),
          ],
        ),
      ),
    );
  }

  Widget _buildWishList() {
    if (wishlistItems.isEmpty) {
      return const Center(
        child: Text("No wishlist items available"),
      );
    } else {
      return ListView.separated(
          itemCount: wishlistItems.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            final item = wishlistItems[index];

            return WishlistCard(item: item);
          });
    }
  }
}





