void main(List<String> arguments) {
  print('Hello world!');
  getDataFromDatabase().then(
    (value) {
      print(value);
    },
  );
}

// Future
// async
// await đợi quá trình bất đồng kết thúc và hiển thị kết quả
// then

// Hàm lấy dữ liệu từ csdl

Future<String> getDataFromDatabase() async {
  print('Start!');

  // Future<T> trả về tương lai, tương lai ấy có kiểu dữ liệu là T
  // Future<String>
  // Xử lý lấy dữ liệu từ csdl
  final result = await Future.delayed(
    Duration(seconds: 3),
    () {
      return 'Data';
    },
  );

  return result;
}
