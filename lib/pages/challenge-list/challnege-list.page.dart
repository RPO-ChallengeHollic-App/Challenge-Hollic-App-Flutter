import 'package:challange_hollic_mobile_app/models/challenge.model.dart';
import 'package:challange_hollic_mobile_app/models/participant.model.dart';
import 'package:challange_hollic_mobile_app/models/tag.model.dart';
import 'package:challange_hollic_mobile_app/widgets/form/form-input-field.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../auth/auth-base.page.dart';

class ChallengeListPage extends StatelessWidget {
  ChallengeListPage({Key? key}) : super(key: key);

  final TextEditingController _challengeNameController = TextEditingController();

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


  List<Challenge> challenges = [
    Challenge(
        "Take an amaizing picture from the bridge",
        DateTime.parse("2022-12-02"),
        DateTime.parse("2023-01-30"),
        [Participant("Joe", "Joe Whoe", "___default___")],
        [Tag("Dangerous", "FF7e57c2"), Tag("Outside", "FF7cb342")]
    ),
    Challenge(
        "Take an amaizing picture from the bridge",
        DateTime.parse("2022-12-02"),
        DateTime.parse("2023-01-30"),
        [Participant("Joe", "Joe Whoe", "___default___")],
        [Tag("Dangerous", "ffff7043"), Tag("Outside", "FF7cb342")]
    ),
    Challenge(
        "Take an amaizing picture from the bridge",
        DateTime.parse("2022-12-02"),
        DateTime.parse("2023-01-30"),
        [Participant("Joe", "Joe Whoe", "___default___")],
        [Tag("Dangerous", "ff64b5f6"), Tag("Outside", "ff64b5f6"), Tag("Outside", "FF7cb342")]
    ),
    Challenge(
        "Take an amaizing picture from the bridge",
        DateTime.parse("2022-12-02"),
        DateTime.parse("2023-01-30"),
        [Participant("Joe", "Joe Whoe", "___default___")],
        [Tag("Dangerous", "ffffab91"), Tag("Outside", "ff4a148c")]
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Ongoing Challenges',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add Challenge'),
                        content: Column(
                          children: [
                            FormInputField(
                              borderColor: Theme.of(context).primaryColor,
                              controller: _challengeNameController,
                              hintText: "Challenge name...",
                              labelText: "Challenge",
                            ),
                            AuthBasePage.authButton(
                                'ADD',
                                height: 45.0,
                                onPressed: () {
                                }
                            ),
                          ],
                        ),
                      );
                    }
                );
              },
              icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final Challenge challenge = challenges[index];
          return GestureDetector(
            onTap: () {
              context.push('/challenge/detail');
            },
            child: challengeCard(challenge),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Group"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
        ],
        onTap: (index) {
          context.go("/groups");
        },
      ),
    );
  }

  Widget tagBox(Tag tag) {
    final Color backgroundColor = Color(int.parse(tag.color, radix: 16));
    final Color fontColor = calculateTextColor(backgroundColor);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Text(
        tag.name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: fontColor
        ),
      ),
    );
  }

  Widget challengeCard(Challenge challenge) {
    final Color backgroundColor = getChallengeCardBackground(challenge);
    final Color fontColor = calculateTextColor(backgroundColor);
    return Card(
        color: backgroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                challenge.name,
                textScaleFactor: 1.25,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),

              challengeCardInfoText(
                'Number of participants: ${challenge.participants.length}',
                fontColor,
              ),

              challengeCardInfoText(
                'Challenge was started on: ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(challenge.startDate)}',
                fontColor,
              ),

              challengeCardInfoText(''
                'Challenge is ending on: ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(challenge.deadline!)}',
                fontColor,
              ),

              // Tag list
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                height: 29,
                child: ListView.builder(
                  itemCount: challenge.tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Tag tag = challenge.tags[index];
                    return tagBox(tag);
                  },
                ),
              )
            ],
          ),
        )
    );
  }

  Widget challengeCardInfoText(String text, Color fontColor) {
    return  Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        textScaleFactor: 1.1,
        style: TextStyle(
            color: fontColor
        ),
      ),
    );
  }
}
