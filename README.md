# VTT to ASS

[![Gem Version](https://badge.fury.io/rb/vtt2ass.svg)](https://badge.fury.io/rb/vtt2ass)

## Description

This is a simple CLI (Command Line Interface) application to convert VTT files to ASS subtitles.

This application is originally based on the `vttconvert` module of [anidl/hidive-downloader-nx](https://github.com/anidl/hidive-downloader-nx) repository. The [maxwbot/maxwhidive](https://github.com/maxwbot/maxwhidive) repository was also used as inspiration for handling the positionning of subs.

Those two tools were missing features and didn't work well on a lot of more complex subtitles files. For that reason, I wrote a new tool that can handle everything.

### Features

- Convert simple VTT files
- Convert complex VTT files with positioning
- Convert Hidive VTT files with CSS styling
- Convert subtitles in batches by specifying the input directory
- Handles subtitles made for lower resolution video
- Can add offset to subtitle lines
- Can output result to the CLI
- Can output to the specifed directory
- Can change the base font size
- Can specify a custom font family for non-styled lines
- Can add a title to the converted files

## Requirements

- ruby 2.7.2 or newer

Development is currently done on ruby 3.0+, but the Gitlab runner for builds works with ruby version 2.7.2. Older versions of ruby may be compatible, but they won't be tested.

## Installation

To install:
```bash
$ gem install vtt2ass
```

## Usage

- Empty arguments lists the available commands
```bash
$ vtt2ass
Commands:
  vtt2ass convert INPUT   # Run the VTT to ASS conversion for the specified file(s)
  vtt2ass help [COMMAND]  # Describe available commands or one specific command
  vtt2ass version         # Show version
```

- Help command shows available options of the specified command
```bash
$ vtt2ass help convert
Usage:
  vtt2ass convert INPUT

Options:
  -o, [--output=OUTPUT]            # Output directory of the converted file
  -t, [--title=TITLE]              # Specify a title for you file. If the input is a directory, all files will share the same title.
  -s, [--font-size=N]              # Specify a font size for the subtitles
                                   # Default: 52
  -f, [--font-family=FONT_FAMILY]  # Specify a font family for the subtitles
                                   # Default: Open Sans Semibold
  -c, [--css=CSS]                  # Specify a CSS file path for Hidive subs
  -l, [--line-offset=N]            # Specify a line offset for the main dialog (e.g. 50 lowers the text line by 50px of the total height)
                                   # Default: 0
  -w, [--width=N]                  # Specify the video width
                                   # Default: 1920
  -h, [--height=N]                 # Specify the video height
                                   # Default: 1080
  -q, [--quiet], [--no-quiet]      # Don't output to the console

Run the VTT to ASS conversion for the specified file(s)
```

- Convert command
```bash
$ vtt2ass convert ./path/to/input/ -o ./path/to/output/ -l 50 -q
```

- Version command shows the application version
```bash
$ vtt2ass version
0.3.3
```

## Contributing

Contributions are welcome. Create an *Issue* on Gitlab and link it with a *Pull Request* of the changes made. The changes needs to pass the ruby tests.

```
$ rake test
```

## Build

To build a gem file for local installation:
```bash
$ git clone https://gitlab.com/dkb-weeblets/vtt2ass.git
$ cd vtt2ass/
$ gem build vtt2ass.gemspec
```

To install the gem file:
```bash
$ gem install ./vtt2ass-0.3.5.gem
```

## License

Licensed under the **MIT** Licence. For more information read the `LICENSE.txt` file.

## Donate

If you want to support me, consider buying me a coffee.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y136P0E)