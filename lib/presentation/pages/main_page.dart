import 'package:flutter/material.dart';
import '/core/theme/app_theme.dart';
import '../widgets/menus/user_menu.dart';
import 'dashboard_page.dart';
import 'configuracoes_pages.dart';
import 'chamados/criar_chamados_page.dart';
import 'chamados_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    ChamadosPage(),
    CriarChamadosPage(),
    ConfiguracoesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.headerGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LOGO
                  GestureDetector(
                    onTap: () {
                      if (_selectedIndex != 0) {
                        setState(() => _selectedIndex = 0);
                      }
                    },
                    child: const Image(
                      image:
                          AssetImage('assets/images/logo-cortexia-branca.png'),
                      height: 55,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(22)),
                        ),
                        backgroundColor: Colors.white,
                        builder: (_) => const UserMenuSheet(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: AppTheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 12,
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.textSecondary.withOpacity(0.6),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_outline),
              label: 'Meus Chamados',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 30),
              label: 'Criar Chamado',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Config.',
            ),
          ],
        ),
      ),
    );
  }
}
