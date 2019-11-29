import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class CreatorForm extends StatefulWidget {
  @override
  CreatorFormState createState() => CreatorFormState();
}

class CreatorFormState extends State<CreatorForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5.0),
        color: AppColors.containerColor,
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getTitleInputForm(),
                  getDescriptionInputForm(),
                ])));
  }

  Widget getDescriptionInputForm() {
    const TextStyle textStyle = TextStyle(
      color: AppColors.mainColor,
    );

    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      cursorColor: AppColors.mainColorFoccused,
      style: textStyle,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColorFoccused),
        ),
        hintStyle: TextStyle(color: Colors.black38),
        labelStyle: textStyle,
        errorStyle: textStyle,
        prefixStyle: textStyle,
        helperStyle: textStyle,
        icon: Icon(
          Icons.format_align_justify,
          color: AppColors.mainColor,
        ),
        hintText: 'What does the activity consist of?',
        labelText: 'Activity Description',
      ),
    );
  }

  Widget getTitleInputForm() {
    const TextStyle textStyle = TextStyle(
      color: AppColors.mainColor,
    );

    return TextFormField(
      cursorColor: AppColors.mainColorFoccused,
      style: textStyle,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColorFoccused),
        ),
        hintStyle: TextStyle(color: Colors.black38),
        labelStyle: textStyle,
        errorStyle: textStyle,
        prefixStyle: textStyle,
        helperStyle: textStyle,
        icon: Icon(
          Icons.title,
          color: AppColors.mainColor,
        ),
        hintText: 'What is the activity called?',
        labelText: 'Activity Name',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
