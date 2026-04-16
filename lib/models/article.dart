class Article {
  final int id;
  final String title;
  final String body;
  final DateTime publishedAt;
  final String imageUrl;

  static const List<String> _titles = [
    'Chính phủ công bố gói hỗ trợ mới cho doanh nghiệp',
    'Thời tiết hôm nay: Nắng rực rỡ, nền nhiệt cao',
    'Thị trường chứng khoán hồi phục sau phiên giảm mạnh',
    'Khám phá ẩm thực đường phố Sài Gòn',
    'Giới trẻ quan tâm tới xu hướng du lịch xanh',
    'Bài học quý giá từ thành công của startup công nghệ',
    'An toàn giao thông được đặt lên hàng đầu',
    'Giải pháp tiết kiệm năng lượng cho gia đình',
    'Thế hệ Z và hành vi tiêu dùng mới',
    'Sức khỏe tinh thần mùa dịch: cần chia sẻ nhiều hơn',
  ];

  static const List<String> _bodies = [
    'Chính phủ vừa trình bày kế hoạch hỗ trợ các doanh nghiệp nhỏ và vừa nhằm ổn định thị trường, tập trung vào ngành sản xuất và dịch vụ. Gói chính sách mới gồm nhiều ưu đãi về thuế và tín dụng để thúc đẩy tăng trưởng.',
    'Dự báo thời tiết hôm nay cho thấy miền Bắc có nắng, miền Trung trời quang đãng và miền Nam có mưa rào cục bộ. Nhiệt độ cao nhất lên tới 33°C, người dân nên mang theo nón và nước.',
    'Sau một phiên giảm sâu, thị trường chứng khoán bật tăng trở lại nhờ lực mua mạnh của nhà đầu tư cá nhân và thông tin tích cực từ doanh nghiệp ngành năng lượng. Nhiều mã blue-chip đồng loạt hồi phục.',
    'Ẩm thực đường phố Sài Gòn luôn hấp dẫn với phở bò, bún riêu, bánh mì và trái cây tươi. Đường phố sôi động mang đến trải nghiệm ẩm thực đa dạng, phù hợp với cả khách du lịch lẫn người địa phương.',
    'Du lịch xanh đang trở thành xu hướng mới khi du khách tìm kiếm các điểm đến thân thiện với môi trường. Nhiều khu nghỉ dưỡng đã áp dụng biện pháp tiết kiệm nước và hạn chế rác thải nhựa.',
    'Startup công nghệ địa phương đã học được nhiều bài học về quản lý tài chính và xây dựng đội ngũ. Thành công không chỉ đến từ ý tưởng tốt mà còn nhờ cách họ thích ứng nhanh với thay đổi thị trường.',
    'An toàn giao thông tiếp tục được chính quyền địa phương ưu tiên với nhiều chiến dịch tuyên truyền. Người dân được khuyến cáo đội mũ bảo hiểm và tuân thủ biển báo khi tham gia giao thông.',
    'Tiết kiệm năng lượng giúp giảm chi phí sinh hoạt và bảo vệ môi trường. Các gia đình có thể lắp đèn LED, dùng thiết bị tiết kiệm điện và tắt nguồn khi không sử dụng.',
    'Thế hệ Z đang thay đổi thói quen tiêu dùng với ưu tiên sản phẩm xanh, dịch vụ trực tuyến và trải nghiệm cá nhân hóa. Họ tìm kiếm giá trị hơn là thương hiệu.',
    'Sức khỏe tinh thần được nhiều người chú ý hơn sau thời gian dài giãn cách. Chia sẻ cảm xúc với người thân và nghỉ ngơi hợp lý là hai giải pháp được chuyên gia khuyên dùng.',
  ];

  Article({
    required this.id,
    required this.title,
    required this.body,
    required this.publishedAt,
    required this.imageUrl,
  });

  String get description {
    if (body.length <= 120) {
      return body;
    }
    return '${body.substring(0, 120).trim()}...';
  }

  String get formattedDate {
    final day = publishedAt.day.toString().padLeft(2, '0');
    final month = publishedAt.month.toString().padLeft(2, '0');
    final year = publishedAt.year;
    return '$day/$month/$year';
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final createdAt = DateTime.now().subtract(Duration(days: id % 30));
    final imageId = (id % 100) + 10;
    final index = id % _titles.length;

    return Article(
      id: id,
      title: _titles[index],
      body: _bodies[index],
      publishedAt: createdAt,
      imageUrl: 'https://picsum.photos/id/$imageId/600/360',
    );
  }
}
