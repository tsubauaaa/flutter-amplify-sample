import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_sample/amplifyconfiguration.dart';
import 'package:flutter_amplify_sample/models/ModelProvider.dart';
import 'package:amplify_flutter/amplify.dart';

class AmplifyPage extends StatefulWidget {
  const AmplifyPage({Key? key}) : super(key: key);

  @override
  _AmplifyPageState createState() => _AmplifyPageState();
}

class _AmplifyPageState extends State<AmplifyPage> {
  List<Post> posts = [];
  bool isSynced = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    AmplifyDataStore datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    Amplify.addPlugin(datastorePlugin);
    try {
      await Amplify.addPlugin(AmplifyAPI());
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }

    Stream<QuerySnapshot<Post>> stream =
        Amplify.DataStore.observeQuery(Post.classType);
    stream.listen((QuerySnapshot<Post> snapshot) {
      setState(() {
        posts = snapshot.items;
        isSynced = snapshot.isSynced;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Amplify Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Write'),
              onPressed: () async {
                Post newPost = Post(
                    title: 'New Post begin saved', rating: 15, status: 'DRAFT');
                await Amplify.DataStore.save(newPost);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () async {
                (await Amplify.DataStore.query(Post.classType)).forEach(
                  (element) async {
                    try {
                      await Amplify.DataStore.delete(element);
                      print('Deleted a post');
                    } on DataStoreException catch (e) {
                      print('Deleted failed: $e');
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 64),
            Text(posts.isNotEmpty ? posts.toString() : 'There are no data.'),
          ],
        ),
      ),
    );
  }
}
