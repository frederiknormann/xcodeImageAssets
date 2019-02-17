# XCodeImageAssets

This shell script creates app icon assets for iOS, watchOS, tvOS, MacOS, iTunes, Messages &amp; Distribution for XCode 10 from just one file

- createImageAssets.sh for creation of App Icon Assets
- resizeAssets.sh for creation of Image Asset (@1x, @2x, @3x)

## Dependencies

This script depends on ImageMagick

### Install ImageMagick

In Terminal:

	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
	$ brew install imagemagick

## Instructions

### Install XCodeImageAssets

Download and unzip XCodeImageAssets

In Terminal:

	$ sudo cp -r XCodeImageAssets /usr/local/XCodeImageAssets
	$ ln -s /usr/local/XCodeImageAssets/createImageAssets.sh /usr/local/bin/createImageAssets.sh
	$ ln -s /usr/local/XCodeImageAssets/resizeAssets.sh /usr/local/bin/resizeAssets.sh

### Usage

createImageAssets.sh:

	$0 <source_file>
	$0 <source_file> <output_dir>

resizeAssets.sh:

	$0 <source_dir> <output_dir>

### Description

#### createImageAssets.sh:

This script generates XCode app icon assets for the following from a single image file.

iOS, watchOS, tvOS, macOS, iTunes, Messages & Distribution

<source_file> - The source image file, should be at least 1024x1024px in size (preferably 1536x1536px).
<output_dir> - The destination path where icons will be generated.

After export simply replace the directory in the assets file for the desired OS

#### resizeAssets.sh:

This script generates image assets (x1 x2 x3) to be used in iOS apps etc.

<source_dir> - The source image directory. Images inside it is in @3x sizing.
<output_dir> - The destination path where assets will be generated.

Image files with names ending with "Template" (e.g. "IconPlusTemplate.png") will be converted into template image sets.

## Credits

Arthur Krupa - resize-mobile-assets (https://github.com/arthurkrupa/resize-mobile-assets)

## License

This script is licensed under the terms of the MIT license.
