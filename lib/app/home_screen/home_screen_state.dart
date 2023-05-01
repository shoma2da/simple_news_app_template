import 'package:flutter/material.dart';
import 'package:simple_news_app_template/models/category.dart';
import 'package:simple_news_app_template/api_utils/api_utils.dart';
import 'home_screen.dart';

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Future<List<Category>> _categoriesFuture;
  List<Category> _categories = [];
  List _newsArticles = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
    _initializeTabController();
  }

  void _initializeTabController() {
    _categoriesFuture.then((categories) {
      setState(() {
        _tabController = TabController(length: categories.length, vsync: this);
        _tabController!.addListener(_handleTabSelection);
        _newsArticles = List.generate(categories.length, (_) => []);
        _categories = categories;
      });
      if (categories.isNotEmpty) {
        _fetchAndSetNewsArticlesForCategory(0, categories.first.id);
      }
    });
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      final selectedCategoryId = _categories[_tabController!.index].id;
      _fetchAndSetNewsArticlesForCategory(
          _tabController!.index, selectedCategoryId);
    }
  }

  void _fetchAndSetNewsArticlesForCategory(int index, String categoryId) {
    setState(() {
      _newsArticles[index] = [];
    });
    fetchNewsArticles(categoryId).then((newsArticles) => setState(() {
          _newsArticles[index] = newsArticles;
        }));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Simple News App'),
        ),
      ),
      body: FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading tab titles'));
          } else {
            final categories = snapshot.data ?? [];
            return _buildTabBarAndView(categories);
          }
        },
      ),
    );
  }

  Widget _buildTabBarAndView(List<Category> categories) {
    return _tabController == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              TabBar(
                controller: _tabController!,
                labelColor: Colors.black,
                tabs: categories.map((c) => Tab(text: c.title)).toList(),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController!,
                  children: _newsArticles.map((newsArticles) {
                    return _buildNewsArticleList(newsArticles);
                  }).toList(),
                ),
              ),
            ],
          );
  }

  Widget _buildNewsArticleList(List newsArticles) {
    return ListView.builder(
      itemCount: newsArticles.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(newsArticles[index].title),
        );
      },
    );
  }
}
