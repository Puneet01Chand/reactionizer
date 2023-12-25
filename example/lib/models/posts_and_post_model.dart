class PostModel {
  String avatar;
  String name;
  List<String> posts;
  String caption;
  String location;
  int? defaultReaction;

  PostModel(
      {required this.avatar,
      required this.name,
      required this.posts,
      this.defaultReaction,
      required this.caption,
      required this.location});

  static List<PostModel> postsList = [
    PostModel(
        avatar: "assets/avatar01.jpg",
        name: "Sophia Carmichael",
        posts: [
          "assets/anime_demon_slayer01.png",
          "assets/anime_demon_slayer02.jpeg",
          "assets/anime_demon_slayer03.jpg",
          "assets/anime_demon_slayer04.png",
        ],
        caption:
            "🌟 Unleash the demons, sharpen your blades! The highly anticipated Demon Slayer movie is dropping in 2024! 🎬🔥 Brace yourselves for an epic journey beyond the realms. #DemonSlayerMovie2024 #PrepareForAdventure",
        location: 'Ember Valley'),
    PostModel(
        avatar: "assets/avatar02.jpg",
        name: "Noah Anderson",
        posts: [
          "assets/aero_science.jpg",
        ],
        caption:
            "🚀 The skies just got a whole lot clearer! Introducing AeroStar-2023, the satellite set to redefine aero science as we know it. 🌐✨ Join us on this interstellar journey of discovery and innovation! 🛰️🔍 #AeroStar2023 #SkyIsNoLimit #SpaceScienceRevolution",
        defaultReaction: 1,
        location: 'Solaris Junction'),
    PostModel(
        avatar: "assets/avatar04.jpg",
        name: "Liam Donovan",
        posts: [
          "assets/animal02.jpg",
          "assets/animal04.jpg",
          "assets/animal03.jpg",
        ],
        caption:
            "🐅🐼🦊 Unleashing a trio of wild wonders! Did you know tigers are aquatic acrobats, pandas have a bamboo obsession, and foxes are nature's playful tricksters? Nature's symphony of diversity never ceases to amaze! 🌿🌍 #WildLifeWonders #TigerTales #PandaPassion #FoxFables",
        defaultReaction: 1,
        location: 'Azure Harbor'),
  ];
}
