import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/homepages/homepage_registered_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jet_set_go/authentication/welcome_screen.dart';

class DocumentUploadPage extends StatefulWidget {
  final String documentType;

  const DocumentUploadPage({super.key, required this.documentType});

  @override
  DocumentUploadPageState createState() => DocumentUploadPageState();
}

class DocumentUploadPageState extends State<DocumentUploadPage> {
  List<File> _uploadedFiles = [];
  final List<File> _capturedImages = [];

  //to track the text in the take picture button
  String _cameraButtonText = "Take Picture";


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
                final navigator = Navigator.of(context);

                String customName = nameController.text.trim();
                if (customName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Document name cannot be empty!")),
                  );
                  return;
                }

                final directory = await getApplicationDocumentsDirectory();
                final filePath = "${directory.path}/$customName.pdf";
                final savedFile = File(filePath);

                if (file != null) {
                  await file.copy(savedFile.path); // Rename uploaded PDF
                } else if (pdf != null) {
                  await savedFile.writeAsBytes(await pdf.save()); // Save captured images as PDF
                }

                _saveFile(savedFile);

                navigator.pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

///save file
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

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _signOutAndRedirect(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/header.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.09,
            left: screenWidth * 0.05,
            right: screenWidth * 0.2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'UPLOAD ${widget.documentType.toUpperCase()}',
                style: GoogleFonts.ubuntu(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.08,
            right: screenWidth * 0.04,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.white, size: 40),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: Offset(0, 50),
              onSelected: (value) {
                switch (value) {
                  case 'Home':
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageRegistered()),
                    );
                    break;
                  case 'Settings':
                    Navigator.pushNamed(context, '/settings');
                    break;
                  case 'Features':
                    Navigator.pushNamed(context, '/features');
                    break;
                  case 'Profile':
                    Navigator.pushNamed(context, '/profile');
                    break;
                  case 'Sign Out':
                    _signOutAndRedirect(context);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  _buildMenuItem(Icons.home, 'Home'),
                  _buildMenuItem(Icons.settings, 'Settings'),
                  _buildMenuItem(Icons.lightbulb, 'Features'),
                  _buildMenuItem(Icons.person, 'Profile'),
                  _buildMenuItem(Icons.logout, 'Sign Out'),
                ];
              },
            ),
          ),

          /// MAIN CONTENT BELOW HEADER
          Positioned.fill(
            top: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// UPLOADED FILES LIST
                    if (_uploadedFiles.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Text("Uploaded Documents:",
                          style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045)),
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

                    /// UPLOAD BUTTONS
                    SizedBox(height: 20),
                    // Upload PDF Button
                    ElevatedButton.icon(
                      onPressed: _pickPDF,
                      icon: Icon(Icons.upload_file, color: Colors.white, size: 22),
                      label: Text(
                        "Upload PDF",
                        style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF017BFE),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shadowColor: Colors.black26,
                        elevation: 5,
                      ),
                    ),
                    SizedBox(height: 10),
                    if (_capturedImages.isEmpty)
                    // Take Picture Button
                      ElevatedButton.icon(
                        onPressed: _captureImage,
                        icon: Icon(Icons.camera_alt, color: Colors.white, size: 22),
                        label: Text(
                          _cameraButtonText,
                          style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00AEEF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          shadowColor: Colors.black26,
                          elevation: 5,
                        ),
                      ),

                    /// ADD IMAGES & SAVE AS PDF SECTION
                      if (_capturedImages.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),

                            // Image Previews Section
                            Text("Captured Images:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              height: 120,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _capturedImages.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.file(
                                            _capturedImages[index],
                                            width: screenWidth * 0.22,
                                            height: screenWidth * 0.22,
                                            fit: BoxFit.cover,
                                          ),
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

                            SizedBox(height: screenHeight * 0.025),

                            // Buttons inside a Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ADD IMAGES BUTTON
                                Flexible(
                                  flex: 1,
                                  child: OutlinedButton.icon(
                                    onPressed: _captureImage,
                                    icon: Icon(Icons.add, color: Colors.blue, size: 22),
                                    label: FittedBox(
                                      child: Text(
                                        "Add Images",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.blue, width: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                // SAVE AS PDF BUTTON
                                Flexible(
                                  flex: 1,
                                  child: ElevatedButton.icon(
                                    onPressed: _convertToPDF,
                                    icon: Icon(Icons.picture_as_pdf, color: Colors.white, size: 22),
                                    label: FittedBox(
                                      child: Text(
                                        "Save as PDF",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                      shadowColor: Colors.black26,
                                      elevation: 4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}