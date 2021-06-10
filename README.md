# lfutils

useful scripts for the lf file manager.

* [installation](#installation)
* [lfrun, lflast](#lfrun-lflast)
* [lfpreviewer, lfcleaner](#lfpreviewer-lfcleaner)
* [lfmount](#lfmount)
* [lfsxiv](#lfsxiv)
* [lftpw](#lftpw)
* [lfselect](#lfselect)
* [lfreload](#lfreload)
* [dependencies](#dependencies)

## installation

there is an AUR package for archlinux users:

```
paru -S lfutils-git
```

otherwise:

```
git clone https://github.com/soystemd/lfutils.git
cd lfutils
sudo make install
```

please see the [dependencies](#dependencies) section before using lfutils.

## lfrun, lflast

`lfrun` is a wrapper script for running lf, which
initializes lflast and ueberzug for image previews.

`lflast` prints the last directory the last instance of lf was in.

put this in your .bashrc or .zshrc:

```
lf() {
    lfrun "$@"
    cd "$(lflast "$@")"
}
```

## lfpreviewer, lfcleaner

file previewer and cleaner scripts.

add these lines to your lfrc:

```
set previewer lfpreviewer
set cleaner lfcleaner
```

## lfmount

allows you to open archive files' contents in lf, using `archivemount`.

put this in your lfrc:

```
cmd armount        &lfmount $id $f
cmd armount-passwd &lfmount -p $id $f
cmd arunmount      &lfmount -u $id

map [key] armount
...
```

## lfsxiv

- open all the images in directory in sxiv
- select the files that are selected in sxiv, in lf as well
(selection happens upon sxiv's exit).

use lfsxiv in your `open` command for opening images,
or use it as a standalone command/binding:

```
cmd image &lfsxiv $id $f
map [key] image
```

## lftpw

toggle lf's preview pane while readjusting ratios.
makes lf's preview toggling look like ranger's.

lftpw requires three arguments, and an optional fourth:

1. lf's id
2. pane ratios when preview is disabled
3. pane ratios when preview is enabled
4. [optional] lf's initial preview status [possible values: on (default), off]

add to your lfrc:

```
set ratios 1:3:2
cmd toggle-preview &lftpw $id 1:5 1:3:2
map [key] toggle-preview
```

change the ratios to your liking.

I recommend using lftpw with previews and panes
initially disabled:

```
set nopreview
set ratios 1
cmd toggle-preview &lftpw $id 1 1:2 off
map [key] toggle-preview
```

## lfselect

select multiple files remotely in lf. this util is used
by lfsxiv to select sxiv's selected images in lf.

if only one file is given, lfselect will just put
the cursor over it instead of selecting it.

you can supply list of files from stdin:

```
printf '%s\n' *.jpg | lfselect <lf's id>
```

or you can give it as the second argument:

```
lfselect <lf's id> "$(printf '%s\n' *.jpg)"
```

## lfreload

reload files and directories. just sends the load/reload command to lf.
useful for using inside push commands, because it's shorter than
lf -remote "send $id reload".

```
lfreload <lf's id>
  or
lfreload -f <lf's id>
```

if you give it the -f option, it sends `reload`. otherwise sends `load`.
read lf's manual for info on their difference.

example in lfrc:

```
cmd trash push &trash-put<space>$fx;lfreload<space>$id
map D trash
```

with this command, you will have to press enter before the
command is run, which acts as a kind of confirmation.

## dependencies

the only hard dependency of lfutils is lf.
all the dependencies listed here are technically optional,
and installing each of them will add a certain feature
to lfutils. however, I recommend installing all of them,
as they're pretty small, and you'll probably need most of them,
if not all.

archlinux users can install all of these dependencies
(except for sxiv, binutils and transmission-cli)
by installing the AUR package `lfutils-meta`:

```
paru -S lfutils-meta
```

- **archivemount**: mounting and opening archives via lfmount
- **[ueberzug](https://github.com/seebye/ueberzug)**: image previews
- **[chafa](https://github.com/hpjansson/chafa)**: previewing images outside of a graphical environment
- **[ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer)**: previewing video thumbnails
- **[bat](https://github.com/sharkdp/bat)**: previewing plain text and code
- **[sxiv](https://github.com/muennich/sxiv)**: sxiv integration using lfsxiv
- **atool**: previewing archive contents (install [atool-git](https://github.com/solsticedhiver/atool)([aur](https://aur.archlinux.org/packages/atool-git)) for zstd support)
- **mediainfo**: previewing info about music/media files
- **odt2txt**: previewing OpenDocument files
- **poppler**: previewing PDF files
- **gnome-epub-thumbnailer**: previewing epub ebook covers
- **docx2txt**: previewing docx files
- **catdoc**: previewing Microsoft document files
- **imagemagick**: previewing svg files
- **libcdio**: previewing ISO files
- **binutils**: previewing object files
- **transmission-cli**: previewing .torrent files
