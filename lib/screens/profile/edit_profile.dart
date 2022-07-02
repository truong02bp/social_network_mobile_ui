import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/constants/color.dart';
import 'package:social_network_mobile_ui/models/user.dart';
import 'package:social_network_mobile_ui/screens/profile/bloc/profile_bloc.dart';
import 'package:social_network_mobile_ui/screens/profile/components/avatar.dart';

class EditProfile extends StatelessWidget {
  final User user;

  EditProfile({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: AppColor.black3,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: SingleChildScrollView(
            child: BlocListener(
              bloc: bloc,
              listener: (BuildContext context, state) {
                if (state is ProfileUpdateUserSuccess ||
                    state is ProfileUpdatePasswordSuccess) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.SUCCES,
                    headerAnimationLoop: false,
                    animType: AnimType.TOPSLIDE,
                    closeIcon: const Icon(Icons.close_fullscreen_outlined),
                    desc: 'Update success!',
                    btnOkOnPress: () {},
                  ).show();
                }
                if (state is ProfileUpdateFailure) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    headerAnimationLoop: false,
                    animType: AnimType.BOTTOMSLIDE,
                    closeIcon: const Icon(Icons.close_fullscreen_outlined),
                    desc: 'Update failure!',
                    descTextStyle: TextStyle(color: Colors.red),
                    btnOkOnPress: () {},
                  ).show();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Avatar(
                    user: user,
                    size: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      user.name = value;
                    },
                    autocorrect: false,
                    initialValue: "${user.name}",
                    decoration: InputDecoration(
                        labelText: 'Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      user.username = value;
                    },
                    initialValue: "${user.username}",
                    decoration: InputDecoration(
                        labelText: 'Username',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      user.address = value;
                    },
                    initialValue: "${user.address}",
                    decoration: InputDecoration(
                        labelText: 'Address',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      user.phone = value;
                    },
                    initialValue: "${user.phone}",
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          String oldPassword = "";
                          String newPassword = "";
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.NO_HEADER,
                            keyboardAware: true,
                            btnOkOnPress: () {
                              if (oldPassword.isNotEmpty &&
                                  newPassword.isNotEmpty) {
                                bloc.add(ProfileUpdatePassword(
                                    userId: user.id,
                                    oldPassword: oldPassword,
                                    newPassword: newPassword));
                              }
                            },
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Change password',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      oldPassword = value;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: 'Old password',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      newPassword = value;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: 'New password',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          )..show();
                        },
                        child: Text(
                          'Change password ?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      bloc.add(ProfileUpdateUser(user: user));
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text('Update'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
