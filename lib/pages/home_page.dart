import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ordertracking/model/item_model.dart';
import 'package:ordertracking/service/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Item>> _futureItem;
  @override
  void initState() {
    super.initState();
    _futureItem = OrderTracking().getItem();
    print("Started");
  }

  // late Future<Item> _futureItem;
  // void initState() {
  //   super.initState();
  //   _futureItem = OrderTracking().getItem();
  //   print("Started");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _futureItem = OrderTracking().getItem();
          setState(() {});
        },
        child: FutureBuilder<List<Item>>(
          future: _futureItem,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext contex, int index) {
                  final item = items[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Text(item.name),
                          Text(item.tags),
                          Text(item.qty),
                          Text(item.description),
                          Text(item.placeToDeliver),
                          Text(DateFormat("dd.MM ")
                              .format(item.time.toLocal())
                              .toString()),
                          Text(DateFormat("hh:mm a")
                              .format(item.time.toLocal())
                              .toString()),
                          // Text(item.phone.isNaN.toString()),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
