# VTT to ASS

This is a simple application to convert VTT files to ASS subtitles.

## Requirements
- ruby 2.7.2 or newer

It might work with older versions of ruby, but it hasn't been tested

## Installation

To install:
```bash
gem install vtt2ass
```

# Build

```bash
gem build vtt2ass.gemspec
```

## Usage

Add your VTT files in your `input` directory.

Run this command:
```bash
$ vtt2ass
```

## Help

```bash
$ vtt2ass -h
Usage: vtt2ass [options]

Specific options:
    -i, --input DIRECTORY            Specify a custom input directory (default: './input')
    -o, --output DIRECTORY           Specify a custom output directory (default: './output')
    -s, --font-size SIZE             Specify a font size for the subtitles (default: 52)
    -v, --version                    Show version
```
