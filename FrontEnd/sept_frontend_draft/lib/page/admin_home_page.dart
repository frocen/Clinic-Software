import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/network/base_request.dart';
import 'package:sept_frontend_draft/page/admin_setting_page.dart';
import 'package:sept_frontend_draft/utils/sp_utils.dart';

class HomeTabListDtoEntity {
  String? title;

  String? subTitle;

  String? tagTitle;

  String? info;

  String? id;
}

class AdminHomePage extends StatefulWidget {
  static const String sName = "AdminHomePage";

  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late TabController _tabController;

  final pageTabIndex = ValueNotifier(0);

  List<String> pageTabViewModelList = [];

  ValueNotifier<List<HomeTabListDtoEntity>?> items = ValueNotifier(null);

  /// current login user
  String loginUser = '';

  @override
  void initState() {
    super.initState();

    pageTabViewModelList.addAll([
      'Doctor',
      'Medicine',
      'Patient'
    ]);
    _tabController = TabController(
      initialIndex: pageTabIndex.value,
      length: pageTabViewModelList.length,
      vsync: this,
    );
    pageTabIndex.addListener(_changeIndex);
    loginUser = SpUtils.getString('user');
    loadList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    pageTabIndex.removeListener(_changeIndex);
    super.dispose();
  }

  void _changeIndex() {
    _tabController.index = pageTabIndex.value;
  }

  void loadList() async {
    if (pageTabIndex.value == 0) {
      /// load doctor list data
      try {
        final response = await BaseRequest().get(
          'http://localhost:8080/Doctor',
        );
        // [{'id':"!",'name':'a'},{},{}]
        if (response is List) {
          final list = response.map((e) {
            return HomeTabListDtoEntity()
              ..title = e['id']
              ..subTitle = e['name'];
          }).toList();
          items.value = list;
        }
      } catch (e) {
        showToast(e.toString());
      }
    } else if (pageTabIndex.value == 2) {
      /// load patient list data
      try {
        final response = await BaseRequest().get(
          'http://localhost:8080/Patient',
        );

        if (response is List) {
          final list = response.map((e) {
            return HomeTabListDtoEntity()
              ..title = e['id']
              ..subTitle = e['name']
              ..tagTitle = e['status'];
          }).toList();
          items.value = list;
        }
      } catch (e) {
        showToast(e.toString());
      }
    } else {
      /// load medicine list data
      try {
        final response = await BaseRequest().get(
          'http://localhost:8080/Medicine',
        );

        if (response is List) {
          final list = response.map((e) {
            return HomeTabListDtoEntity()
              ..title = e['id']
              ..subTitle = e['name']
              ..info = e['description'];
          }).toList();
          items.value = list;
        }
      } catch (e) {
        showToast(e.toString());
      }
    }
  }

  void deleteInfoById(String id) async {
    if (pageTabIndex.value == 0) {
      /// load doctor list data
      try {
        final response = await BaseRequest().delete(
          'http://localhost:8080/Doctor/{id}?id=$id',
        );

        loadList();
      } catch (e) {
        showToast(e.toString());
      }
    } else if (pageTabIndex.value == 2) {
      /// load patient list data
      try {
        final response = await BaseRequest().delete(
          'http://localhost:8080/Patient/{id}?id=$id',
        );

        loadList();
      } catch (e) {
        showToast(e.toString());
      }
    } else {
      /// load medicine list data
      try {
        final response = await BaseRequest().delete(
          'http://localhost:8080/Medicine/{id}?id=$id',
        );

        loadList();
      } catch (e) {
        showToast(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// android status bar transparent
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'admin home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              InfoType type = InfoType.doctor;
              if (pageTabIndex.value == 1) {
                type = InfoType.medicine;
              } else if (pageTabIndex.value == 2) {
                type = InfoType.patient;
              }
              Navigator.pushNamed(context, AdminSettingPage.sName,
                  arguments: {'type': type, 'entity': null}).then((value) {
                loadList();
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(loginUser),
            accountEmail: Text('$loginUser@gmail.com'),
            currentAccountPicture: const CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.red,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.exit_to_app),
            onTap: () {
              SpUtils.clear();
              Navigator.pushReplacementNamed(context, '/LoginPage');
            },
          ),
        ],
      )),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              HomeSearchWidget(submittedHandler: (value) {}),
              Container(
                width: double.infinity,
                height: 48,
                color: Colors.white,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: 4.px),
                margin: const EdgeInsets.only(bottom: 12),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: const Color(0xFF999999),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8F92A1),
                      fontWeight: FontWeight.w400),
                  labelColor: Colors.lightBlue,
                  isScrollable: false,
                  labelPadding: EdgeInsets.symmetric(horizontal: 12),
                  labelStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                  indicatorColor: Colors.lightBlue,
                  onTap: (index) {
                    if (pageTabIndex.value == index) {
                      return;
                    }

                    pageTabIndex.value = index;

                    loadList();
                  },
                  tabs: List.generate(
                    pageTabViewModelList.length,
                    (index) {
                      return Text(pageTabViewModelList[index]);
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pageTabViewModelList.map((e) {
                    return ValueListenableBuilder<List<HomeTabListDtoEntity>?>(
                        valueListenable: items,
                        builder: (context, value, child) {
                          return AdminHomeListTab(
                            items: value ?? [],
                            onDeleteCallBack: (int index) {
                              final list = value ?? [];
                              // list.removeAt(index);
                              // items.value = list;
                              // setState(() {});
                              deleteInfoById(list[index].title ?? '');
                            },
                            onTapCallBack: (int index) {
                              InfoType type = InfoType.doctor;
                              if (pageTabIndex.value == 1) {
                                type = InfoType.medicine;
                              } else if (pageTabIndex.value == 2) {
                                type = InfoType.patient;
                              }
                              Navigator.pushNamed(
                                  context, AdminSettingPage.sName, arguments: {
                                'type': type,
                                'entity': (value ?? [])[index]
                              }).then((value) {
                                loadList();
                              });
                            },
                          );
                        });
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class AdminHomeListTab extends StatelessWidget {
  final List<HomeTabListDtoEntity> items;
  final ValueChanged<int> onDeleteCallBack;
  final ValueChanged<int> onTapCallBack;

  const AdminHomeListTab(
      {Key? key,
      required this.items,
      required this.onDeleteCallBack,
      required this.onTapCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _buildNoDataWidget();
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),

            /// All actions are defined in the children parameter.
            children: [
              /// A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (c) {
                  onDeleteCallBack.call(index);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: HomeTabListItem(
            entity: items[index],
            onTap: () {
              onTapCallBack.call(index);
            },
          ),
        );
      },
      itemCount: items.length,
    );
  }

  Widget _buildNoDataWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty),
          Text(
            'No Data',
            style: TextStyle(
              color: Color(0xFFBDBDBD),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSearchWidget extends StatefulWidget {
  final ValueChanged<String?> submittedHandler;

  const HomeSearchWidget({Key? key, required this.submittedHandler})
      : super(key: key);

  @override
  State<HomeSearchWidget> createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends State<HomeSearchWidget>
    with WidgetsBindingObserver {
  bool isKeyboardActive = false;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(left: 16, right: 84, bottom: 5, top: 5),
            height: 44,
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 4),
                  child: Icon(
                    Icons.search,
                    color: Color(0xff999999),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: widget.submittedHandler,
                    keyboardAppearance: Brightness.light,
                    onChanged: (value) {},
                    cursorColor: Color(0xFF030319),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Keyword search',
                      suffixIconConstraints: BoxConstraints(
                        maxHeight: 30,
                        maxWidth: 30,
                      ),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _controller,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Visibility(
                              visible: value.text.isNotEmpty,
                              child: GestureDetector(
                                onTap: () {
                                  // _controller.clear();
                                  // viewModel.keyword = null;
                                  // viewModel.loadList(showLoading: false);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.clear),
                                ),
                              ),
                            );
                          }),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffFFBDBDBD),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 16, color: Color(0xFF333333), height: 1.2),
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ],
            )),
        Positioned(
          right: 16,
          child: InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.lightBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeTabListItem extends StatelessWidget {
  final HomeTabListDtoEntity entity;
  final VoidCallback onTap;

  const HomeTabListItem({Key? key, required this.entity, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF2F2F2),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ID: ${entity.title ?? ''}',
                            style: TextStyle(
                                color: Color(0xFF030319), fontSize: 16),
                          ),
                        ),
                        Visibility(
                          visible: (entity.tagTitle ?? '').isNotEmpty,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            margin: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFFFF6D3F),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Status: ${entity.tagTitle ?? ''}',
                              style: TextStyle(
                                  color: Color(0xFF030319), fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      entity.subTitle ?? '',
                      style: TextStyle(color: Color(0xFF8F92A1), fontSize: 14),
                    ),
                    Visibility(
                      visible: (entity.info ?? '').isNotEmpty,
                      child: Text(
                        'Des: ${entity.info ?? ''}',
                        style:
                            TextStyle(color: Color(0xFF8F92A1), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
