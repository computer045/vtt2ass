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
$ ./bin/vtt2ass help convert
Usage:
  vtt2ass convert INPUT

Options:
  -o, [--output=OUTPUT]            # Output directory of the converted file
  -t, [--title=TITLE]              # Specify a title for you file. If the input is a directory, all files will share the same title.
  -s, [--font-size=N]              # Specify a font size for the subtitles
                                   # Default: 52
  -f, [--font-family=FONT_FAMILY]  # Specify a font family for the subtitles
                                   # Default: Open Sans Semibold
  -q, [--quiet], [--no-quiet]      # Don't output to the console

Run the VTT to ASS conversion for the specified file(s)
```

# Donate

If you want to support me, consider buying me a coffee.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y136P0E)