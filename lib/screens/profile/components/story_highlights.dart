import 'package:flutter/material.dart';

class StoryHighlights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Story highlights',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 3,
        ),
        Text('Keep your favorite stories on your profile'),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(width: 50, height: 50, child: Icon(Icons.add),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 1.0,
                color: Colors.white.withOpacity(0.5)
              )
            ),),
            const SizedBox(
              width: 10,
            ),
            Container(width: 50, height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.1)
                  )
              ),),
            const SizedBox(
              width: 10,
            ),
            Container(width: 50, height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.1)
                  )
              ),),
            const SizedBox(
              width: 10,
            ),
            Container(width: 50, height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.1)
                  )
              ),),
            const SizedBox(
              width: 10,
            ),
            Container(width: 50, height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.1)
                  )
              ),),
            const SizedBox(
              width: 10,
            ),
            Container(width: 50, height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.1)
                  )
              ),),
          ],
        ),

      ],
    );
  }
}
