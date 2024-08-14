import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bottom_sheet/add_task_bottom_sheet.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screens/my_theme_data.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});
static const String routeName ="EditScreen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}
class _EditScreenState extends State<EditScreen> {
   DateTime currentDate = DateTime.now();
  @override
  
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
     var model=ModalRoute.of(context)?.settings.arguments as TaskModel;
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text("appBarTitle".tr(),style: Theme.of(context).textTheme.bodyLarge,),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
           height: 100,
        color: MyThemeData.secondaryColor,
            ),
            Container(
              margin:const  EdgeInsets.only(right:27,top: 25),
            height: 617,
            width: 352,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyThemeData.white
              
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    
                      children: [
              Text(
               "ebitTask".tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: provider.mode == ThemeMode.light
                          ? MyThemeData.black
                          : MyThemeData.white,
                    ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: titleController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: MyThemeData.grayDarkColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: MyThemeData.secondaryColor)),
                        hintText: "enteryourtask".tr(),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: MyThemeData.secondaryGrayColor))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: subTitleController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: MyThemeData.grayDarkColor)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyThemeData.secondaryColor),
                        ),
                        hintText: "entertaskdetalis".tr(),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: MyThemeData.secondaryGrayColor))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "selectedTime".tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: provider.mode == ThemeMode.light
                          ? const Color(0xff383838)
                          : MyThemeData.grayDarkColor),
                  textAlign: TextAlign.start
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: InkWell(
                  onTap: () {
                    selectedDate();
                  },
                  child: Text(currentDate.toString().substring(0, 10).tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: MyThemeData.secondaryGrayColor)),
                ),
              ),
             const  SizedBox(
              height: 120,
             ),
              Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                       minimumSize:const  Size(225, 52),
                        backgroundColor: MyThemeData.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: ()  {
                       
                       titleController.text=model.title;
                       subTitleController.text=model.subTitle;
                          model.date=
                                DateUtils.dateOnly(currentDate).millisecondsSinceEpoch;
                         FirebaseFunctions.updateTask(model);
                        Navigator.pop(context);
                      },
                      child: Text("saveChanges".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: MyThemeData.white))),
                ],
              )
                      ],
                    ),
            ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> selectedDate() async {
    final DateTime? selectedDay = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: MyThemeData.secondaryColor,
                onPrimary: MyThemeData.secondaryDarkGrayColor,
                onSurface: MyThemeData.secondaryDarkColor,
                surface: MyThemeData.primaryColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    MyThemeData.secondaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDay != null) {
      currentDate = selectedDay;
      setState(() {});
    }
  }
}
