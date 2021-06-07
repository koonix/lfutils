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

## installation

there is an AUR package for archlinux users:

```
paru -S lfutils-git
```

or you can put these scripts somewhere in your $PATH.

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
