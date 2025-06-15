import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/category');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/cart');
    } else if (index == 4) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Đặt chiều cao cho AppBar
          child: AppBar(
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false, // Tắt icon back
            title: Center(
              child: Text(
                'Thông báo', // Tên appbar sẽ hiển thị
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Colors.blue,
              indicatorWeight: 3.0,
              tabs: [
                Tab(
                  child: Text(
                    'Khuyến mãi',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Của bạn',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PromotionTab(),
                  YourNotificationsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromotionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        buildNotificationItem(
          title: 'DOLIA CLINIC - CÚP ĐIỆN ĐỘT XUẤT',
          content:
              'Chi nhánh 1519 Phạm Văn Thuận, TP Biên Hòa\nTạm ngừng phục vụ do cúp điện đột xuất.\nDự kiến 14h00 hôm nay sẽ hoạt động lại.',
          time: '01-12-2023 10:41:44',
          icon: Icons.warning,
          iconColor: Colors.red,
        ),
        buildNotificationItem(
          title: 'ĐIỀU TRỊ HỒNG BAN - ƯU ĐÃI 500K',
          content:
              '🟡 Bác sĩ da liễu khám và trực tiếp thực hiện.\n🟡 Công nghệ IPL được FDA chứng nhận.\n🟡 Không xâm lấn, không cần nghỉ dưỡng.\n👉 Đặt lịch ngay!',
          time: '30-11-2023 19:41:00',
          icon: Icons.local_offer,
          iconColor: Colors.orange,
        ),
        buildNotificationItem(
          title: '🔥 LẤY MỤN ƯU ĐÃI 149K 🔥',
          content:
              '🟡 Bác sĩ thăm khám miễn phí.\n🟡 Bảo hành lấy mụn 3 ngày.\n🟡 Duy nhất tại Dolia Clinic.\n👉 Đặt lịch ngay!',
          time: '28-11-2023 19:06:00',
          icon: Icons.star,
          iconColor: Colors.amber,
        ),
      ],
    );
  }

  Widget buildNotificationItem({
    required String title,
    required String content,
    required String time,
    IconData? icon,
    Color? iconColor,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, color: iconColor ?? Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(content),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YourNotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        buildNotificationItem(
          title: 'Đơn hàng 24052052196 đã đặt thành công',
          content: 'Dolia đã nhận được thông tin đơn hàng của bạn.',
          time: '01-12-2023 08:05:00',
          imageUrl: 'https://via.placeholder.com/100',
        ),
        buildNotificationItem(
          title: 'Đơn hàng 24013158251 đã đặt thành công',
          content: 'Dolia đã nhận được thông tin đơn hàng của bạn.',
          time: '30-11-2023 20:30:00',
          imageUrl: 'https://via.placeholder.com/100',
        ),
      ],
    );
  }

  Widget buildNotificationItem({
    required String title,
    required String content,
    required String time,
    required String imageUrl,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(content),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
