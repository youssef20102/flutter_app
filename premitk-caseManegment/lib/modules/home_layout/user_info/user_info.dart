// @dart=2.9

// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';

import 'package:primitk_crm/shared/constants/constatnt.dart';
import 'package:primitk_crm/shared/images/all_images.dart';
import 'package:primitk_crm/shared/style/color.dart';

class UserInfo_Screen extends StatelessWidget {
  ScrollController scrollController;
  var top = 0.0;

  UserInfo_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          // backgroundColor: Colors.white,
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    // leading: Icon(Icons.ac_unit_outlined),
                    automaticallyImplyLeading: false,
                    expandedHeight: 200,
                    centerTitle: true,

                    elevation: 0,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;

                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(UserInfoScreen)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    Name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20.0, color: selectedColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          background: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Image.asset(
                                UserInfoScreen3,
                                fit: BoxFit.fitHeight,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: userTitle(title: 'User Information'),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          //Full name
                          Container(
                            child: userTile(
                              'Name',
                              Name.toString() ?? 'null',
                              Icons.person,
                            ),
                          ),
                          //EmailAddress
                          Container(
                            child: userTile(
                              'Email Address',
                              Email.toString() ?? 'null',
                              Icons.email,
                            ),
                          ),
                          //phone number
                          Container(
                            child: userTile(
                              'Phone Number',
                              Phone.toString() ?? 'null',
                              Icons.phone,
                            ),
                          ),

                          //OrganizationUnit
                          Container(
                            child: userTile(
                              'Organization Unit',
                              OrganizationUnit.toString() ?? 'null',
                              Icons.ac_unit,
                            ),
                          ),

                          //DefaultFilter
                          Container(
                            child: userTile(
                              'Default Filter',
                              DefaultFilter.toString() ?? 'null',
                              Icons.filter_list_outlined,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(0.8),
                            child: userTitle(title: 'User Settings'),
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          ListTileSwitch(
                            value: EnableNotifications,
                            onChanged: (value) {
                              cubit.changeNotificationState();
                            },
                            leading: Icon(
                              Icons.notifications_none_outlined,
                              color: selectedColor,
                            ),
                            visualDensity: VisualDensity.comfortable,
                            switchType: SwitchType.cupertino,
                            switchActiveColor: Colors.indigo,
                            title: Text('Enable Notifications',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor)),
                          ),
                          // change url
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 6.0),
                                                child: Icon(
                                                  Icons.change_circle_outlined,
                                                  color: unselectedColor,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Change Url'),
                                              ),
                                            ],
                                          ),
                                          content: const Text(
                                              'Do you want to Sign out?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  cubit.changeUrl(context);
                                                },
                                                child: const Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        );
                                      });
                                },
                                title: Row(
                                  children: [
                                    Text('Url : ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: selectedColor)),
                                    Expanded(
                                      child: Text('$ClientName.$dOMAiN.com',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: selectedColor)),
                                    ),
                                  ],
                                ),
                                leading: Icon(
                                  Icons.change_circle_outlined,
                                  color: unselectedColor,
                                ),
                              ),
                            ),
                          ),
                          //Sign out
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 6.0),
                                                child: Icon(
                                                  Icons.exit_to_app_rounded,
                                                  color: unselectedColor,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Sign out'),
                                              ),
                                            ],
                                          ),
                                          content: const Text(
                                              'Do you want to sign out?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  cubit.signOut(context);
                                                },
                                                child: const Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        );
                                      });
                                },
                                title: Text('Sign out',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: selectedColor)),
                                leading: Icon(
                                  Icons.exit_to_app_rounded,
                                  color: unselectedColor,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 85,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget userTile(String title, String subtitle, IconData leading) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: selectedColor),
      ),
      subtitle: Text(subtitle,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: unselectedColor)),
      leading: Icon(
        leading,
        color: unselectedColor,
      ),
    );
  }

  Widget userTitle({@required String title}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 23, color: selectedColor),
      ),
    );
  }
}
