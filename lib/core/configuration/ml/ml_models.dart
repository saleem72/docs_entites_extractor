//

class MLModels {
  MLModels._internal();

  static const String _path = 'assets/ml/';

  /// Original it is from google
  static const String objectLabeler = '${_path}object_labeler.tflite';

  /// don't know the source not working
  static const String objectLocalizer = '${_path}object_localizer.tflite';

  /// https://www.kaggle.com/ same as original
  static const String mobileObjectLabeler =
      '${_path}mobile_object_labeler_v1.tflite';

  /// https://www.kaggle.com/models/tensorflow/mnasnet not working
  static const String mnasnet = '${_path}mnasnet.tflite';

  /// efficientnet https://www.kaggle.com/models/tensorflow/efficientnet
  static const String efficientnet = '${_path}efficientnet.tflite';

  /// model_with_metadata
  static const String efficientnetWithMetadata =
      '${_path}model_with_metadata.tflite';

  /// efficientNet_float32
  static const String efficientNetFloat32 =
      '${_path}efficientNet_float32.tflite';
}


// 1.	Determine the correct normalization parameters (mean and std) that your model 
//    expects. This information is usually provided in the model’s documentation or 
//    the dataset it was trained on.
// 2.	Normalize the image data by applying these parameters.