import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harry',
  'Ileana',
  'Joseph',
  'Kencaid',
  'Larry',
];

final ticckerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(
      seconds: 1,
    ),
    (i) => i + 1,
  ),
);

final namesProvider =
    StreamProvider((ref) => ref.watch(ticckerProvider.stream).map(
          (count) => names.getRange(0, count),
        ));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(names.elementAt(index)),
                );
              });
        },
        error: (error, stackTrace) => const Center(
          child: Text('Reached the end of the List!'),
        ),
        loading: () => const Padding(
          padding: EdgeInsets.all(64.0),
          child: Center(
            child: LinearProgressIndicator(
              color: Colors.pink,
              minHeight: 16,
            ),
          ),
        ),
      ),
    );
  }
}
