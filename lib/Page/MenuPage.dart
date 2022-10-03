import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

const categoryHeight = 55.0;
const foodItemHeight = 110.0;

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  final _bloc = MenuBLoc();

  @override
  void initState() {
    _bloc.init(this);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: AnimatedBuilder(
        animation: _bloc,
        builder: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              child: TabBar(
                onTap: _bloc.onCategorySelected,
                controller: _bloc.tabController,
                indicatorWeight: 0.1,
                isScrollable: true,
                tabs: _bloc.tabs.map((e) => _MenuTabWidget(e)).toList(),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    controller: _bloc.scrollController,
                    itemCount: _bloc.items.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      final item = _bloc.items[index];
                      if (item.isCategory) {
                        return _MenuCategoryItemWidget(item.category!);
                      } else {
                        return _MenuFoodItemWidget(item.foodItem!);
                      }
                    })),
          ],
        ),
      ),
    );
  }
}

class _MenuTabWidget extends StatelessWidget {
  const _MenuTabWidget(this.tabCategory);

  final MenuTabCategory tabCategory;

  @override
  Widget build(BuildContext context) {
    final selected = tabCategory.selected;
    return Opacity(
      opacity: selected ? 1 : 0.5,
      child: Card(
        elevation: selected ? 6 : 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tabCategory.category.name,
          ),
        ),
      ),
    );
  }
}

class _MenuCategoryItemWidget extends StatelessWidget {
  const _MenuCategoryItemWidget(this.category);

  final MenuCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: categoryHeight,
      alignment: Alignment.centerLeft,
      child: Text(
        category.name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _MenuFoodItemWidget extends StatelessWidget {
  const _MenuFoodItemWidget(this.foodItem);

  final MenuFoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: foodItemHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
            elevation: 3,
            shadowColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.food_bank_outlined,
                    size: 70,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(foodItem.name),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("123"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(foodItem.price.toString()),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class MenuCategory {
  const MenuCategory({required this.name, required this.foodItem});

  final String name;
  final List<MenuFoodItem> foodItem;
}

class MenuFoodItem {
  const MenuFoodItem({
    required this.name,
    required this.price,
  });

  final String name;
  final double price;
}

class MenuBLoc with ChangeNotifier {
  List<MenuTabCategory> tabs = [];
  List<MenuItem> items = [];
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  bool _listen = true;

  void init(TickerProvider ticker) {
    tabController = TabController(length: menuCategories.length, vsync: ticker);

    double offsetFrom = 0.0;
    double offsetTo = 0.0;

    for (int i = 0; i < menuCategories.length; i++) {
      final category = menuCategories[i];

      if (i > 0) {
        offsetFrom += menuCategories[i - 1].foodItem.length * foodItemHeight;
      }
      if (i < menuCategories.length - 1) {
        offsetTo =
            offsetFrom + menuCategories[i + 1].foodItem.length * foodItemHeight;
      } else {
        offsetTo = double.infinity;
      }

      tabs.add(MenuTabCategory(
          category: category,
          selected: (i == 0),
          offsetFrom: categoryHeight * i + offsetFrom,
          offsetTo: offsetTo));

      items.add(MenuItem(category: category));
      for (int j = 0; j < category.foodItem.length; j++) {
        final foodItem = category.foodItem[j];
        items.add(MenuItem(foodItem: foodItem));
      }
    }

    scrollController.addListener(_onScrollListener);
  }

  void _onScrollListener() {
    if (_listen) {
      for (int i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        if (scrollController.offset >= tab.offsetFrom &&
            scrollController.offset <= tab.offsetTo &&
            !tab.selected) {
          onCategorySelected(i, animationRequired: false);
          tabController.animateTo(i);
//          print(
//              "$i, ${scrollController.offset >= tab.offsetFrom}, ${scrollController.offset <= tab.offsetTo}, ${tab.selected}, break");
          break;
        }
        else if (scrollController.position.pixels == scrollController.position.maxScrollExtent){
          onCategorySelected(tabs.length - 1, animationRequired: false);
          tabController.animateTo(tabs.length - 1);
          print("Bottom");
        }
      }
    }
  }

  void onCategorySelected(int index, {bool animationRequired = true}) async {
    final selected = tabs[index];
    for (int i = 0; i < tabs.length; i++) {
      final condition = selected.category.name == tabs[i].category.name;
      tabs[i] = tabs[i].copyWith(condition);
    }
    notifyListeners();

    if (animationRequired) {
      _listen = false;
      await scrollController.animateTo(selected.offsetFrom,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      _listen = true;
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScrollListener);
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }
}

class MenuTabCategory {
  MenuTabCategory(
      {required this.category,
      required this.selected,
      required this.offsetFrom,
      required this.offsetTo});

  final MenuCategory category;
  final bool selected;
  final double offsetFrom;
  final double offsetTo;

  MenuTabCategory copyWith(bool selected) => MenuTabCategory(
      category: category,
      selected: selected,
      offsetFrom: offsetFrom,
      offsetTo: offsetTo);
}

class MenuItem {
  const MenuItem({this.category, this.foodItem});

  final MenuCategory? category;
  final MenuFoodItem? foodItem;

  bool get isCategory => category != null;
}

const menuCategories = [
  MenuCategory(name: "麵", foodItem: [
    MenuFoodItem(name: "牛肉麵", price: 120),
    MenuFoodItem(name: "乾麵", price: 80)
  ]),
  MenuCategory(name: "飯", foodItem: [
    MenuFoodItem(name: "滷肉飯", price: 25),
    MenuFoodItem(name: "白飯", price: 10)
  ]),
  MenuCategory(name: "小菜", foodItem: [
    MenuFoodItem(name: "豆干", price: 30),
    MenuFoodItem(name: "海帶", price: 40),
    MenuFoodItem(name: "米血", price: 50)
  ]),
  MenuCategory(name: "麵麵", foodItem: [
    MenuFoodItem(name: "牛肉麵", price: 120),
    MenuFoodItem(name: "乾麵", price: 80)
  ]),
  MenuCategory(name: "飯飯", foodItem: [
    MenuFoodItem(name: "滷肉飯", price: 25),
    MenuFoodItem(name: "白飯", price: 10)
  ]),
  MenuCategory(name: "小菜小菜", foodItem: [
    MenuFoodItem(name: "豆干", price: 30),
    MenuFoodItem(name: "海帶", price: 40),
    MenuFoodItem(name: "米血", price: 50)
  ]),
];
