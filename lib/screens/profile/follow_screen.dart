import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/dto/follow_relation_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_drawer.dart';

class FollowScreen extends StatelessWidget {
  final User user;
  late ProfileBloc bloc;
  ScrollController _followerScrollController =
      ScrollController(keepScrollOffset: true);
  int page = 0;
  int size = 20;
  List<FollowRelationDto> followers = [];
  String usernameSearch = '';

  FollowScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()
        ..add(ProfileGetFollowers(userId: user.id, page: page, size: size))
        ..add(ProfileCountFollowRequest(userId: user.id)),
      child: Builder(builder: (context) => _buildView(context)),
    );
  }

  Widget _buildView(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    _followerScrollController.addListener(() {
      if (_followerScrollController.position.pixels ==
          _followerScrollController.position.maxScrollExtent) {
        bloc.add(ProfileGetFollowers(
            userId: user.id,
            page: page + 1,
            size: size,
            username: usernameSearch));
        page += 1;
      }
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.black,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                '${user.username}',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
            ],
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: AppColor.black,
          child: ProfileDrawer(),
        ),
        body: _buildViewFollowers(context));
  }

  Widget _buildViewFollowers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black26,
            ),
            child: TextFormField(
              onChanged: (value) {
                if (value != usernameSearch) {
                  usernameSearch = value;
                  page = 0;
                  followers.clear();
                  bloc.add(ProfileGetFollowers(
                      userId: user.id,
                      page: page,
                      size: size,
                      username: usernameSearch));
                }
              },
              decoration: InputDecoration(
                  hintText: "Search",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.deepOrangeAccent,
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Stack(children: [
                  CircleAvatar(
                    radius: 25,
                    child: Image.asset(
                      "assets/images/anonymous.png",
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      height: 20,
                      width: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          bloc: bloc,
                          buildWhen: (previous, current) =>
                              current is ProfileCountFollowRequestSuccess,
                          builder: (context, state) {
                            int total = 0;
                            if (state is ProfileCountFollowRequestSuccess) {
                              total = state.totalRequest;
                            }
                            if (total > 99) {
                              return Center(child: Text('99✚'));
                            }
                            return Center(child: Text('$total'));
                          },
                        ),
                      )),
                ]),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow requests',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Approve or ignore requests')
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              width: 0.2,
              color: Colors.grey.withOpacity(0.5),
            ))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'All followers',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder(
            bloc: bloc,
            buildWhen: (previous, current) =>
                current is ProfileLoading ||
                current is ProfileGetFollowerSuccess,
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/loading.gif"),
                            fit: BoxFit.cover)),
                  ),
                );
              }
              return Container();
            },
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            bloc: bloc,
            buildWhen: (previous, current) =>
                current is ProfileGetFollowerSuccess,
            builder: (context, state) {
              if (state is ProfileGetFollowerSuccess) {
                followers.addAll(state.followRelations);
              }
              return Expanded(
                  child: ListView.builder(
                      controller: _followerScrollController,
                      itemCount: followers.length,
                      addAutomaticKeepAlives: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final follower = followers[index];
                        return ListTile(
                          key: ValueKey(follower.user.id),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: CachedNetworkImage(
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Image.asset('assets/images/loading.gif');
                              },
                              imageUrl: minioHost + follower.user.avatar.url,
                            ),
                          ),
                          title: Row(
                            children: [
                              Text('${follower.user.username}'),
                              SizedBox(
                                width: 10,
                              ),
                              follower.isFollowing == true
                                  ? Container()
                                  : Text(
                                      '• Follow',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5))),
                                child: Text(
                                  'Remove',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        );
                      }));
            },
          ),
        ],
      ),
    );
  }
}
