import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:self_park/language/language_items.dart';

class OperatorHome extends StatefulWidget {
  const OperatorHome({super.key});

  @override
  State<OperatorHome> createState() => _OperatorHomeState();
}

class _OperatorHomeState extends State<OperatorHome> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: deviceOrientation == Orientation.portrait
              ? const LokasyonColumn()
              : const LokasyonRow(),
        ));
  }
}

class LokasyonColumn extends StatefulWidget {
  const LokasyonColumn({super.key});

  @override
  State<LokasyonColumn> createState() => _LokasyonColumnState();
}

class _LokasyonColumnState extends State<LokasyonColumn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Send  Location',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            Column(
              children: [
                const SizedBox(
                  width: 600,
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.lokasyonTitle,
                      prefixIconColor: Colors.grey,
                      prefixIcon: Icon(Icons.add_location_alt_sharp),
                    ),
                  ),
                ),
                SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          onPressed: () {},
                          child: const Text('OK')),
                    ))
              ],
            ),
            Flexible(
              child: Image.network(
                  'https://storage.googleapis.com/otosor/cms/uploads/a60da09137bd4decb1be82159afec82c.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class LokasyonRow extends StatefulWidget {
  const LokasyonRow({super.key});

  @override
  State<LokasyonRow> createState() => _LokasyonRowState();
}

class _LokasyonRowState extends State<LokasyonRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Send Location',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            Column(
              children: [
                const SizedBox(
                  width: 600,
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.lokasyonTitle,
                      prefixIconColor: Colors.grey,
                      prefixIcon: Icon(Icons.add_location_alt_sharp),
                    ),
                  ),
                ),
                SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {},
                            child: const Text('OK')),
                      ),
                    ))
              ],
            ),
            Flexible(
              child: Flexible(
                child: Image.network(
                    'https://storage.googleapis.com/otosor/cms/uploads/a60da09137bd4decb1be82159afec82c.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
