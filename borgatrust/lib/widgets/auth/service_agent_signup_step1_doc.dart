import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // Required for File type if you were to use it directly.
import '../../utils/app_theme.dart';
import '../custom_button.dart';

class ServiceAgentSignupStep1Doc extends StatefulWidget {
  final Function(PlatformFile?) onFilePicked;
  final PlatformFile? pickedFile;

  const ServiceAgentSignupStep1Doc({
    super.key,
    required this.onFilePicked,
    this.pickedFile,
  });

  @override
  State<ServiceAgentSignupStep1Doc> createState() => _ServiceAgentSignupStep1DocState();
}

class _ServiceAgentSignupStep1DocState extends State<ServiceAgentSignupStep1Doc> {
  bool _isLoading = false;

  Future<void> _pickDocument() async {
    setState(() {
      _isLoading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );

      if (result != null) {
        widget.onFilePicked(result.files.first);
      } else {
        // User canceled the picker
        widget.onFilePicked(null);
      }
    } catch (e) {
      // Handle errors, e.g., show a snackbar
      widget.onFilePicked(null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business Verification",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "Please upload a business registration document (e.g., Certificate of Incorporation, Business License).",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        CustomButton(
          text: "Select Document",
          onPressed: _pickDocument,
          isPrimary: true,
          isFullWidth: false, // Make button not full width
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        const SizedBox(height: 16),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (widget.pickedFile != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryLight),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryLight.withOpacity(0.1),
            ),
            child: Row(
              children: [
                const Icon(Icons.file_present, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.pickedFile!.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.error),
                  onPressed: () {
                    widget.onFilePicked(null); // Clear the picked file
                  },
                )
              ],
            ),
          )
        else
          Text(
            "No document selected.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textLight),
          ),
        const SizedBox(height: 8),
        Text(
          "Accepted formats: PDF, DOC, DOCX, JPG, PNG. Max size: 5MB.", // Example text
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
