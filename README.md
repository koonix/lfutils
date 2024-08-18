# lfutils [Unmaintained 💀]

Useful scripts for the lf file manager.

* [Installation](#installation)
* [Utilities](#utilities)
  * [lfrun](#lfrun)
  * [lfpreviewer, lfcleaner](#lfpreviewer-lfcleaner)
  * [lfmount](#lfmount)
  * [lfselect](#lfselect)
* [Environment Variables](#environment-variables)
  * [LF_BAT_OPTS](#lf_bat_opts)
* [Dependencies](#dependencies)

Please take a look at the [dependencies](#dependencies)
section before using lfutils.

## Installation

There is an AUR package for Archlinux users:

```
paru -S lfutils-git
```

Otherwise:

```
git clone https://github.com/soystemd/lfutils.git
cd lfutils
sudo make install
```

Or just copy the scripts to a directory that's in yout PATH.

## Utilities

## lfrun

`lfrun` is a wrapper script for running lf, which
initializes ueberzug for image previews.

## lfpreviewer, lfcleaner

File previewer and cleaner scripts, for previewing files/media.

Add these lines to your lfrc:

```
set previewer lfpreviewer
set cleaner lfcleaner
set preview
```

Also see the [LF_BAT_OPTS](#lf_bat_opts) section for configuring
text file preview settings.

## lfmount

Mount and open archives. Archives are mounted read-only because
archivemount's read-write mounting sucks.

If the `pass` environment variable is set, lfmount asks for a password.

Put this in your lfrc:

```
map [key] &lfmount $f
```

## lfselect

Reads file names from stdin and selects them in lf.
If only one file is given, it only puts the cursor over the file.

Examples:

```
sxiv -ao | lfselect
printf '%s\n' *.jpg | lfselect
```

## Environment Variables

## LF_BAT_OPTS

lfpreviewer uses [bat](https://github.com/sharkdp/bat)
for text file previews, called with the options `-pf --number`, which enables
colorization and line numbers.

However, you can specify your own bat options by setting the `LF_BAT_OPTS`
environment variable.

Example for `~/.bash_profile` or `~/.zprofile`:

```
export BAT_THEME='gruvbox-dark'
export LF_BAT_OPTS='-f'
```

## Dependencies

The only hard dependency of lfutils is lf.
All the dependencies listed here are technically optional,
and installing each of them will add a certain feature
to lfutils.

However, I recommend installing all of them,
as they're pretty small, and you'll probably need most of them,
if not all.

Archlinux users can install all of these dependencies
(except for binutils and transmission-cli)
by installing the AUR package `lfutils-meta`:

```
paru -S lfutils-meta
```

- **archivemount**: Mounting and opening archives via lfmount
- **[ueberzug](https://github.com/seebye/ueberzug)**: Image previews
- **[chafa](https://github.com/hpjansson/chafa)**: Previewing images outside of a graphical environment
- **[ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer)**: Previewing video thumbnails
- **[bat](https://github.com/sharkdp/bat)**: Previewing plain text and code
- **atool**: Previewing archive contents (install [atool-git](https://github.com/solsticedhiver/atool)([aur](https://aur.archlinux.org/packages/atool-git)) for zstd support)
- **mediainfo**: Previewing info about music/media files
- **odt2txt**: Previewing OpenDocument files
- **poppler**: Previewing PDF files
- **gnome-epub-thumbnailer**: Previewing epub ebook covers
- **docx2txt**: Previewing docx files
- **catdoc**: Previewing Microsoft document files
- **imagemagick**: Previewing svg files
- **libcdio**: Previewing ISO files
- **binutils**: Previewing object files
- **transmission-cli**: Previewing .torrent files
