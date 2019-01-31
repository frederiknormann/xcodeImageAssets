#!/bin/bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

#SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ITUNES_DIR="iTunes"
IOS_DIR="iOS"
WATCHOS_DIR="watchOS"
MACOS_DIR="macOS"
APPICON_DIR="AppIcon.appiconset"
IMESSAGE_DIR="iMessage"
IMESSAGEICON_DIR="Messages Icon.stickersiconset"
TVOS_DIR="tvOS"
TVOSICON_DIR="App Icon & Top Shelf Image.brandassets"
DIST_DIR="Distribution"
JSON_DIR="jsonContentsFiles"
VERSION=1.0.0

usage() {
cat << EOF
VERSION: $VERSION
USAGE:
    $0 <source_file>
    $0 <source_file> <output_dir>

DESCRIPTION:
    This script generates XCode app icon assets for the following from a single image file.

    iOS, watchOS, tvOS, macOS, iTunes, Messages & Distribution

    <source_file> - The source image file, should be at least 1024x1024px in size (preferably 1536x1536px).
    <output_dir> - The destination path where icons will be generated.

    This script is depend on ImageMagick. So you must install ImageMagick first
    On OSX you can use 'sudo brew install ImageMagick' to install it

    After export simply replace the directory in the assets file for the desired OS

AUTHOR:
    Frederik Normann <dev@normann.me>

CREDIT:
    Arthur Krupa<arthur.krupa@gmail.com>

LICENSE:
    This script is licensed under the terms of the MIT license.

EXAMPLE:
    $0 icon.png ./iconAssets
EOF
}

success() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo -e "[${green}SUCCESS${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo -e "[${red}ERROR${normal}] $1"
}

# Check ImageMagick
command -v convert >/dev/null 2>&1 || { error >&2 "ImageMagick is not installed"; exit -1; }

SOURCE_FILE="$1"
OUTPUT_PATH="$2"

# Check param
if [[ $# = 1 ]] ; then
    OUTPUT_PATH="./IconAssets ($SOURCE_FILE)"
fi

if [[ $# = 0 ]] || [[ $# > 2 ]] ; then
	usage
	exit 1
fi

# Check if source path exist
if [ ! -f "$SOURCE_FILE" ] ; then
	error "source file doesn't exist"
	exit 1
fi

# Check if destination path exist
if [ ! -d "$OUTPUT_PATH" ];then
    mkdir -p "$OUTPUT_PATH"
fi

# Generate icons (https://developer.apple.com/library/ios/qa/qa1686/_index.html)
echo -e 'Generating files:'

ITUNES_OUTPUT="$OUTPUT_PATH/$ITUNES_DIR"
mkdir -p "$ITUNES_OUTPUT"
convert "$SOURCE_FILE" -resize 512x512 "$ITUNES_OUTPUT/iTunesArtwork.png"
convert "$SOURCE_FILE" -resize 1024x1024 "$ITUNES_OUTPUT/iTunesArtwork@2x.png"
convert "$SOURCE_FILE" -resize 1536x1536 "$ITUNES_OUTPUT/iTunesArtwork@3x.png"
echo -e '> iTunes artworks'

IOS_OUTPUT="$OUTPUT_PATH/$IOS_DIR/$APPICON_DIR"
mkdir -p "$IOS_OUTPUT"
convert "$SOURCE_FILE" -resize 20x20 "$IOS_OUTPUT/AppIcon-20pt@1x.png"
convert "$SOURCE_FILE" -resize 40x40 "$IOS_OUTPUT/AppIcon-20pt@2x.png"
convert "$SOURCE_FILE" -resize 60x60 "$IOS_OUTPUT/AppIcon-20pt@3x.png"
convert "$SOURCE_FILE" -resize 29x29 "$IOS_OUTPUT/AppIcon-29pt@1x.png"
convert "$SOURCE_FILE" -resize 58x58 "$IOS_OUTPUT/AppIcon-29pt@2x.png"
convert "$SOURCE_FILE" -resize 87x87 "$IOS_OUTPUT/AppIcon-29pt@3x.png"
convert "$SOURCE_FILE" -resize 40x40 "$IOS_OUTPUT/AppIcon-40pt@1x.png"
convert "$SOURCE_FILE" -resize 80x80 "$IOS_OUTPUT/AppIcon-40pt@2x.png"
convert "$SOURCE_FILE" -resize 120x120 "$IOS_OUTPUT/AppIcon-40pt@3x.png"
convert "$SOURCE_FILE" -resize 120x120 "$IOS_OUTPUT/AppIcon-60pt@2x.png"
convert "$SOURCE_FILE" -resize 180x180 "$IOS_OUTPUT/AppIcon-60pt@3x.png"
convert "$SOURCE_FILE" -resize 76x76 "$IOS_OUTPUT/AppIcon-76pt@1x.png"
convert "$SOURCE_FILE" -resize 152x152 "$IOS_OUTPUT/AppIcon-76pt@2x.png"
convert "$SOURCE_FILE" -resize 167x167 "$IOS_OUTPUT/AppIcon-83.5pt@2x.png"
convert "$SOURCE_FILE" -resize 1024x1024 "$IOS_OUTPUT/AppIcon-1024pt@1x.png"
cat "$SCRIPT_DIR/$JSON_DIR/iOS.json" > "$IOS_OUTPUT/Contents.json"
echo -e '> iOS app icons'

WATCHOS_OUTPUT="$OUTPUT_PATH/$WATCHOS_DIR/$APPICON_DIR"
mkdir -p "$WATCHOS_OUTPUT"
convert "$SOURCE_FILE" -resize 48x48 "$WATCHOS_OUTPUT/AppIcon-24pt@2x.png"
convert "$SOURCE_FILE" -resize 55x55 "$WATCHOS_OUTPUT/AppIcon-27.5pt@2x.png"
convert "$SOURCE_FILE" -resize 58x58 "$WATCHOS_OUTPUT/AppIcon-29pt@2x.png"
convert "$SOURCE_FILE" -resize 87x87 "$WATCHOS_OUTPUT/AppIcon-29pt@3x.png"
convert "$SOURCE_FILE" -resize 80x80 "$WATCHOS_OUTPUT/AppIcon-40pt@2x.png"
convert "$SOURCE_FILE" -resize 88x88 "$WATCHOS_OUTPUT/AppIcon-44pt@2x.png"
convert "$SOURCE_FILE" -resize 100x100 "$WATCHOS_OUTPUT/AppIcon-50pt@2x.png"
convert "$SOURCE_FILE" -resize 172x172 "$WATCHOS_OUTPUT/AppIcon-86pt@2x.png"
convert "$SOURCE_FILE" -resize 196x196 "$WATCHOS_OUTPUT/AppIcon-98pt@2x.png"
convert "$SOURCE_FILE" -resize 216x216 "$WATCHOS_OUTPUT/AppIcon-108pt@2x.png"
convert "$SOURCE_FILE" -resize 1024x1024 "$WATCHOS_OUTPUT/AppIcon-1024pt@1x.png"
cat "$SCRIPT_DIR/$JSON_DIR/watchOS.json" > "$WATCHOS_OUTPUT/Contents.json"
echo -e '> watchOS app icons'

MACOS_OUTPUT="$OUTPUT_PATH/$MACOS_DIR/$APPICON_DIR"
mkdir -p "$MACOS_OUTPUT"
convert "$SOURCE_FILE" -resize 16x16 "$MACOS_OUTPUT/AppIcon-16pt@1x.png"
convert "$SOURCE_FILE" -resize 32x32 "$MACOS_OUTPUT/AppIcon-16pt@2x.png"
convert "$SOURCE_FILE" -resize 32x32 "$MACOS_OUTPUT/AppIcon-32pt@1x.png"
convert "$SOURCE_FILE" -resize 64x64 "$MACOS_OUTPUT/AppIcon-32pt@2x.png"
convert "$SOURCE_FILE" -resize 128x128 "$MACOS_OUTPUT/AppIcon-128pt@1x.png"
convert "$SOURCE_FILE" -resize 256x256 "$MACOS_OUTPUT/AppIcon-128pt@2x.png"
convert "$SOURCE_FILE" -resize 256x256 "$MACOS_OUTPUT/AppIcon-256pt@1x.png"
convert "$SOURCE_FILE" -resize 512x512 "$MACOS_OUTPUT/AppIcon-256pt@2x.png"
convert "$SOURCE_FILE" -resize 512x512 "$MACOS_OUTPUT/AppIcon-512pt@1x.png"
convert "$SOURCE_FILE" -resize 1024x1024 "$MACOS_OUTPUT/AppIcon-512pt@2x.png"
cat "$SCRIPT_DIR/$JSON_DIR/macOS.json" > "$MACOS_OUTPUT/Contents.json"
echo -e '> macOS app icons'

IMESSAGE_OUTPUT="$OUTPUT_PATH/$IMESSAGE_DIR/$IMESSAGEICON_DIR"
mkdir -p "$IMESSAGE_OUTPUT"
convert "$SOURCE_FILE" -resize 58x58 "$IMESSAGE_OUTPUT/Icon-29pt@2x.png"
convert "$SOURCE_FILE" -resize 87x87 "$IMESSAGE_OUTPUT/Icon-29pt@3x.png"
convert "$SOURCE_FILE" -resize 120x90\! "$IMESSAGE_OUTPUT/Icon-60x45pt@2x.png"
convert "$SOURCE_FILE" -resize 180x135\! "$IMESSAGE_OUTPUT/Icon-60x45pt@3x.png"
convert "$SOURCE_FILE" -resize 134x100\! "$IMESSAGE_OUTPUT/Icon-67x50pt@2x.png"
convert "$SOURCE_FILE" -resize 148x110\! "$IMESSAGE_OUTPUT/Icon-74x55pt@2x.png"
convert "$SOURCE_FILE" -resize 1024x1024 "$IMESSAGE_OUTPUT/Icon-1024pt@1x.png"
convert "$SOURCE_FILE" -resize 54x40\! "$IMESSAGE_OUTPUT/Icon-27x20pt@2x.png"
convert "$SOURCE_FILE" -resize 81x60\! "$IMESSAGE_OUTPUT/Icon-27x20pt@3x.png"
convert "$SOURCE_FILE" -resize 64x48\! "$IMESSAGE_OUTPUT/Icon-32x24pt@2x.png"
convert "$SOURCE_FILE" -resize 96x72\! "$IMESSAGE_OUTPUT/Icon-32x24pt@3x.png"
convert "$SOURCE_FILE" -resize 1024x768\! "$IMESSAGE_OUTPUT/Icon-1024x768pt@1x.png"
cat "$SCRIPT_DIR/$JSON_DIR/iMessage.json" > "$IMESSAGE_OUTPUT/Contents.json"
echo -e '> iMessage app icons'

TVOS_OUTPUT="$OUTPUT_PATH/$TVOS_DIR"
mkdir -p "$TVOS_OUTPUT"
cp -a "$SCRIPT_DIR/$JSON_DIR/tvOS/." "$TVOS_OUTPUT"
convert "$SOURCE_FILE" -resize 1280x768\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon - App Store.imagestack/Front.imagestacklayer/Content.imageset/AppStoreIcon-1280x768pt@1x.png"
convert "$SOURCE_FILE" -resize 1280x768\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon - App Store.imagestack/Middle.imagestacklayer/Content.imageset/AppStoreIcon-1280x768pt@1x.png"
convert "$SOURCE_FILE" -resize 1280x768\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon - App Store.imagestack/Back.imagestacklayer/Content.imageset/AppStoreIcon-1280x768pt@1x.png"
convert "$SOURCE_FILE" -resize 400x240\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon.imagestack/Front.imagestacklayer/Content.imageset/AppIcon-400x240pt@1x.png"
convert "$SOURCE_FILE" -resize 800x480\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon.imagestack/Front.imagestacklayer/Content.imageset/AppIcon-400x240pt@2x.png"
convert "$SOURCE_FILE" -resize 400x240\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon.imagestack/Middle.imagestacklayer/Content.imageset/AppIcon-400x240pt@1x.png"
convert "$SOURCE_FILE" -resize 800x480\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon.imagestack/Middle.imagestacklayer/Content.imageset/AppIcon-400x240pt@2x.png"
convert "$SOURCE_FILE" -resize 400x240\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon.imagestack/Back.imagestacklayer/Content.imageset/AppIcon-400x240pt@1x.png"
convert "$SOURCE_FILE" -resize 800x480\! "$TVOS_OUTPUT/$TVOSICON_DIR/App Icon.imagestack/Back.imagestacklayer/Content.imageset/AppIcon-400x240pt@2x.png"
convert "$SOURCE_FILE" -resize 2320x720\! "$TVOS_OUTPUT/$TVOSICON_DIR/Top Shelf Image Wide.imageset/AppIconTopShelfWide-2320x720pt@1x.png"
convert "$SOURCE_FILE" -resize 4640x1440\! "$TVOS_OUTPUT/$TVOSICON_DIR/Top Shelf Image Wide.imageset/AppIconTopShelfWide-2320x720pt@2x.png"
convert "$SOURCE_FILE" -resize 1920x720\! "$TVOS_OUTPUT/$TVOSICON_DIR/Top Shelf Image.imageset/AppIconTopShelf-1920x720pt@1x.png"
convert "$SOURCE_FILE" -resize 3840x1440\! "$TVOS_OUTPUT/$TVOSICON_DIR/Top Shelf Image.imageset/AppIconTopShelf-1920x720pt@2x.png"
convert "$SOURCE_FILE" -resize 1920x1080\! "$TVOS_OUTPUT/Launch Image.launchimage/AppIconLaunchImage-1920x1080pt@1x.png"
convert "$SOURCE_FILE" -resize 3840x2160\! "$TVOS_OUTPUT/Launch Image.launchimage/AppIconLaunchImage-1920x1080pt@2x.png"
#cat "$SCRIPT_DIR/$JSON_DIR/tvOSAppIcon.json" > "$TVOS_APPICON_OUTPUT/Contents.json"
echo -e '> tvOS app icons'

DIST_OUTPUT="$OUTPUT_PATH/$DIST_DIR/"
mkdir -p "$DIST_OUTPUT"
convert "$SOURCE_FILE" -resize 57x57 "$DIST_OUTPUT/DistributionImage-57pt@1x.png"
convert "$SOURCE_FILE" -resize 512x512 "$DIST_OUTPUT/DistributionImage-512pt@1x.png"
echo -e '> Distribution images'

success "all icons generated"
