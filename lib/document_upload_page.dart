import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class DocumentUploadPage extends StatefulWidget {
  final String documentType;

  const DocumentUploadPage({super.key,required this.documentType});

  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  File? _selectedFile;
  final List<File> _capturedImages = [];
  final Map<String,File?> _documentStorage = {};

  @override
  void initState(){
    super.initState();
    _loadSavedFile();///loads existing file if available
  }

  /// Load saved file for this document type (if exists)
  Future<void> _loadSavedFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/${widget.documentType}.pdf";
    final file = File(filePath);

    if (file.existsSync()) {
      setState(() {
        _selectedFile = file;
      });
    }
  }


  /// Select a PDF from device storage
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
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

  /// Convert multiple captured images into a single PDF file
  Future<void> _convertToPDF() async {
    if (_capturedImages.isEmpty) return;

    final pdf = pw.Document();
    for (var imgFile in _capturedImages) {
      final image = pw.MemoryImage(imgFile.readAsBytesSync());
      pdf.addPage(
          pw.Page(
              build: (pw.Context context) => pw.Center(child: pw.Image(image))));
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/${widget.documentType}.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    _saveFile(file);
  }

  /// Remove an image from the captured list
  void _removeImage(int index) {
    setState(() {
      _capturedImages.removeAt(index);
    });
  }

  /// Save file and update state
  void _saveFile(File file) {
    setState(() {
      _selectedFile = file;
      _capturedImages.clear();
      _documentStorage[widget.documentType] = file; // Store document separately
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.documentType} saved!')));
  }

  /// Open the saved document
  void _openFile() {
    if (_selectedFile != null) {
      OpenFile.open(_selectedFile!.path);
    }
  }
  /// Delete the uploaded document
  void _deleteFile() {
    if (_selectedFile != null) {
      try {
        _selectedFile!.deleteSync();
        setState(() {
          _selectedFile = null;
          _documentStorage.remove(widget.documentType);
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.documentType} deleted!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting file!')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload ${widget.documentType}")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_selectedFile != null) Text("Selected: ${_selectedFile!.path.split('/').last}"),
          if (_selectedFile != null)
            ElevatedButton(
                onPressed: _openFile,
                child: Text("View Document")
            ),
          if (_selectedFile != null)
            ElevatedButton.icon(
              onPressed: _deleteFile,
              icon: Icon(Icons.delete, color: Colors.white),
              label: Text("Delete Document"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
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

          if (_capturedImages.isNotEmpty)
            ElevatedButton.icon(
              onPressed: _convertToPDF,
              icon: Icon(Icons.picture_as_pdf),
              label: Text("Save as PDF"),
            ),
          /// Display captured images in a horizontal list
          if (_capturedImages.isNotEmpty)
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
                          onTap: () => _removeImage(index),
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
        ],
      ),
    );
  }
}