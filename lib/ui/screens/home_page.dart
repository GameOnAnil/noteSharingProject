import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/providers/sub_notifier.dart';
import 'package:note_sharing_project/ui/widgets/subject_grid_tile.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedSem;
  String? selectedProgram;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              _header(),
            ],
          ),
          _chooseSemester(),
          _chooseProgram(),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _dataFromLocal()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: darkBlueBackground,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 21,
                  ),
                ),
                Text(
                  'Note Sharing App',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }

  Widget _chooseProgram() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true),
            elevation: 10,
            hint: const Text(
              "Choose Program",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            value: selectedProgram,
            borderRadius: BorderRadius.circular(10),
            items: [
              ...programList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList()
            ],
            onChanged: (item) {
              setState(() {
                selectedProgram = item.toString();
                if (selectedProgram != null && selectedSem != null) {
                  ref.read(subNotifierProvider).getSubByCategory(
                      program: selectedProgram!, semester: selectedSem!);
                }
              });
            },
          ),
        ),
      );
    });
  }

  Widget _chooseSemester() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true),
            elevation: 10,
            hint: const Text(
              "Choose Semester",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            value: selectedSem,
            borderRadius: BorderRadius.circular(10),
            items: [
              ...semesterList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList()
            ],
            onChanged: (item) {
              setState(() {
                selectedSem = item.toString();
                if (selectedProgram != null && selectedSem != null) {
                  ref.read(subNotifierProvider).getSubByCategory(
                      program: selectedProgram!, semester: selectedSem!);
                }
              });
            },
          ),
        ),
      );
    });
  }

  Widget _dataFromLocal() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final subList = ref.watch(subNotifierProvider).subList;
          if (subList.isEmpty) {
            return const Center(
              child: Text("Please Enter Subject..."),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.3),
              itemCount: subList.length,
              itemBuilder: (context, index) {
                return SubjectGridTile(
                  name: subList[index].name,
                  semester: selectedSem!,
                  program: selectedProgram!,
                );
              },
            );
          }
        },
      ),
    );
  }
}
