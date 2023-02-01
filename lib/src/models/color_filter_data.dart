class ColorFilterData {
  final String name;
  final List<double> matrix;

  const ColorFilterData(this.name, this.matrix);

  static const List<ColorFilterData> filters = [
    ColorFilterData('Normal', _normalMatrix),
    ColorFilterData('Gray', _grayMatrix),
    ColorFilterData('Technicolor', _technicolorMatrix),
    ColorFilterData('Sepium', _sepiumMatrix),
    ColorFilterData('Vintage', _vintageMatrix),
    ColorFilterData('BlueSky', _blueSkyMatrix),
    ColorFilterData('High Exposure', _grayHighExposureMatrix),
    ColorFilterData('Sepia', _sepiaMatrix),
    ColorFilterData('Greyscale', _greyScaleMatrix),
    ColorFilterData('Sweet', _sweetMatrix),
    ColorFilterData('High Brightness', _grayHighBrightnessMatrix),
    ColorFilterData('Low Brightness', _grayLowBrightnessMatrix),
    ColorFilterData('Invert', _invertMatrix),
    ColorFilterData('Protanomaly', _protanomalyMatrix),
    ColorFilterData('Vintage', _vintageNewMatrix),
    ColorFilterData('Kodachrome', _kodachromeMatrix),
    ColorFilterData('BlueSky', _blueSkyMatrix),
    ColorFilterData('BGR', _bgrMatrix),
  ];
}

const _normalMatrix = [
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

const _grayMatrix = [
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
const _sweetMatrix = [
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
const _sepiaMatrix = [
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

const _greyScaleMatrix = [
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

const _vintageMatrix = [
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

const _grayHighExposureMatrix = [
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

const _grayHighBrightnessMatrix = [
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

const _grayLowBrightnessMatrix = [
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

const _invertMatrix = [
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
const _sepiumMatrix = [
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

const _protanomalyMatrix = [
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
const _technicolorMatrix = [
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
const _blueSkyMatrix = [
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

const _kodachromeMatrix = [
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
const _vintageNewMatrix = [
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
const _bgrMatrix = [
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
