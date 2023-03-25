import 'package:blogger_app/core/themes/themes.dart';
import 'package:blogger_app/src/controllers/blogs_controller/blogs_controller.dart';
import 'package:blogger_app/src/views/widgets/blog_card_horiz/blog_card_horiz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryScreen extends StatefulWidget {
  String? category;
  CategoryScreen({super.key, this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final blogsController = Get.find<BlogsController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blogsController.Category.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncFunc(widget.category!);
  }

  Future<void> asyncFunc(String category) async {
    await blogsController.fetchSelectedCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (blogsController.Category.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category!),
            backgroundColor: ThemeColor.white,
            foregroundColor: ThemeColor.blackBasic,
            elevation: 0.0,
          ),
          body: SafeArea(
              child: Center(child: Text("No Blogs for ${widget.category}"))),
        );
      }
      return Scaffold(
        backgroundColor: ThemeColor.white,
        appBar: AppBar(
          title: Text(widget.category!),
          foregroundColor: ThemeColor.blackBasic,
          backgroundColor: ThemeColor.white,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: blogsController.Category.length,
              itemBuilder: (context, index) {
                return BlogCardsHoriz(
                  user: false,
                  e: blogsController.Category[index],
                );
              },
            )
          ],
        ),
      );
    });
  }
}
