import 'package:ama/view/components/GenericContainer.dart';
import 'package:ama/view/components/GenericTitle.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About",
            style: TextStyle(color: Colors.white),
            key: Key("Screen title"),
          ),
          backgroundColor: AppColors.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[
              getAboutMessageContainer(),
              getTeamTitle(),
              getTeamContainer(context),
            ],
          ),
        ));
  }

  Widget getAboutMessageContainer() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      child: GenericContainer(
        title: "AMA - Agenda Mobile App",
        text: Utility.aboutText,
      ),
    );
  }

  Widget getTeamTitle() {
    return GenericTitle(
        title: "The Team:",
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.only(top: 10.0),
        style: TextStyle(
            color: AppColors.mainColor,
            fontWeight: FontWeight.w900,
            fontSize: 25));
  }

  Widget getTeamContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Column(
        children: <Widget>[
          getTeamElement("Professor Ademar Aguiar", true,
              "https://scontent.fopo3-2.fna.fbcdn.net/v/t31.0-8/p960x960/11426751_10153406272449161_4609663974000048493_o.jpg?_nc_cat=107&_nc_ohc=KIJK7Wv7ARQAQn3gdPB6mHSsSXJoKpXgx06ZG6bDX_v7GWsBRL0xo2IDA&_nc_ht=scontent.fopo3-2.fna&oh=5cf02272c85240d3b5ca8495a0efe229&oe=5E856E71"),
          Divider(height: 6),
          getTeamElement("David Silva", false,
              "https://scontent.fopo3-2.fna.fbcdn.net/v/t1.0-9/p960x960/68643879_2440141056041424_3853270333838589952_o.jpg?_nc_cat=104&_nc_ohc=PlW0vYHOXG4AQmMgeKhpKq2Gbf1FCuf7vTFQ21urvF4NZ595FXWjTWCmg&_nc_ht=scontent.fopo3-2.fna&oh=90f4d8aebc41d1b6ad16c3c078bec219&oe=5E82AAFA"),
          Divider(height: 6),
          getTeamElement("Eduardo Ribeiro", true,
              "https://scontent.fopo3-1.fna.fbcdn.net/v/t1.0-9/71500913_2470546719699845_1106906109760765952_n.jpg?_nc_cat=101&_nc_ohc=cSkydWkkirEAQmBbOiHzDJ5tzWWtEP6fy6FerLkvKjjBwYfydBT6pjbgg&_nc_ht=scontent.fopo3-1.fna&oh=d57bd403d073b173f3713dd256c7de5d&oe=5E4F8D77"),
          Divider(height: 6),
          getTeamElement("José Gomes", false,
              "https://scontent.fopo3-2.fna.fbcdn.net/v/t1.0-9/47345742_2261543377212598_5072022262480109568_n.jpg?_nc_cat=100&_nc_ohc=U6ah_n9QdxMAQnMfwaCgZTgFBLPr2x5wc5VWNKMOSSxX3CV3dSkHL6e5g&_nc_ht=scontent.fopo3-2.fna&oh=7f320037609bf7f3d04995eaf230f44c&oe=5E42AC42"),
          Divider(height: 6),
          getTeamElement("Luís Cunha", true,
              "https://scontent.fopo3-2.fna.fbcdn.net/v/t1.0-9/27658102_1568590759883747_5712690656793015680_n.jpg?_nc_cat=109&_nc_ohc=pQS_2mlbj0cAQkxctpZyQjmE_InUGGWPICGUvle7jBdhxC72fi5EFqkkA&_nc_ht=scontent.fopo3-2.fna&oh=c6bd97d2264988418fd3aa97efaf6d5f&oe=5E4EA063"),
        ],
      ),
    );
  }

  Widget getTeamElement(String name, bool toTheRight, String imageAddr) {
    CircleAvatar photo = CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(imageAddr),
      backgroundColor: Colors.transparent,
    );

    if (toTheRight) {
      return Container(
          decoration: new BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 6.0, right: 15.0, bottom: 6.0, left: 15.0),
            title: Text(
              name,
              textAlign: TextAlign.right,
            ),
            leading: photo,
          ));
    } else {
      return Container(
          decoration: new BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 6.0, right: 15.0, bottom: 6.0, left: 15.0),
            title: Text(
              name,
              textAlign: TextAlign.left,
            ),
            trailing: photo,
          ));
    }
  }
}

class SessionScanAboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About Session Scanning",
            style: TextStyle(color: Colors.white),
            key: Key("Screen title"),
          ),
          backgroundColor: AppColors.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                child: GenericContainer(
                  title: "How does session scanning work?",
                  text: Utility.sessionSearchAboutText,
                ),
              ),
            ],
          ),
        ));
  }
}
