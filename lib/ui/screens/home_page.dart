import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/providers/sub_notifier.dart';
import 'package:note_sharing_project/ui/widgets/subjectgrid_tile.dart';
import 'package:note_sharing_project/utils/constants.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Home Page",
        ),
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () async {
                for (Subject sub in subjectList) {
                  await ref.read(subNotifierProvider).insertSub(sub);
                }
              },
              icon: const Icon(Icons.arrow_upward),
            );
          }),
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () async {
                ref
                    .read(subNotifierProvider)
                    .getSubByCategory(program: "BESE", semester: "1st");
              },
              icon: const Icon(Icons.arrow_downward),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          _chooseSemester(),
          _chooseProgram(),
          _dataFromLocal(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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

  Widget _chooseProgram() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
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
            decoration: const InputDecoration(border: OutlineInputBorder()),
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
    return Consumer(
      builder: (context, ref, child) {
        final subList = ref.watch(subNotifierProvider).subList;
        if (subList.isEmpty) {
          return const Center(
            child: Text("empty"),
          );
        } else {
          return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.1),
                itemCount: subList.length,
                itemBuilder: (context, index) {
                  return SubjectGridTile(
                    name: subList[index].name,
                    semester: selectedSem!,
                    program: selectedProgram!,
                  );
                }),
          );
        }
      },
    );
  }
}
