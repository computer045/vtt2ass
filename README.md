# VTT to ASS

[![Gem Version](https://badge.fury.io/rb/vtt2ass.svg)](https://badge.fury.io/rb/vtt2ass)

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
    -i, --input PATH                 Specify a custom input file or directory (default: './')
    -o, --output PATH                Specify a custom output directory (default: './')
    -f, --font-family FONT           Specify a font family for the subtitles (default: 'Open Sans Semibold')
    -s, --font-size SIZE             Specify a font size for the subtitles (default: 52)
    -v, --version                    Show version
```

# Donate

If you want to support me, consider buying me a coffee.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y136P0E)