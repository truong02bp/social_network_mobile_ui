import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_mobile_ui/components/icon_without_background.dart';
import 'package:social_network_mobile_ui/constants/color.dart';

class CameraIcon extends StatefulWidget {
  final Function(XFile file, String type) solvePicked;

  CameraIcon({required this.solvePicked});

  @override
  _CameraIconState createState() => _CameraIconState();
}

class _CameraIconState extends State<CameraIcon> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return IconWithoutBackground(
      image: "assets/images/camera.png",
      width: 40,
      height: 40,
      color: Color(0xfff78379).withOpacity(0.8),
      onTap: showPickOption,
    );
  }

  void showPickOption() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              backgroundColor: AppColor.black,
              title: Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      FloatingActionButton(
                          backgroundColor: AppColor.black.withOpacity(0.8),
                          onPressed: () {
                            getFromSource(ImageSource.camera, "image");
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.image,
                              size: 35,
                              color: Color(0xfff78379).withOpacity(0.8))),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Take image',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Column(
                    children: [
                      FloatingActionButton(
                        backgroundColor: AppColor.black.withOpacity(0.8),
                        onPressed: () {
                          getFromSource(ImageSource.camera, "video");
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.camera_alt_sharp,
                          size: 35,
                          color: Color(0xfff78379).withOpacity(0.8),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Take video',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ));
  }

  void getFromSource(ImageSource source, String type) async {
    XFile? file;
    if (type == "image") {
      if (source == ImageSource.camera) {
        file = await _picker.pickImage(source: source);
      }
    } else if (type == "video") {
      file = await _picker.pickVideo(source: source);
    }
    if (file != null) {
      widget.solvePicked(file, type);
    }
  }
}
