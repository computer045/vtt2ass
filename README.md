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

```bash
$ vtt2ass -h
VTT2ASS

Usage: vtt2ass  [OPTIONS] [INPUT] [OUTPUT]

Convert VTT subtitles to ASS subtitles

Arguments:
  INPUT   Input directory or file (default: current directory)
  OUTPUT  Output directory (default: current directory)

Options:
  -f, --font-family STRING  Specify a font family for the subtitles (default:
                            'Open Sans Semibold')
  -s, --font-size INTEGER   Specify a font size for the subtitles (default:
                            52)
  -h, --help                Print usage
  -x, --noout               Prevents the command from writing the resulting
                            file(s) to the output folder
  -q, --quiet               Prevent the command from outputing to the console
  -t, --title STRING        Specify a title for you file. If the input is a
                            directory, all files will share the same title.
  -v, --version             Show version

Examples:
  Convert files in a specific directory
    $ vtt2ass /path/to/file_input /path/to/file_output
```

# Donate

If you want to support me, consider buying me a coffee.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y136P0E)