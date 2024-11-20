//
import 'dart:io' as io;

import 'package:docs_entites_extractor/core/configuration/routing/app_screens.dart';
import 'package:docs_entites_extractor/core/data/helpers/image_detector.dart';
import 'package:docs_entites_extractor/core/domain/models/app_image_info.dart';
import 'package:docs_entites_extractor/core/presentation/widgets/image_info_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_core/my_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  io.File? _file;
  io.File? face;
  List<AppImageInfo> filesList = [];
  final ImageDetector _imageDetector = ImageDetector();
  bool isBusy = false;

  @override
  void dispose() {
    _imageDetector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => context.navigator.pushNamed(AppScreens.idScreen),
            icon: const Icon(Icons.camera),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearStuff,
        child: const Icon(Icons.clear),
      ),
      body: Stack(
        children: [
          _buildContent(context),
          LoadingView(isLoading: isBusy),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _file == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      size: 80,
                    ),
                    FilledButton(
                      onPressed: _getImage,
                      child: const Text('Pick image'),
                    ),
                  ],
                )
              : Image.file(_file!),
        ),
        const SizedBox(height: 16),
        _file == null
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FilledButton(
                          onPressed: _searchFaces,
                          child: const Text('Faces'),
                        ),
                        FilledButton(
                          onPressed: _searchObjects,
                          child: const Text('Objects'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
        face == null ? const SizedBox.shrink() : Image.file(face!),
        Expanded(
          child: filesList.isEmpty
              ? const SizedBox.shrink()
              : ListView.separated(
                  itemCount: filesList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ImageInfoCard(info: filesList[index]);
                  },
                ),
        )
      ],
    );
  }

  void _getImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    setState(() {
      _file = io.File(image.path);
    });
  }

  void _searchFaces() async {
    if (isBusy) {
      return;
    }
    setState(() {
      isBusy = true;
      face = null;
      filesList.clear();
    });

    final result = await _imageDetector.searchForPhoto(_file!);
    if (result == null) {
      setState(() {
        isBusy = false;
      });
      return;
    }

    setState(() {
      face = result;
      isBusy = false;
    });
  }

  void _searchObjects() async {
    if (isBusy) {
      return;
    }
    setState(() {
      isBusy = true;
      face = null;
      filesList.clear();
    });

    final result = await _imageDetector.searchForObjects(_file!);

    setState(() {
      filesList = result;
      isBusy = false;
    });
  }

  void _clearStuff() {
    setState(() {
      _file = null;
      face = null;
      filesList.clear();
    });

    _imageDetector.cleanTemp();
  }
}
