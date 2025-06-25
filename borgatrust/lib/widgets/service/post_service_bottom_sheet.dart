// File: lib/widgets/service/post_service_bottom_sheet.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../custom_button.dart'; // Assuming CustomButton is in widgets/
import '../custom_text_field.dart'; // Assuming CustomTextField is in widgets/

class PostServiceBottomSheet extends StatefulWidget {
  final ScrollController? scrollController; // Optional for DraggableScrollableSheet

  const PostServiceBottomSheet({Key? key, this.scrollController}) : super(key: key);

  @override
  State<PostServiceBottomSheet> createState() => _PostServiceBottomSheetState();
}

class _PostServiceBottomSheetState extends State<PostServiceBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory; // Made nullable, will be validated

  final List<String> _categories = [
    'Web Development',
    'Graphic Design',
    'Content Writing',
    'Event Planning',
    'Translation Services',
    'Legal Consulting',
    'Digital Marketing',
    'Tutoring & Education',
    'Home Services (Cleaning, Repair)',
    'Other',
  ];

  // Controllers for the form fields
  final TextEditingController _serviceTitleController = TextEditingController();
  final TextEditingController _serviceDescriptionController = TextEditingController();
  final TextEditingController _pricingDetailsController = TextEditingController(); // E.g., "GH₵ 50/hour", "GH₵ 200 per project"
  final TextEditingController _serviceTagsController = TextEditingController(); // For keywords

  @override
  void dispose() {
    _serviceTitleController.dispose();
    _serviceDescriptionController.dispose();
    _pricingDetailsController.dispose();
    _serviceTagsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process form data (e.g., send to backend)
      print('Service Title: ${_serviceTitleController.text}');
      print('Category: $_selectedCategory');
      print('Description: ${_serviceDescriptionController.text}');
      print('Pricing: ${_pricingDetailsController.text}');
      print('Tags: ${_serviceTagsController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service posted successfully! (Mock)'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Close the bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background, // Or AppColors.surface if you prefer white
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ]
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController, // For DraggableScrollableSheet
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 32), // Added more bottom padding
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle for dragging (optional, but good for DraggableScrollableSheet)
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Offer a New Service",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle("Service Details"),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Service Title",
                hintText: "E.g., Professional Logo Design, Full Stack Web App",
                controller: _serviceTitleController,
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter a service title' : null,
              ),
              const SizedBox(height: 16),
              _buildCategoryDropdown(),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Service Description",
                hintText: "Describe your service clearly. What do you offer? What's included?",
                controller: _serviceDescriptionController,
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty) ? 'Please describe your service' : null,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle("Pricing & Keywords"),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Pricing Details",
                hintText: "E.g., GH₵ 50/hour, GH₵ 200 per project, Custom Quote",
                controller: _pricingDetailsController,
                 validator: (value) => (value == null || value.isEmpty) ? 'Please enter pricing details' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Service Tags/Keywords (Optional)",
                hintText: "E.g., logo, branding, react, nodejs (comma separated)",
                controller: _serviceTagsController,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: "Post Service Offering",
                onPressed: _submitForm,
                isPrimary: true,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: "Select a category",
            filled: true,
            fillColor: AppColors.surface, // Or Colors.white
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Match CustomTextField
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Match CustomTextField
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textDark),
          items: _categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
          validator: (value) => value == null ? 'Please select a category' : null,
        ),
      ],
    );
  }
}
