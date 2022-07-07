import 'package:flutter/material.dart';
import 'package:note_sharing_project/ui/new%20design/semester_page.dart';

class CarauselTile extends StatelessWidget {
  final Color color;
  final String title;
  const CarauselTile({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const Text(
                "Files: 200",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => SemesterPage(
                          selectedProgram: title,
                        )),
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text(
                "View",
                style: TextStyle(color: color),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
