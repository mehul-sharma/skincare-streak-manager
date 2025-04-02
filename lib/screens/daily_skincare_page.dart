import 'package:flutter/material.dart';

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
      'checked': true
    },
    {
      'name': 'Toner',
      'details': 'Thayers Witch Hazel Toner',
      'time': '8:02 PM',
      'checked': true
    },
    {
      'name': 'Moisturizer',
      'details': 'Kiehl Ultra Facial Cream',
      'time': '8:04 PM',
      'checked': false
    },
    {
      'name': 'Sunscreen',
      'details': 'Supergoop Unseen Sunscreen SPF 40',
      'time': '8:06 PM',
      'checked': false
    },
    {
      'name': 'Lip Balm',
      'details': 'Glossier Birthday Balm Dotcom',
      'time': '8:08 PM',
      'checked': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return Card(
                    color: Colors.pink[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: item['checked'],
                        onChanged: (value) {
                          setState(() {
                            item['checked'] = value;
                          });
                        },
                      ),
                      title: Text(item['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item['details'],
                          style: const TextStyle(color: Colors.pink)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.photo_camera, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(item['time'],
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
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
