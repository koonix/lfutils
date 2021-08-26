# lfutils

Useful scripts for the lf file manager.

* [Installation](#installation)
* [Utilities](#utilities)
  * [lfrun, lflast](#lfrun-lflast)
  * [lfpreviewer, lfcleaner](#lfpreviewer-lfcleaner)
  * [lfmount](#lfmount)
  * [lftpw](#lftpw)
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

## lfrun, lflast

`lfrun` is a wrapper script for running lf, which
initializes lflast and ueberzug for image previews.

`lflast` prints the last directory the last instance lf was in.

Put this in your .bashrc or .zshrc:

```
lf() {
    lfrun "$@"
    cd "$(lflast "$@")"
}
```

## lfpreviewer, lfcleaner

File previewer and cleaner scripts, for previewing files/media.

Add these lines to your lfrc:

```
set previewer lfpreviewer
set cleaner lfcleaner
set ratios 1:1
set preview
```

Also see the [LF_BAT_OPTS](#lf_bat_opts) section for configuring
text file preview settings.

## lfmount

Allows you to open archive files' contents in lf, using `archivemount` (archive
mounting is read-only as archivemount's read-write mounting sucks).

Put this in your lfrc:

```
cmd armount        &lfmount $f
cmd armount-passwd &lfmount -p $f
cmd arunmount      &lfmount -u

map [key] armount
map [key] armount-passwd
map [key] arunmount
```

`armount` mounts the archive and jumps to the mountpoint.

Archivemount can't tell wether an archive is password-protected;
Therefore the `armount` command returns an error when trying to mount
such archives. So you can use `armount-passwd` which will prompt
you for a password.

While inside the mounted archive, use `arunmount` to unmount the archive
and jump back to where you were before mouting.

## lftpw

Toggle lf's preview pane while readjusting ratios.
Makes lf's preview toggling look like ranger's.

lftpw requires three arguments, and an optional fourth:

1. lf's id
2. pane ratios when preview is disabled
3. pane ratios when preview is enabled
4. [optional] lf's initial preview status [possible values: on (default), off]

Add to your lfrc:

```
set ratios 1:3:2
cmd toggle-preview &lftpw 1:5 1:3:2
map [key] toggle-preview
```

Change the ratios to your liking.

I recommend using lftpw with previews and panes
initially disabled:

```
set nopreview
set ratios 1
cmd toggle-preview &lftpw 1 1:2 off
map [key] toggle-preview
```

## lfselect

Select multiple files remotely in lf.

If only one file is given, lfselect will just put
the cursor over it instead of selecting it.

You can supply list of files from stdin:

```
printf '%s\n' *.jpg | lfselect <lf's id>
```

Or you can give it as the second argument:

```
lfselect <lf's id> "$(printf '%s\n' *.jpg)"
```

## Environment Variables

## LF_BAT_OPTS

lfpreviewer uses [bat](https://github.com/sharkdp/bat)
for text file previews, called with the options `-pf --number`, which enables
colorization and line numbers.

But if you would like to pass different options to bat,
you can put them in the `LF_BAT_OPTS` environment variable.

Example line to put in `~/.bash_profile` or `~/.zprofile`:

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
