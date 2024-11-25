import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
    final ImagePicker _picker = ImagePicker(); // Instance ImagePicker
  XFile? _selectedImage; // Variabel untuk menyimpan gambar yang dipilih

  Future<void> _pickImage() async {
    // Memilih gambar dari galeri
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image; // Simpan gambar yang dipilih
      });
      print('Image selected: ${image.path}');
    } else {
      print('No image selected');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Add Blog',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            // aksi
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    color: Colors.blue,
                    width: double.infinity,
                    height: 200,
                    child: _selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate,
                                  size: 40, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                'Tambahkan Foto/Video',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : Image.file(
                            File(_selectedImage!
                                .path), // Tampilkan gambar yang dipilih
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
                            TextField(
                decoration: InputDecoration(
                  labelText: 'Apa yang kamu Pikirkan? 🤔',
                  border: OutlineInputBorder(),
                  hintText: 'Tulis Sesuatu disini... ✏️',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Postingan di tambahkan'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Tambahkan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
