import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final int? id;
  final String title;
  final String body;
  final String date;

  const NewsCard({
    Key? key,
    required this.id,
    required this.title,
    required this.body,
    required this.date,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          title: Text(title, style: const TextStyle(fontSize: 20.0)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date),
            ],
          ),
        ),
      ),
    );
  }
}

