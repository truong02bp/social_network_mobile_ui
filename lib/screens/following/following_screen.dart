import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/dto/follow_relation_dto.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/following/bloc/following_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/profile_drawer.dart';

class FollowingScreen extends StatelessWidget {
  final User user;
  late FollowingBloc bloc;
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  int page = 0;
  int size = 20;
  List<FollowRelationDto> following = [];
  String usernameSearch = '';

  FollowingScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowingBloc()
        ..add(GetFollowing(
            page: page, size: size, userId: user.id, username: usernameSearch)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    bloc = BlocProvider.of<FollowingBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.add(GetFollowing(
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
        body: _buildViewFollowing(context));
  }

  Widget _buildViewFollowing(BuildContext context) {
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
                  following.clear();
                  bloc.add(GetFollowing(
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
            'All following',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder(
            bloc: bloc,
            buildWhen: (previous, current) =>
                current is FollowingLoading || current is GetFollowingSuccess,
            builder: (context, state) {
              if (state is FollowingLoading) {
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
          BlocBuilder<FollowingBloc, FollowingState>(
            bloc: bloc,
            buildWhen: (previous, current) =>
                current is GetFollowingSuccess || current is UnfollowSuccess,
            builder: (context, state) {
              if (state is GetFollowingSuccess) {
                following.addAll(state.followRelations);
              }
              if (state is UnfollowSuccess) {
                following.remove(state.followRelationDto);
              }
              return Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: following.length,
                      addAutomaticKeepAlives: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = following[index];
                        return ListTile(
                          key: ValueKey(item.user.id),
                          subtitle: Text('${item.user.name}'),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: CachedNetworkImage(
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Image.asset('assets/images/loading.gif');
                              },
                              imageUrl: minioHost + item.user.avatar.url,
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(
                                '${item.user.username}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.INFO,
                                      title:
                                          'Are you sure to unfollow this person?',
                                      btnOkOnPress: () {
                                        bloc.add(UnfollowEvent(
                                            userId: user.id,
                                            followRelationDto: item));
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
                                    'Following',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
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
