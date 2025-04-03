import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';
import 'package:app_tienganh/widgets/large_button.dart';

class OrderDetail extends StatelessWidget {
  final String date;
  final bool isReceived;
  final String imageName;
  final double price;
  final String title;
  final int quantity;

  const OrderDetail({
    super.key,
    required this.date,
    required this.isReceived,
    required this.imageName,
    required this.price,
    required this.title,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    
    double totalPrice = price * quantity; // Tính tổng tiền

    return SizedBox(
      width: 369,
      height: 283, 
      child: Card(
        color: AppColors.highlightLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: AppColors.BlueLightest, width: 1),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0,10,10,5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ngày & Trạng thái đơn hàng
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),

                  Text(
                    isReceived ? "Đã nhận hàng" : "Chưa nhận hàng",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: AppColors.textPrimary,
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

              Divider(height: 24, thickness: 1, color: AppColors.BlueLightest), // Đường kẻ phân cách

              // Tổng tiền 
              Padding(
                padding: const EdgeInsets.only(left: 16.0), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "TỔNG:",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 160.0), 
                    Text(
                      "${totalPrice.toStringAsFixed(0)} VND",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9), // Thêm khoảng cách trước nút

              // Nút đặt hàng
              Padding (
                padding: const EdgeInsets.only(right: 8.0),
                child: 
                  Align(
                    alignment: Alignment.bottomRight,
                    child: LargeButton(
                      text: 'Đặt hàng',
                      onTap: () {
                        // Xử lý khi nhấn nút
                        // Cần truyền biến ID sách ở đây nếu có
                      },
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
