import 'package:challange_hollic_mobile_app/widgets/form/form-input-field.widget.dart';
import 'package:flutter/material.dart';

import '../../models/group.model.dart';

class GroupListPage extends StatelessWidget {
  GroupListPage({Key? key}) : super(key: key);

  List<Group> groups = [
    Group("Nature explorers", 5, "https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Shaqi_jrvej.jpg/1200px-Shaqi_jrvej.jpg"),
    Group("Water exploreers", 10, "https://i.natgeofe.com/n/d326d61d-8ef6-4f4c-a03f-ab8fbbb40e6d/coral-reefs-2728211_16x9.jpg"),
    Group("Mountain lovers", 13, "https://upload.wikimedia.org/wikipedia/commons/e/e7/Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              FormInputField(
                borderColor: Theme.of(context).primaryColor,
                labelText: "Search group",
                hintText: "Group name",
                prefixIcon: Icons.search,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    Group group = groups[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(group.name),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(group.profile),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Group"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
        ],
        currentIndex: 1,
      ),
    );
  }
}
