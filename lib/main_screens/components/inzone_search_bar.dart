import 'package:flutter/material.dart';

class InZoneSearchBar extends StatelessWidget {
  final Color searchHintTextColor;
  final Color backgroundColor;

  const InZoneSearchBar({
    super.key,
    this.searchHintTextColor = Colors.black54,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 1))
          ]),
      child: Row(
        children: [
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: TextField(
              onSubmitted: (text) {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SearchResultsPage()));
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: searchHintTextColor)),
            ),
          )
        ],
      ),
    );
  }
}
