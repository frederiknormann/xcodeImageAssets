# XCodeImageAssets

This shell script creates app icon assets for iOS, watchOS, tvOS, MacOS, iTunes &amp; Messages for XCODE 10 from just one file

- createXCodeIconAssets.sh for creation of App Icon Assets
- createXCodeAsset.sh for creation of Image Asset (@1x, @2x, @3x)

## Dependencies

This script denpends on ImageMagick

### Install ImageMagick

In Terminal:
	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
	$ brew install imagemagick

## Instructions

### Install XCodeImageAssets

Download and unzip XCodeImageAssets

In terminal:
	$ cp XCodeImageAssets /usr/local/XCodeImageAssets
	$ ln -s /usr/local/bin/createXCodeIconAssets.sh /usr/local/XCodeImageAssets/createXCodeIconAssets.sh
	$ ln -s /usr/local/bin/createXCodeAsset.sh /usr/local/XCodeImageAssets/createXCodeAsset.sh

### Usage

createXCodeIconAssets.sh:
	$0 <source_file>
	$0 <source_file> <output_dir>

createXCodeAssets.sh:
	$0 <source_file>

## Credits

Arthur Krupa - resize-mobile-assets (https://github.com/arthurkrupa/resize-mobile-assets)

## License

This script is licensed under the terms of the MIT license.
