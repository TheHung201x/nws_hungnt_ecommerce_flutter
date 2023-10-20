import 'package:ecommerce/ui/pages/main/main_cubit.dart';
import 'package:ecommerce/ui/pages/main/main_navigator.dart';
import 'package:ecommerce/ui/pages/main/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext context) => MainCubit(
        navigator: MainNavigator(context: context),
      ),
      child: _MainPage(child: child),
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  late List<Widget> pageList;

  final tabs = [
    MainTab.home,
    MainTab.cart,
    MainTab.notification,
    MainTab.profile,
  ];

  late MainCubit _mainCubit;

  @override
  void initState() {
    _mainCubit = BlocProvider.of<MainCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    return BlocConsumer<MainCubit, MainState>(
      bloc: _mainCubit,
      listenWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      listener: (context, state) {
        // pageController.jumpToPage(state.selectedIndex);
      },
      buildWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            unselectedFontSize: 0,
            selectedFontSize: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: theme.appBarTheme.backgroundColor,
            elevation: 8,
            type: BottomNavigationBarType.fixed,
            currentIndex: state.selectedIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: theme.indicatorColor,
            items: tabs.map((e) => e.tab).toList(),
            onTap: (index) {
              _mainCubit.switchTap(index);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
