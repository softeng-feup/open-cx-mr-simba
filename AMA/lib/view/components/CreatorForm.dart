import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Session.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Dates.dart' as Dates;

class CreatorForm extends StatefulWidget {
  @override
  CreatorFormState createState() => CreatorFormState();
}

class CreatorFormState extends State<CreatorForm> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  Dates.Date date = null;

  FormInfo retreiveFormInfo() {
    return FormInfo(this.titleController.text, this.descrController.text,
        this.date, this.startTime, this.endTime);
  }

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      DateTime currentTime = new DateTime.now();

      if (Dates.date1.dateEqualTo(currentTime))
        date = Dates.date1;
      else if (Dates.date2.dateEqualTo(currentTime))
        date = Dates.date2;
      else if (Dates.date3.dateEqualTo(currentTime))
        date = Dates.date3;
      else if (Dates.date4.dateEqualTo(currentTime))
        date = Dates.date4;
      else
        date = Dates.date1;
    }

    return Container(
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getTitleInputForm(),
                  getDescriptionInputForm(),
                  getTimeSelectorTitle(),
                  getTimeSelectorInput(),
                  getDateSelectorTitle(),
                  getDateSelectorDropdown(),
                  getFloatingSubmitButton(),
                ])));
  }

  bool isFormValid() {
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

    if (toDouble(this.endTime) < toDouble(this.startTime)) return false;

    if (titleController.text == "") return false;

    return true;
  }

  Widget getFloatingSubmitButton() {
    Color bgColor = this.isFormValid() ? Colors.green : Colors.black38;

    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
          onPressed: () {
            // ADICIONAR PARTE DE ADICIONAR NOVA SESSAO AO HORARIO. Não adicionar se isFormValid == false.
            Session newSession = Session(
              key:"__AMA_Custom_Session_X",     // Necessário definir um id para as sessoes criadas.
              title: this.titleController.text,
              description: this.descrController.text,
              chairsString: "",
              chairs: List<String>(),
              items: List<String>(),
              isCustom: 1,
              day: this.date.toDateString(),    // Confirmar formato
              type: "",
              startTime: DateTime(2019),        // Alterar
              timeString:this.startTime.format(context) + " - " + this.endTime.format(context), // Confirmar formato
              location: ""
              
              );
            Controller.instance().addSessionToSchedule(newSession);
          },
          tooltip: 'Scan',
          backgroundColor: bgColor,
          child: Icon(
            Icons.check,
            color: Colors.white,
          )),
    );
  }

  Widget getDateSelectorDropdown() {
    return Center(
      child: DropdownButton<Dates.Date>(
        value: date,
        icon: Icon(Icons.more_vert),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: AppColors.mainColor,
        ),
        underline: Container(
          height: 2,
          color: AppColors.mainColor,
        ),
        onChanged: (Dates.Date newValue) {
          setState(() {
            date = newValue;
          });
        },
        items: <Dates.Date>[Dates.date1, Dates.date2, Dates.date3, Dates.date4]
            .map<DropdownMenuItem<Dates.Date>>((Dates.Date value) {
          return DropdownMenuItem<Dates.Date>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget getTimeSelectorTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        title: Text(
          "Time picker",
          textAlign: TextAlign.left,
          style: TextStyle(color: AppColors.mainColor),
        ),
        leading: Icon(
          Icons.timelapse,
          color: AppColors.mainColor,
        ),
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }

  Widget getDateSelectorTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        title: Text(
          "Day picker",
          textAlign: TextAlign.left,
          style: TextStyle(color: AppColors.mainColor),
        ),
        leading: Icon(
          Icons.calendar_today,
          color: AppColors.mainColor,
        ),
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }

  Widget getTimeSelectorInput() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            onPressed: () => _selectTime(context, "start"),
            child: Text('Start: ' + this.startTime.format(context)),
          ),
          RaisedButton(
            onPressed: () => _selectTime(context, "end"),
            child: Text('End: ' + this.endTime.format(context)),
          ),
        ]);
  }

  Future<Null> _selectTime(BuildContext context, String selector) async {
    TimeOfDay picked = TimeOfDay.now();

    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

    if (selector == "start") {
      picked =
          await showTimePicker(context: context, initialTime: this.startTime);

      if (picked != null && picked != this.startTime)
        setState(() {
          this.startTime = picked;

          if (toDouble(this.endTime) < toDouble(this.startTime)) {
            this.endTime = this.startTime;
          }
        });
    } else if (selector == "end") {
      picked =
          await showTimePicker(context: context, initialTime: this.startTime);

      if (picked != null && picked != this.endTime)
        setState(() {
          this.endTime = picked;
        });
    }
  }

  Widget getDescriptionInputForm() {
    const TextStyle textStyle = TextStyle(
      color: AppColors.mainColor,
    );

    return TextFormField(
      controller: this.descrController,
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
      controller: this.titleController,
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

class FormInfo {
  String title;
  String description;

  Dates.Date date;
  TimeOfDay startTime;
  TimeOfDay endTime;

  FormInfo(
      this.title, this.description, this.date, this.startTime, this.endTime);
}
