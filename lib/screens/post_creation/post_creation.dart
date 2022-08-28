import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/components/avatar.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/post_creation/bloc/post_creation_bloc.dart';

class PostCreationScreen extends StatelessWidget {
  final List<File> files;
  final User user;

  PostCreationScreen({required this.files, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCreationBloc(),
      child: Builder(builder: (context) => _buildView(context)),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<PostCreationBloc>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, top: 15),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Avatar(
                    url: user.avatar.url,
                    size: 60,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'What\'s on your mind ?',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      )),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            TextFormField(
              onChanged: (value) {},
              keyboardType: TextInputType.multiline,
              maxLength: null,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your caption',
                contentPadding: EdgeInsets.only(left: 20),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
            Expanded(
                flex: 5,
                child: PageView.builder(
                  onPageChanged: (value) {
                    print(value);
                    bloc.add(ChangeImage(index: value));
                  },
                  itemBuilder: (context, index) {
                    return Image.file(files[index]);
                  },
                  itemCount: files.length,
                )),
            BlocBuilder<PostCreationBloc, PostCreationState>(
              bloc: bloc,
              builder: (context, state) {
                return Row(
                  children: List.generate(
                      files.length,
                      (index) => buildDot(
                          currentImage: state.currentImage, index: index)),
                  mainAxisAlignment: MainAxisAlignment.center,
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot({currentImage, index}) {
    return Container(
      height: 10,
      margin: EdgeInsets.only(left: 3, right: 3),
      width: currentImage == index ? 15 : 10,
      decoration: BoxDecoration(
          color: currentImage == index ? Colors.deepOrange : Colors.white,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
