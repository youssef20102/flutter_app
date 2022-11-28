// @dart=2.9

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';

import 'package:primitk_crm/shared/images/all_images.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
        return Scaffold(
          extendBody: true,
          body: Column(
            children: [
              cubit.isOffline == true
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    )
                  : const SizedBox(),
              Container(
                child: errorMsg(
                    "No Internet Connection Available", cubit.isOffline),
                //to show internet connection message on isoffline = true.
              ),
              Expanded(
                child: DoubleBackToCloseApp(
                  child: cubit.bottomNavScreens[cubit.bottomNavCurrentIndex],
                  snackBar: const SnackBar(
                    content: Text('Tap back again to leave'),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 0.01,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ))),
                child: BottomNavigationBar(
                  onTap: (value) {
                    cubit.changeBottomNavCurrentIndex(value);
                  },
                  currentIndex: cubit.bottomNavCurrentIndex,
                  iconSize: 25,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(
                        FlutterIcons.ticket_outline_mco,
                      ),
                      label: 'Cases',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_pin_outlined,
                      ),
                      label: 'Customer',
                    ),
                    const BottomNavigationBarItem(
                      activeIcon: null,
                      icon: Icon(null),
                      label: 'Add Case',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.notifications_none_outlined,
                      ),
                      label: 'Notification',
                    ),
                    BottomNavigationBarItem(
                      icon: CircleAvatar(
                        radius: 12,
                        backgroundImage: const AssetImage(UserInfoScreen),
                        backgroundColor: unselectedColor,
                        // child: const Center(child: Icon(Icons.person,size: 18,color: Colors.white,)),
                      ),
                      label: 'User',
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: showFab
              ? Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: FloatingActionButton(
                    isExtended: true,
                    onPressed: () {
                      cubit.changeBottomNavCurrentIndex(2);
                    },
                    child: const Icon(
                      Icons.add,
                      size: 28,
                    ),
                    hoverElevation: 10,
                    elevation: 4,
                  ),
                )
              : null,
        );
      },
    );
  }
}
