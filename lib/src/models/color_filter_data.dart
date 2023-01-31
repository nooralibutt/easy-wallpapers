class ColorFilterData {
  final String name;
  final List<double> matrix;

  const ColorFilterData(this.name, this.matrix);

  static const List<ColorFilterData> filters = [
    ColorFilterData('Normal', _NORMAL_MATRIX),
    ColorFilterData('Gray', _GRAY_MATRIX),
    ColorFilterData('Technicolor', _Technicolor_MATRIX),
    ColorFilterData('Sepium', _Sepium_MATRIX),
    ColorFilterData('Vintage', _VINTAGE_MATRIX),
    ColorFilterData('BlueSky', _BlueSky_MATRIX),
    ColorFilterData('High Exposure', _GrayHighExposure_MATRIX),
    ColorFilterData('Sepia', _SEPIA_MATRIX),
    ColorFilterData('Greyscale', _GREYSCALE_MATRIX),
    ColorFilterData('Sweet', _SWEET_MATRIX),
    ColorFilterData('High Brightness', _GrayHighBrightness_MATRIX),
    ColorFilterData('Low Brightness', _GrayLowBrightness_MATRIX),
    ColorFilterData('Invert', _Invert_MATRIX),
    ColorFilterData('Protanomaly', _Protanomaly_MATRIX),
    ColorFilterData('Vintage', _Vintage_MATRIX),
    ColorFilterData('Kodachrome', _Kodachrome_MATRIX),
    ColorFilterData('BlueSky', _BlueSky_MATRIX),
    ColorFilterData('BGR', _BGR_MATRIX),
  ];
}

const _NORMAL_MATRIX = [
  1.0, // R
  0.0, // G
  0.0, // B
  0.0, // A
  0.0, // Offset
  //
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  0.0, // Offset
  //
  0.0, // R
  0.0, // G
  1.0, // B
  0.0, // A
  0.0, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];

const _GRAY_MATRIX = [
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const _SWEET_MATRIX = [
  1.0,
  0.0,
  0.2,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];
const _SEPIA_MATRIX = [
  0.39,
  0.769,
  0.189,
  0.0,
  0.0,
  0.349,
  0.686,
  0.168,
  0.0,
  0.0,
  0.272,
  0.534,
  0.131,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const _GREYSCALE_MATRIX = [
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const _VINTAGE_MATRIX = [
  0.9,
  0.5,
  0.1,
  0.0,
  0.0,
  0.3,
  0.8,
  0.1,
  0.0,
  0.0,
  0.2,
  0.3,
  0.5,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const _GrayHighExposure_MATRIX = [
  1.0,
  1.0,
  1.0,
  0.0,
  0.0,
  1.0,
  1.0,
  1.0,
  0.0,
  0.0,
  1.0,
  1.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];

const _GrayHighBrightness_MATRIX = [
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  50.0, // Offset
  //
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  50.0, // Offset
  //
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  50.0, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];

const _GrayLowBrightness_MATRIX = [
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  -50.0, // Offset
  //
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  -50.0, // Offset
  //
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  -50.0, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];

const _Invert_MATRIX = [
  -1.0,
  0.0,
  0.0,
  0.0,
  255.0,
  0.0,
  -1.0,
  0.0,
  0.0,
  255.0,
  0.0,
  0.0,
  -1.0,
  0.0,
  255.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const _Sepium_MATRIX = [
  1.3,
  -0.3,
  1.1,
  0.0,
  0.0,
  0.0,
  0.333,
  0.667,
  0.0,
  0.0,
  0.0,
  0.0,
  0.125,
  0.875,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];

const _Protanomaly_MATRIX = [
  0.817,
  0.183,
  0.0,
  0.0,
  0.0,
  0.0,
  1.3,
  0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  0.8,
  0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const _Technicolor_MATRIX = [
  1.912, // R
  -0.854, // G
  -0.091, // B
  0.0, // A
  0.0, // Offset
  //
  -0.308, // R
  1.765, // G
  -0.106, // B
  0.0, // A
  0.0, // Offset
  //
  -0.231, // R
  -0.750, // G
  1.842, // B
  0.0, // A
  0.0, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0,
];
const _BlueSky_MATRIX = [
  1.912, // R
  -1.0, // G
  0.183, // B
  0.0, // A
  0.046, // Offset
  //
  0.0, // R
  1.0, // G
  0.0, // B
  0.0, // A
  0.0, // Offset
  //
  0.0, // R
  0.0, // G
  1.0, // B
  0.0, // A
  0.0, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];

const _Kodachrome_MATRIX = [
  1.128, // R
  -0.396, // G
  -0.039, // B
  0.0, // A
  0.152, // Offset
  //
  -0.164, // R
  1.083, // G
  -0.054, // B
  0.0, // A
  -0.0000101651109560702, // Offset
  //
  -0.167, // R
  -0.560, // G
  1.601, // B
  0.0, // A
  0.042, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];
const _Vintage_MATRIX = [
  0.627, // R
  0.320, // G
  -0.039, // B
  0.0, // A
  0.037, // Offset
  //
  0.025, // R
  0.644, // G
  0.032, // B
  0.0, // A
  0.029, // Offset
  //
  0.046, // R
  -0.085, // G
  0.524, // B
  0.0, // A
  0.020, // Offset
  //
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];
const _BGR_MATRIX = [
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0, // AR
  0.0, // AG
  0.0, // AB
  1.0, // AA
  0.0, // Offset
];
