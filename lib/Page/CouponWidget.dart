import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';

class CouponWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
              showToast("Coupon");},
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Restaurant Name",
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: IconButton(
                          onPressed: () {
                            showToast("Setting");
                          },
                          iconSize: 18,
                          icon: Icon(Icons.more_horiz_outlined),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "使用期限: 2022/05/01 ~ 2022/08/31",
                        style: TextStyle(fontSize: 13),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text(
                          "尚未使用",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
