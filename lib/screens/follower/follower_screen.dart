import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/dto/follow_relation_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/follower/bloc/follower_bloc.dart';
import 'package:social_network_mobile_ui/screens/follower/components/follow_request.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_drawer.dart';

class FollowerScreen extends StatelessWidget {
  final User user;
  late FollowerBloc bloc;
  ScrollController _followerScrollController =
      ScrollController(keepScrollOffset: true);
  int page = 0;
  int size = 20;
  List<FollowRelationDto> followers = [];
  String usernameSearch = '';

  FollowerScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowerBloc()
        ..add(GetFollowers(userId: user.id, page: page, size: size))
        ..add(CountFollowRequest(userId: user.id)),
      child: Builder(builder: (context) => _buildView(context)),
    );
  }

  Widget _buildView(BuildContext context) {
    bloc = BlocProvider.of<FollowerBloc>(context);
    _followerScrollController.addListener(() {
      if (_followerScrollController.position.pixels ==
          _followerScrollController.position.maxScrollExtent) {
        bloc.add(GetFollowers(
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
                  bloc.add(GetFollowers(
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
          const SizedBox(
            height: 20,
          ),
          FollowRequest(),
          const SizedBox(
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
                current is FollowerLoading || current is GetFollowerSuccess,
            builder: (context, state) {
              if (state is FollowerLoading) {
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
          BlocBuilder<FollowerBloc, FollowerState>(
            bloc: bloc,
            buildWhen: (previous, current) =>
                current is GetFollowerSuccess ||
                current is RemoveFollowerSuccess,
            builder: (context, state) {
              if (state is GetFollowerSuccess) {
                followers.addAll(state.followRelations);
              }
              if (state is RemoveFollowerSuccess) {
                followers.remove(state.followRelationDto);
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
                              InkWell(
                                onTap: () {
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.INFO,
                                      title:
                                          'Are you sure to remove this follower?',
                                      btnOkOnPress: () {
                                        bloc.add(RemoveFollower(
                                            userId: user.id,
                                            followRelationDto: follower));
                                      },
                                      btnOkText: 'Confirm',
                                      btnCancelOnPress: () {})
                                    ..show();
                                },
                                borderRadius: BorderRadius.circular(7),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5))),
                                  child: Text(
                                    'Remove',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
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
