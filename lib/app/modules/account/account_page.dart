import 'package:example_widget_testing/app/modules/search/components/search_category_item.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/search_json.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: size.width - 30,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textFieldBackground),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: white.withOpacity(0.3),
                        )),
                    style: TextStyle(color: white.withOpacity(0.3)),
                    cursorColor: white.withOpacity(0.3),
                  ),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: List.generate(searchCategories.length, (index) {
                  return CategoryStoryItem(
                    name: searchCategories[index],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Wrap(
            spacing: 1,
            runSpacing: 1,
            children: List.generate(searchImages.length, (index) {
              return Container(
                width: (size.width - 3) / 3,
                height: (size.width - 3) / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(searchImages[index]),
                      fit: BoxFit.cover),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
