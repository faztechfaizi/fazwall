import 'package:fazwalls/firebase/auth/auth_provider.dart';
import 'package:fazwalls/pages/category_page/category_screen.dart';
import 'package:fazwalls/pages/favorite_page/favorite_page.dart';
import 'package:fazwalls/pages/homescreen/home_screen.dart';
import 'package:fazwalls/pages/welcome_page/welcome_screen.dart';

import 'package:fazwalls/utils/dartk_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class GnavigationBar extends StatefulWidget {
  const GnavigationBar({super.key});

  @override
  State<GnavigationBar> createState() => _GnavigationBarState();
}

class _GnavigationBarState extends State<GnavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryPage(),
     const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthProviderr authProvider =
        Provider.of<AuthProviderr>(context, listen: false);
     final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        actions: [
          
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child:  IconButton(  icon: const Icon(Icons.logout),color: Colors.yellow, onPressed: (){
              authProvider.signOut(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const WelcomeScreen()));
            },),),],
       
        centerTitle: true,
        title: Image.asset(
          'assets/images/fazwall.png',
          width: size.width * 0.45,
        ),
      ),
      bottomNavigationBar: GNav(
         
          activeColor: const Color(0xfff615DB4),
          backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
          gap: 5,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.category,
              text: 'Category',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorite',
            )
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      body: _pages[_selectedIndex],
    );
  }
}
