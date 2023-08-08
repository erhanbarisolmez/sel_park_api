import 'package:flutter/material.dart';
import 'package:self_park/core/db/connect.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.white24,
          );
        },
        itemBuilder: (context, index) {
          index += 1;

          return SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [Text('$index. data')]),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Update'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Delete'),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
