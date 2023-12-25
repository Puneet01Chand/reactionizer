import 'package:example/models/posts_and_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactionizer/reactionizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Reactionizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ReactionModel> reactions = [
    ReactionModel(image: "assets/favHeart.png", id: 1),
    ReactionModel(image: "assets/happy.png", id: 2),
    ReactionModel(image: "assets/smile.png", id: 3),
    ReactionModel(image: "assets/in-love.png", id: 4),
    ReactionModel(image: "assets/mad.png", id: 5),
    ReactionModel(image: "assets/sad.png", id: 6),
    ReactionModel(image: "assets/surprised.png", id: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: PostModel.postsList.length,
                itemBuilder: (context, index) {
                  var items = PostModel.postsList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                items.avatar,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  items.location,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  PopupMenuButton<int>(
                                    surfaceTintColor: Colors.white,
                                    onSelected: (index) {},
                                    icon: const Icon(Icons.more_vert),
                                    itemBuilder: (context) => [
                                      // popupmenu item 1
                                      PopupMenuItem(
                                        value: 1,
                                        onTap: () {},
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Report",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // popupmenu item 2
                                    ],
                                    offset: const Offset(0, 40),
                                    color: Colors.white,
                                    elevation: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Page Builder View
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: items.posts.length,
                          physics: const ClampingScrollPhysics(),
                          // controller: controller.pageController,
                          itemBuilder: (BuildContext context, int index) {
                            var data = items.posts[index];
                            return Stack(
                              children: [
                                Image.asset(
                                  data,
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Heart And Comment Icons
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 0),
                            child: Row(
                              children: [
                                ReactionGenerator(
                                  reactions: reactions,
                                  placeHolder: ReactionModel(
                                      id: 0, image: "assets/blackHeart.png"),
                                  iconHeight: 25,
                                  iconWidth: 25,
                                  defaultValue: items.defaultReaction,
                                  onChange: (int id) {
                                    if (kDebugMode) {
                                      print("Id is ------>>>>>>  $id");
                                    }
                                  },
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  child: const ImageIcon(
                                    AssetImage(
                                      "assets/commentIcon.png",
                                    ),
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(items.caption),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
