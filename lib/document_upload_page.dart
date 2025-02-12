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
      _saveFile(file);
    }
  }

  /// Capture an image using the device camera
  Future<void> _captureImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _capturedImages.add(File(image.path));
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

    _saveFile(file);
  }

  /// Save file and update the list instead of replacing
  void _saveFile(File file) {
    setState(() {
      _uploadedFiles.add(file);
      _capturedImages.clear();
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
    return Scaffold(
      appBar: AppBar(title: Text("Upload ${widget.documentType}")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            /// Buttons for uploading documents
            ElevatedButton.icon(
              onPressed: _pickPDF,
              icon: Icon(Icons.upload_file),
              label: Text("Upload PDF"),
            ),
            ElevatedButton.icon(
              onPressed: _captureImage,
              icon: Icon(Icons.camera_alt),
              label: Text("Take Picture"),
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
                    onPressed: _convertToPDF,
                    icon: Icon(Icons.picture_as_pdf),
                    label: Text("Save as PDF"),
                  ),
                ],
              ),

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
          ],
        ),
      ),
    );
  }
}