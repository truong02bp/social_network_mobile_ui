import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_mobile_ui/screens/follower/bloc/follower_bloc.dart';

class FollowRequest extends StatelessWidget {
  const FollowRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FollowerBloc>(context);
    return InkWell(
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
                  child: BlocBuilder<FollowerBloc, FollowerState>(
                    bloc: bloc,
                    buildWhen: (previous, current) =>
                        current is CountFollowRequestSuccess,
                    builder: (context, state) {
                      int total = 0;
                      if (state is CountFollowRequestSuccess) {
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              Text('Approve or ignore requests')
            ],
          )
        ],
      ),
    );
  }
}
