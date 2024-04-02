import 'package:flutter/material.dart';
import 'package:promina/core/networking/api_service.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late Future<List<String>> _fetchImagesFuture;

  @override
  void initState() {
    super.initState();
    _fetchImagesFuture = ApiService().fetchImages(context);
  }

  Future<void> _refreshImages() async {
    try {
      setState(() {
        _fetchImagesFuture = ApiService().fetchImages(context);
      });
    } catch (error) {
      print('Error refreshing images: $error');
      // Handle error appropriately, e.g., display a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshImages,
      child: FutureBuilder<List<String>>(
        future: _fetchImagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final images = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle image tap
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
