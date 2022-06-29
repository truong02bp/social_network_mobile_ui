import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/gallery_constant.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/gallery/gallery_screen.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';

class Profile extends StatelessWidget {

  User? user;
  late ProfileBloc bloc;
  Profile({required this.user});

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder(
              bloc: bloc,
              buildWhen: (previous, current) => current is ProfileUpdateAvatarSuccess,
              builder: (context, state) {
                if (state is ProfileUpdateAvatarSuccess) {
                  user = state.user;
                }
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreen(type: GalleryConstants.image, option: GalleryConstants.single, callBackSingle: (selectedFile){
                      processFile(file: selectedFile);
                    },)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset('assets/images/loading.gif');
                      },
                      imageUrl: minioHost + "${user?.avatar.url}",
                    ),
                  ),
                );
              }
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: BlocBuilder(
                  bloc: bloc,
                  buildWhen: (previous, current) => current is GetProfileSuccess,
                  builder: (context, state) {
                    int posts = 0;
                    int followers = 0;
                    int following = 0;
                    if (state is GetProfileSuccess) {
                      posts = state.profileDto.posts;
                      followers = state.profileDto.followers;
                      following = state.profileDto.following;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('$posts'),
                            const SizedBox(height: 5,),
                            Text('Posts', style: TextStyle(fontSize: 16),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('$followers'),
                            const SizedBox(height: 5,),
                            Text('Followers', style: TextStyle(fontSize: 16),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('$following'),
                            const SizedBox(height: 5,),
                            Text('Following', style: TextStyle(fontSize: 16),),
                          ],
                        )
                      ],
                    );
                  }
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('${user?.name}', style: TextStyle(fontSize: 17),)
      ],
    );
  }

  void processFile({required File file}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      cropStyle: CropStyle.circle,
      uiSettings: [AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColor.black,
          backgroundColor: AppColor.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          showCropGrid: false,
          lockAspectRatio: false),]
    );
    if (croppedFile != null) {
      List<int> bytes = List.from(await croppedFile.readAsBytes());
      int? id = user?.id;
      print(id);
      if (id != null) {
        bloc.add(ProfileUpdateAvatar(userId: id, bytes: base64Encode(bytes),
            name: croppedFile.path.substring(
                croppedFile.path.lastIndexOf("/") + 1)));
      }
    }
  }

}

