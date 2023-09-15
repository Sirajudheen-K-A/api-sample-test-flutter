import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: CupertinoSearchTextField(
              itemSize: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey)),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 25,
          child: Icon(CupertinoIcons.ant_fill),
        ),
      ],
    );
  }
}