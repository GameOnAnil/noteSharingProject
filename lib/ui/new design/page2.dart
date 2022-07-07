import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sharing_project/ui/new%20design/page3.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: purplePrimary,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(flex: 2, child: _header()),
          Expanded(flex: 5, child: _contentBody()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "BESE",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _chooseSemester() {
    return Consumer(builder: (context, ref, child) {
      return SizedBox(
        height: 60,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fillColor: Colors.white,
              filled: true),
          elevation: 10,
          hint: const Text(
            "Choose Semester",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          isExpanded: true,
          value: "Hello",
          borderRadius: BorderRadius.circular(10),
          items: const [],
          onChanged: (item) {},
        ),
      );
    });
  }

  Container _contentBody() {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: Colors.white),
        child: _gridView());
  }

  Padding _sliverGridView() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
      child: GridView.custom(
        padding: EdgeInsets.zero,
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 10,
          pattern: [
            const WovenGridTile(1),
            const WovenGridTile(
              1,
              crossAxisRatio: 1,
              alignment: AlignmentDirectional.bottomEnd,
            ),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            final remainder = index % 4;
            return NewSubjectGridTile(colors: colorGradientList[remainder]);
          },
        ),
      ),
    );
  }

  Container _header() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Choose Semester',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _chooseSemester()
          ],
        ),
      ),
    );
  }

  _gridView() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (context, index) {
          final remainder = index % 4;
          return NewSubjectGridTile(colors: colorGradientList[remainder]);
        },
      ),
    );
  }
}

class NewSubjectGridTile extends StatelessWidget {
  final List<Color> colors;
  const NewSubjectGridTile({
    Key? key,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const Page3()),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/fancy.png",
              width: 70,
              height: 70,
            ),
            const Text(
              'Maths I',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
