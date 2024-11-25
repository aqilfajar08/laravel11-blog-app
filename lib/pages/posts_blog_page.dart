import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_laravel_blog/constant.dart';
import 'package:flutter_laravel_blog/pages/home_page.dart';

class PostsBlogPage extends StatefulWidget {
  const PostsBlogPage({super.key});

  @override
  State<PostsBlogPage> createState() => _PostsBlogPageState();
}

class _PostsBlogPageState extends State<PostsBlogPage> {
  // Color _backgroundColor = Colors.blueGrey;
  // final ImagePicker _picker = ImagePicker(); // Instance ImagePicker
  // XFile? _selectedImage; // Variabel untuk menyimpan gambar yang dipilih

  // Future<void> _pickImage() async {
  //   // Memilih gambar dari galeri
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       _selectedImage = image; // Simpan gambar yang dipilih
  //     });
  //     print('Image selected: ${image.path}');
  //   } else {
  //     print('No image selected');
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         'Add Blog',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => HomePage(),
  //             ),
  //           );
  //         },
  //         icon: Icon(
  //           Icons.arrow_back_ios,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //     body: SafeArea(
  //         child: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           children: [
  //             MouseRegion(
  //               cursor: SystemMouseCursors.click,
  //               child: GestureDetector(
  //                 onTap: _pickImage,
  //                 child: Container(
  //                   color: _backgroundColor,
  //                   width: double.infinity,
  //                   height: 200,
  //                   child: _selectedImage == null
  //                       ? Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Icon(Icons.add_photo_alternate,
  //                                 size: 40, color: Colors.white),
  //                             SizedBox(height: 8),
  //                             Text(
  //                               'Tambahkan Foto/Video',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                           ],
  //                         )
  //                       : Image.file(
  //                           File(_selectedImage!
  //                               .path), // Tampilkan gambar yang dipilih
  //                           fit: BoxFit.cover,
  //                         ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Apa yang kamu Pikirkan? 🤔',
  //                 border: OutlineInputBorder(),
  //                 hintText: 'Tulis Sesuatu disini... ✏️',
  //               ),
  //               keyboardType: TextInputType.multiline,
  //               minLines: 5,
  //               maxLines: 8,
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 8),
  //               child: kTextButton("Post", () {}),
  //             )
  //           ],
  //         ),
  //       ),
  //     )),
  //   );
  // }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Blog',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView(
                children: [
                  Container(
                    color: Colors.blueGrey,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        image: _imageFile == null
                            ? null
                            : DecorationImage(
                                image: FileImage(_imageFile ?? File('')),
                                fit: BoxFit.cover
                    child: IconButton(
                        onPressed: () {
                          getImage();
                        },
                        icon: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.black38,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _txtControllerBody,
                        decoration: InputDecoration(
                          labelText: 'Apa yang kamu Pikirkan? 🤔',
                          border: OutlineInputBorder(),
                          hintText: 'Tulis Sesuatu disini... ✏️',
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 8,
                        validator: (val) =>
                            val!.isEmpty ? "Post Body is Required" : null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: kTextButton("Post", () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loading = !_loading;
                        });
                      }
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
