// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:provider/provider.dart';
// import '../services/product_service.dart';
// import '../models/product.dart';

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   final TextRecognizer _textRecognizer = TextRecognizer();

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//     _controller = CameraController(firstCamera, ResolutionPreset.medium);
//     _initializeControllerFuture = _controller.initialize();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _textRecognizer.close();
//     super.dispose();
//   }

//   Future<void> _scanExpiryDate() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
//       final recognizedText = await _textRecognizer.processImage(
//         InputImage.fromFilePath(image.path),
//       );
      
//       // 여기서 인식된 텍스트를 파싱하여 유통기한을 추출합니다.
//       // 실제 구현에서는 더 복잡한 로직이 필요할 수 있습니다.
//       final expiryDate = DateTime.now().add(Duration(days: 30)); // 예시로 30일 후로 설정
      
//       final productService = Provider.of<ProductService>(context, listen: false);
//       await productService.addProduct(Product(name: "새 상품", expiryDate: expiryDate));
      
//       Navigator.pop(context);
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('유통기한 스캔')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera),
//         onPressed: _scanExpiryDate,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';
import '../models/product.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('유통기한 스캔 (시뮬레이션)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text('시뮬레이터에서는 카메라를 사용할 수 없습니다.'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('더미 데이터 추가'),
              onPressed: () => _addDummyProduct(context),
            ),
          ],
        ),
      ),
    );
  }

  void _addDummyProduct(BuildContext context) {
    final productService = Provider.of<ProductService>(context, listen: false);
    final dummyProduct = Product(
      name: "더미 상품 ${DateTime.now().millisecondsSinceEpoch}",
      expiryDate: DateTime.now().add(Duration(days: 30)),
    );
    
    productService.addProduct(dummyProduct);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('더미 상품이 추가되었습니다: ${dummyProduct.name}')),
    );
    
    Navigator.pop(context);
  }
}