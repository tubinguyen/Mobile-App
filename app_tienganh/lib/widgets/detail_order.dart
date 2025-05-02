import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import 'package:app_tienganh/views/admin/order_detail_screen.dart'; 

class OrderDetail extends StatelessWidget {
  final String date;
  final bool isReceived;
  final String imageName;
  final double price;
  final String title;
  final int quantity;
  final bool isAdmin;

  const OrderDetail({
    super.key,
    required this.date,
    required this.isReceived,
    required this.imageName,
    required this.price,
    required this.title,
    required this.quantity,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = price * quantity;

    return SizedBox(
      height: 283,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: AppColors.blueLightest, width: 1),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      isReceived ? "Đã nhận hàng" : "Chưa nhận hàng",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19),

              // Sản phẩm trong giỏ hàng
              ShoppingCartItemFinal(
                imageName: imageName,
                price: price,
                title: title,
                quantity: quantity,
              ),

              Divider(height: 24, thickness: 1, color: AppColors.blueLightest), 

              // Tổng tiền
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "TỔNG: ",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${totalPrice.toStringAsFixed(0)} VND",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.end, // Căn phải
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9),

              // Nút đặt hàng
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: isAdmin 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PremiumButton(
                            text: 'Xem chi tiết',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                    date: date,
                                    isReceived: isReceived,
                                    imageName: imageName,
                                    price: price,
                                    title: title,
                                    quantity: quantity,
                                  ),
                                ),
                              );
                            },
                            state: ButtonState.premium,
                            textColor: AppColors.background,
                          ),
                          SizedBox(width: 8),
                          PremiumButton(
                            text: 'Đã giao hàng',
                            onTap: () {
                              // Xử lý khi admin nhấn "Đã giao hàng"
                            },
                            state: ButtonState.success,
                            textColor: AppColors.background,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PremiumButton(
                            text: 'Xem chi tiết',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                    date: date,
                                    isReceived: isReceived,
                                    imageName: imageName,
                                    price: price,
                                    title: title,
                                    quantity: quantity,
                                  ),
                                ),
                              );
                            },
                            state: ButtonState.premium,
                            textColor: AppColors.background,
                          ),
                          SizedBox(width: 8),
                          PremiumButton(
                            text: 'Đã nhận hàng',
                            onTap: () {
                              // Xử lý khi admin nhấn "Đã giao hàng"
                            },
                            state: ButtonState.success,
                            textColor: AppColors.background,
                          ),
                        ],
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
