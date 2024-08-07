import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/tabs/setting_tab.dart';
import 'package:to_do/tabs/task_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xff5D9CEC),
        title: Text(
          "To Do List",
          style: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:  const Color(0xff5D9CEC),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color:Colors.white,width:4  )
        ),
         child:const Icon(Icons.add,color: Colors.white,),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero,
        notchMargin: 8,
        shape:const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
            currentIndex: selectedIndex,
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            selectedItemColor: const Color(0xff5D9CEC),
            unselectedItemColor: const Color(0xffC8C9CB),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: "")
            ]),
      ),
      body:tabs[selectedIndex] ,
    );
   
  }
   List<Widget>tabs=[
    const TasksTab(),
    const SettingsTab(),
    ];
}
