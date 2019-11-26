import 'package:ama/view/components/GenericContainer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/AppColors.dart' as AppColors;
import 'package:ama/model/Item.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({this.item});
  final Item item;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Item Info"),
          leading: IconButton(
            key: Key("Back button"),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            color: AppColors.backgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(10),

              children: <Widget>[
                GenericContainer(title: "Title", text: item.title),
                Divider(color: AppColors.backgroundColor),
                GenericContainer(title: "Type",text:item.type),
                Divider(color: AppColors.backgroundColor),
                GenericContainer(title: "Description", text: item.description == "" ? "Not Available": item.description),
                Divider(color: AppColors.backgroundColor),
                GenericContainer(title: "Authors",
                  text: item.peopleString
              ),
                Divider(color: AppColors.backgroundColor),
                GenericContainer(title: "Affiliations",
                    text: item.affiliationString
                ),
                Divider(color: AppColors.backgroundColor),
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(item.url)) {
                      await launch(item.url);
                    } else {
                      throw 'Could not launch $item.url';
                    }
                  },
                  child: GenericContainer(
                    title: "URL",
                    text: item.url,
                    touchable: true,
                ),
                ),
              ],
            )
        )
    );
  }
}
