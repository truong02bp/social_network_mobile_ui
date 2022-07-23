import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/constants/gallery_constant.dart';
import 'package:social_network_mobile_ui/constants/host_api.dart';
import 'package:social_network_mobile_ui/screens/gallery/gallery_screen.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';

import '../../../models/user.dart';

class Avatar extends StatelessWidget {
  User? user;
  late ProfileBloc bloc;
  double size = 90;

  Avatar({required this.user, required this.size});

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder(
        bloc: bloc,
        buildWhen: (previous, current) => current is ProfileUpdateAvatarSuccess,
        builder: (context, state) {
          if (state is ProfileUpdateAvatarSuccess) {
            user = state.user;
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GalleryScreen(
                            type: GalleryConstants.image,
                            option: GalleryConstants.single,
                            callBackSingle: (selectedFile) {
                              processFile(file: selectedFile);
                            },
                          )));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: CachedNetworkImage(
                height: size,
                width: size,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Image.asset('assets/images/loading.gif');
                },
                imageUrl: minioHost + "${user?.avatar.url}",
              ),
            ),
          );
        });
  }

  void processFile({required File file}) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColor.black,
              backgroundColor: AppColor.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              showCropGrid: false,
              lockAspectRatio: false),
        ]);
    if (croppedFile != null) {
      List<int> bytes = List.from(await croppedFile.readAsBytes());
      int? id = user?.id;
      if (id != null) {
        bloc.add(ProfileUpdateAvatar(
            userId: id,
            bytes: base64Encode(bytes),
            name: croppedFile.path
                .substring(croppedFile.path.lastIndexOf("/") + 1)));
      }
    }
  }
}
