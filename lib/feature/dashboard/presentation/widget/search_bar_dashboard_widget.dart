import 'package:flutter/material.dart';

import '../../../cart/presentation/widget/cart_badges.dart';
import '../../../search/presentation/page/search_page.dart';

class SearchBarDashboardWidget extends StatefulWidget {
  const SearchBarDashboardWidget({super.key});

  @override
  State<SearchBarDashboardWidget> createState() =>
      _SearchBarDashboardWidgetState();
}

class _SearchBarDashboardWidgetState extends State<SearchBarDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchPageBloc(),
                  ),
                );
              },
              child: Hero(
                tag: "onClickTextField",
                child: Material(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white54, strokeAlign: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.search, size: 17),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            "Cari di Tokopedia",
                            style: TextStyle(fontSize: 17.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.mail, size: 23),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.notifications, size: 23),
          ),
          const CartBadges(
            badgesEnd: 10,
            child: SizedBox(
              width: 23,
              child: Icon(Icons.shopping_cart_rounded),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.menu, size: 23),
          )
        ],
      ),
    );
  }
}
