import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../buy_sell/widgets/buy_sell_grid_item.dart';
import '../../models/classified.dart';

class BuyItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              width: double.infinity,
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                cursorColor: Colors.white12,
                cursorWidth: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white54,
                  ),
                  border: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide.none,
                    //borderSide: const BorderSide(),
                  ),
                  hintText: 'Search here',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            ),
            SizedBox(height: 10),
            FutureBuilder(
                future: Provider.of<ClassifiedsProvider>(
                  context,
                  listen: false,
                ).fetchAndSetClassifieds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Consumer<ClassifiedsProvider>(
                    builder: (context, classifiedsProvider, child) {
                      final classifieds = classifiedsProvider.classifieds;
                      return Expanded(
                          child: GridView.extent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.6,
                        padding: EdgeInsets.all(8),
                        children: List.generate(classifieds.length, (index) {
                          return BuyPageGridItem(
                            title: classifieds[index].title,
                            index: index,
                            price: classifieds[index].price,
                            subtitle: classifieds[index].subTitle,
                            imageUrl:
                                "https://rolibooks.com/wp-content/uploads/2021/01/WhatsApp-Image-2020-12-24-at-09.48.54.jpeg",
                          );
                        }),
                      ));
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}