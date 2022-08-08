import 'package:flutter/material.dart';

class CourseGrid extends StatelessWidget {
  const CourseGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: GridView.builder(
            itemCount:1,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("profile.png"), fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "profile.png",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            "course[index].lessons",
                            style: const TextStyle(color: Colors.white),
                          ),
                          // CircularPercentIndicator(
                          //   radius: 30,
                          //   lineWidth: 8,
                          //   animation: true,
                          //   animationDuration: 1500,
                          //   circularStrokeCap: CircularStrokeCap.round,
                          //   percent: course[index].percent / 100,
                          //   progressColor: Colors.white,
                          //   center: Text(
                          //     "${course[index].percent}%",
                          //     style: const TextStyle(color: Colors.white),
                          //   ),
                          // )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "log.png",
                            height: 110,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}