import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_responsive_ui/config/palette.dart';
import 'package:fb_responsive_ui/data/data.dart';
import 'package:fb_responsive_ui/models/post_model.dart';
import 'package:fb_responsive_ui/models/story_model.dart';
import 'package:fb_responsive_ui/models/user_model.dart';
import 'package:fb_responsive_ui/widgets/CircularIconButton.dart';
import 'package:fb_responsive_ui/widgets/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: const Text("facebook",
                style: TextStyle(
                  color: Palette.facebookBlue,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                )),
            centerTitle: false,
            floating: true,
            actions: [
              CircularIconButton(
                  iconData: Icons.search, iconSize: 30.0, onPressed: () {}),
              CircularIconButton(
                  iconData: MdiIcons.facebookMessenger,
                  iconSize: 30.0,
                  onPressed: () {})
            ],
          ),
          createPostContainer(currentUser),
          createRoom(onlineUsers),
          createStories(currentUser, stories),
          createFeedPostContainer(posts)
        ],
      ),
    );
  }

  Widget createPostContainer(User currentUser) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                createProfileAvatar(false, currentUser.imageUrl),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                        hintText: "What's up on your mind?"),
                    onTap: () => print("update Status"),
                  ),
                )
              ],
            ),
            const Divider(
              height: 10.0,
              thickness: 0.5,
            ),
            SizedBox(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => print("Live"),
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.red,
                    ),
                    label: const Text("Live"),
                  ),
                  const VerticalDivider(
                    width: 10.0,
                    thickness: 0.5,
                  ),
                  TextButton.icon(
                    onPressed: () => print("Photo"),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: const Text("Photo"),
                  ),
                  const VerticalDivider(
                    width: 10.0,
                    thickness: 0.5,
                  ),
                  TextButton.icon(
                    onPressed: () => print("Room"),
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.purpleAccent,
                    ),
                    label: const Text("Room"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createRoom(List<User> onlineUsers) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 5.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 60.0,
          color: Colors.white,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              scrollDirection: Axis.horizontal,
              itemCount: 1 + onlineUsers.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _createRoomButton(),
                  );
                }
                final user = onlineUsers[index - 1];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: createProfileAvatar(true, user.imageUrl),
                );
              }),
        ),
      ),
    );
  }

  Widget _createRoomButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: const BorderSide(width: 2, color: Palette.facebookBlue),
        ),
        onPressed: () {},
        child: Row(
          children: [
            ShaderMask(
                shaderCallback: (Rect bounds) =>
                    Palette.createRoomGradient.createShader(bounds),
                child: const Icon(
                  Icons.video_call,
                  size: 35.0,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 3.0,
            ),
            const Text("Create\nRoom")
          ],
        ));
  }

  createStories(User currentUser, List<Story> stories) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200.0,
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1 + stories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                height: double.infinity,
                width: 110.0,
                child: (index == 0)
                    ? addUserStories(true, currentUser.imageUrl, stories[0])
                    : addUserStories(
                        false, currentUser.imageUrl, stories[index - 1]),
              );
            }),
      ),
    );
  }

  Widget addUserStories(bool isUser, String imageUrl, Story story) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CachedNetworkImage(
          imageUrl: isUser? imageUrl: story.imageUrl,
          height: double.infinity,
          fit: BoxFit.fitHeight,
        ),
      ),
      Container(
        height: double.infinity,
        width: 110.0,
        decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0)),
      ),
      Positioned(
        top: 8.0,
        left: 8.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: isUser
              ? const Icon(
                  Icons.add,
                  size: 35.0,
                )
              : createProfileAvatar(false, story.user.imageUrl),
        ),
      ),
      Positioned(
          left: 6.0,
          right: 4.0,
          bottom: 8.0,
          child: Text(
            isUser ? "Add to Story" : story.user.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ))
    ]);
  }

  createFeedPostContainer(List<Post> posts) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
            return createFeedContainer(posts[index]);
          },
          childCount: posts.length
        )

    );
  }

  createFeedContainer(Post post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createProfileAvatar(false, post.user.imageUrl),
                SizedBox(width: 8.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.user.name),
                      Text ("create ${post.timeAgo} ", style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),)
                    ],
                  ),
                ),
                Icon(Icons.more_horiz_rounded )
              ],
            ),
          ),
          const SizedBox(height: 8.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(post.caption),
          ),
          const SizedBox(height: 8.0,),
          post.imageUrl == "" ? const SizedBox.shrink() : CachedNetworkImage(imageUrl: post.imageUrl)
        ],
      ),
    );
  }
}
