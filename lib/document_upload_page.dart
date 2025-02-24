import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class DocumentUploadPage extends StatefulWidget {
  final String documentType;

  const DocumentUploadPage({super.key, required this.documentType});

  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  List<File> _uploadedFiles = [];
  final List<File> _capturedImages = [];
  int _selectedIndex = 0;

  ///variable to track the text in the take picture button
  String _cameraButtonText = "Take Picture";

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Add navigation functionality if required
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home'); // Navigate to Home Page
          break;
        case 1:
          Navigator.pushNamed(context, '/settings'); // Navigate to Settings
          break;
        case 2:
          Navigator.pushNamed(context, '/features'); // Navigate to Features Page
          break;
        case 3:
          Navigator.pushNamed(context, '/profile'); // Navigate to Profile Page
          break;
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _loadSavedFiles();
  }

  /// Load all saved PDFs for this document type
  Future<void> _loadSavedFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    List<File> loadedFiles = files
        .where((file) => file.path.contains(widget.documentType) && file.path.endsWith('.pdf'))
        .map((file) => File(file.path))
        .toList();

    setState(() {
      _uploadedFiles = loadedFiles;
    });
  }

  /// Select a PDF from device storage
  Future<void> _pickPDF() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      final file = File(result.files.single.path!);
      _showNameInputDialog(file);
    }
  }

  /// Capture an image using the device camera
  Future<void> _captureImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _capturedImages.add(File(image.path));

        /// Change button text to "Add Images" after taking the first picture
        if (_capturedImages.length == 1) {
          _cameraButtonText = "Add Images";
        }
      });
    }
  }
  /// Convert multiple captured images into a separate PDF file
  Future<void> _convertToPDF() async {
    if (_capturedImages.isEmpty) return;

    final pdf = pw.Document();
    for (var imgFile in _capturedImages) {
      final image = pw.MemoryImage(imgFile.readAsBytesSync());
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(image)),
        ),
      );
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        "${directory.path}/${widget.documentType}_${DateTime.now().millisecondsSinceEpoch}.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    _showNameInputDialog(null, pdf);
  }

  ///  Show input dialog for custom document name
  void _showNameInputDialog(File? file, [pw.Document? pdf]) {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Document Name"),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String customName = nameController.text.trim();
                if (customName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Document name cannot be empty!")),
                  );
                  return;
                }

                final directory = await getApplicationDocumentsDirectory();
                final filePath = "${directory.path}/${customName}.pdf";
                final savedFile = File(filePath);

                if (file != null) {
                  await file.copy(savedFile.path); // Rename uploaded PDF
                } else if (pdf != null) {
                  await savedFile.writeAsBytes(await pdf.save()); // Save captured images as PDF
                }

                _saveFile(savedFile);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }


  /// Save file and update the list instead of replacing
  void _saveFile(File file) {
    setState(() {
      _uploadedFiles.add(file);
      _capturedImages.clear();
      _cameraButtonText="Take picture";
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.documentType} saved!')));
  }

  /// Open a selected document
  void _openFile(File file) {
    OpenFile.open(file.path);
  }

  /// Delete a specific document
  void _deleteFile(File file) {
    try {
      file.deleteSync();
      setState(() {
        _uploadedFiles.remove(file);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File deleted!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting file!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"), ///Background Image
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("Upload ${widget.documentType}")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              /// List of Uploaded/Generated PDFs
              if (_uploadedFiles.isNotEmpty) ...[
                SizedBox(height: 20),
                Text("Uploaded Documents:", style: TextStyle(fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _uploadedFiles.length,
                  itemBuilder: (context, index) {
                    File file = _uploadedFiles[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(file.path.split('/').last),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.visibility, color: Colors.blue),
                              onPressed: () => _openFile(file),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteFile(file),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
              /// Buttons for uploading documents
              ElevatedButton.icon(
                onPressed: _pickPDF,
                icon: Icon(Icons.upload_file),
                label: Text("Upload PDF"),
              ),

              if (_capturedImages.isEmpty)
                ElevatedButton.icon(
                  onPressed: _captureImage,
                  icon: Icon(Icons.camera_alt),
                  label: Text(_cameraButtonText),
                ),

              /// Display captured images before converting to PDF
              if (_capturedImages.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: 10),
                    Text("Captured Images:"),
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _capturedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.file(
                                  _capturedImages[index],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => setState(() => _capturedImages.removeAt(index)),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.close, size: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _captureImage,
                      icon: Icon(Icons.camera_alt),
                      label: Text(_cameraButtonText),
                    ),
                    ElevatedButton.icon(
                      onPressed: _convertToPDF,
                      icon: Icon(Icons.picture_as_pdf),
                      label: Text("Save as PDF"),
                    ),
                  ],
                ),
            ],
          ),
        ),

        /// navigation bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavItemTapped,
          backgroundColor: Colors.blue[900],
          selectedItemColor: Color(0xFFACE6FC),
          unselectedItemColor: Color(0xFFACE6FC),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.home),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.settings),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.lightbulb),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.person),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}