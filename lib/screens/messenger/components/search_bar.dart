import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/screens/messenger_search/messenger_search_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return MessengerSearchScreen();
          }));
        },
        readOnly: true,
        decoration: InputDecoration(
            hintText: "Search",
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.deepOrangeAccent,)
        ),
      ),
    );;
  }
}
