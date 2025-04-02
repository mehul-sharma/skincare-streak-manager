import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html' as html; // Required for Flutter Web
import 'dart:io';

class DailySkincareScreen extends StatefulWidget {
  const DailySkincareScreen({Key? key}) : super(key: key);

  @override
  _DailySkincareScreenState createState() => _DailySkincareScreenState();
}

class _DailySkincareScreenState extends State<DailySkincareScreen> {
  final List<Map<String, dynamic>> skincareItems = [
    {
      'name': 'Cleanser',
      'details': 'Cetaphil Gentle Skin Cleanser',
      'time': '8:00 PM',
      'checked': false,
      'imageUrl': null, // Added imageUrl to store Firebase Storage URL
    },
    {
      'name': 'Toner',
      'details': 'Thayers Witch Hazel Toner',
      'time': '8:02 PM',
      'checked': false,
      'imageUrl': null,
    },
    {
      'name': 'Moisturizer',
      'details': 'Kiehl Ultra Facial Cream',
      'time': '8:04 PM',
      'checked': false,
      'imageUrl': null,
    },
    {
      'name': 'Sunscreen',
      'details': 'Supergoop Unseen Sunscreen SPF 40',
      'time': '8:06 PM',
      'checked': false,
      'imageUrl': null,
    },
    {
      'name': 'Lip Balm',
      'details': 'Glossier Birthday Balm Dotcom',
      'time': '8:08 PM',
      'checked': false,
      'imageUrl': null,
    },
  ];

  Future<void> _openCamera(int index) async {
    final ImagePicker picker = ImagePicker();

    if (kIsWeb) {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final bytes = await image.readAsBytes();
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);

        setState(() {
          skincareItems[index]['checked'] = true;
          skincareItems[index]['time'] = _getCurrentTime();
          skincareItems[index]['imageUrl'] = url; // Store web url
        });

        print("Image captured: $url");
      }
    } else {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        String fileName = "skincare_${DateTime.now().millisecondsSinceEpoch}.jpg";
        Reference ref = FirebaseStorage.instance.ref().child('skincare/$fileName');
        await ref.putFile(File(image.path));
        String downloadUrl = await ref.getDownloadURL();

        setState(() {
          skincareItems[index]['checked'] = true;
          skincareItems[index]['time'] = _getCurrentTime();
          skincareItems[index]['imageUrl'] = downloadUrl; // Store Firebase Storage URL
        });

        print("Image uploaded: $downloadUrl");
      }
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Daily Skincare',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: skincareItems.length,
                itemBuilder: (context, index) {
                  final item = skincareItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              item['checked'] = !item['checked'];
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: item['checked'] ? Colors.grey[200] : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: item['checked']
                                ? const Icon(Icons.check, size: 20, color: Colors.black)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item['details'],
                              style: TextStyle(fontSize: 14, color: Colors.pink),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _openCamera(index),
                          child: const Icon(Icons.camera_alt_outlined, size: 20, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['time'],
                          style: TextStyle(fontSize: 14, color: Colors.pink),
                        ),
                        if (item['imageUrl'] != null) // Display image if available
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: kIsWeb ? Image.network(item['imageUrl']) : Image.file(File(Uri.parse(item['imageUrl']).toFilePath())),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}