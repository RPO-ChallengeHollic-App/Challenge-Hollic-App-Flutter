import 'package:challange_hollic_mobile_app/models/challenge-image.model.dart';
import 'package:challange_hollic_mobile_app/models/challenge.model.dart';
import 'package:flutter/material.dart';

import '../../models/participant.model.dart';
import '../../models/tag.model.dart';

class ChallengeDetailPage extends StatelessWidget {
  ChallengeDetailPage({Key? key}) : super(key: key);
    
  final Challenge challenge = Challenge(
      "Take an amaizing picture from the bridge",
      DateTime.parse("2022-12-02"),
      DateTime.parse("2023-01-30"),
      [Participant("Joe", "Joe Whoe", "___default___")],
      [Tag("Dangerous", "FF7e57c2"), Tag("Outside", "FF7cb342")]
  );

  List<ChallengeImage> images = [
    ChallengeImage(null, Participant("Joe", "Joe Whoe", "___default___"), "https://upload.wikimedia.org/wikipedia/commons/f/f9/Stari_most_v_Mariboru.jpg", 15),
    ChallengeImage(null, Participant("Martin", "Joe Whoe", "___default___"), "https://upload.wikimedia.org/wikipedia/commons/6/69/Dvoeta%C5%BEni_MB_pogled.jpg", 5),
  ];

  Color getChallengeCardBackground(Challenge challenge) {
    if (challenge.tags.isNotEmpty) {
      int sum = 0;
      for (Tag tag in challenge.tags) {
        sum += int.parse(tag.color.substring(2), radix: 16) + 0xFAAA;
      }
      print("0x${sum.toRadixString(16)}");
      return Color(int.parse("0xFF${sum.toRadixString(16)}"));
    }
    return Colors.white;
  }

  Color calculateTextColor(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.light ? Colors.black : Colors.white;
  }
  
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color challengeBgColor = getChallengeCardBackground(challenge);
    final Color challengeTextColor = calculateTextColor(challengeBgColor);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: challengeBgColor,
        title: Text(challenge.name),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: challengeBgColor,
        child: Icon(Icons.photo_camera, color: challengeTextColor),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            ChallengeImage image = images[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.network(image.image, fit: BoxFit.fill),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            image.participant.nickname,
                            textScaleFactor: 1.2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${image.likes}",
                                textScaleFactor: 1.3,
                                style:const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.3
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.thumb_up_alt_outlined, size: 25)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
