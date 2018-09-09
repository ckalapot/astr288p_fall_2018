# Lecture 2: More on UNIX
***

## Creating Files:

Although it does not matter where you do this, let us keep class files in **~/ASTR288p**:
$ is the prompt
```
  $ cd ~
  $ mkdir ASTR288p
  $ cd ASTR288p
  $ mkdir lectures
  $ cd lectures
  $ mkdir lecture02
  $ cd lecture02
```
The prompt is defined in the PS1 environment variable
```
echo $PS1
export PS1='\u@\linux$ '
export PS1='\u@\linux$ '
export PS1='\u@\h\$ '
export PS1='\u@\H\$ '
```
see [how to customize your bash prompt](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html)


  1) **touch**   (Zero Length file)
```
    $ touch Data0.txt
    $ mkdir data0.txt       #(testing case sensitivity)
```
  Notice on a Mac this last **mkdir** may have failed. Can you see why?

  2) **echo**
```
    $ echo Hello1   >  Data1.txt        #(sends output to file)
    $ echo Hello2   >  Data1.txt        #(overwrites)
    $ echo Hello3  >>  Data1.txt        #(appends)
```

  3) **cat**

  Display the contents of this file using
```
    $ cat Data1.txt
    $ cat > Data2.txt  (creates file, C-d exit)
    $ cat file1 >> file2 (append the contents of file1 at the end of file2)
    $ echo 'text to append' >> file2
```
  How do you display what is in the file **Data2.txt**

  4) **Editors**

The default editor is in the environment variable **$EDITOR**
```
    $ echo $EDITOR
    $ emacs     #(C-x C-c) exit without saving
                #(C-x C-s) save and exit
    $ vi        #':q!' exit without saving
                #':wq' or 'ZZ' save and exit
                # commands/modes: i, a, dd, x, X
    $ pico      #(^X to exit. You will be asked whether to save or not.)
    $ gedit     #(^Q or ^W) to exit, or click on File->Quit
```
  **vi**: [vi cheet sheet](http://www.atmos.albany.edu/daes/atmclasses/atm350/vi_cheat_sheet.pdf) or [vi basics](https://www.ccsf.edu/Pub/Fac/vi.html)

  Many editors keep a backup copy, often with a tilde (~) appended to the filename


## Viewing Files

Many ways to view a file on the terminal:
```
     $ cat       # the whole thing to the terminal
     $ more      # paging section by section ('q' to get out, '?' to get help)
     $ less      # "less is a better more" (/FOO to search for the word FOO)
     $ tac       # (reverses the lines)

     $ head      # the first portion
     $ tail      # the last portion
     $ head -50 art_data    # it shows the first 50 lines
```
## Searching file info/content
```
     $ wc                           # WordCount (# of lines, # of words, and # of characters)
     $ sum                          # check sum (see also cksum, md5sum)
     $ grep                         # show lines that match some pattern (cf. google and googling)
     $ grep This ./file4.txt
     $ grep "This is" ./file4.txt   # mind the gap...
     grep -r "string" ./            # reads all files under each directory, recursively
     grep -w "man" ./               # lines containing matches that form whole words
     grep -c "man" ./               # counts matching lines for each input file
```
grep has many many options

## Other File Operations
```
     $ cp           # CoPy files
     $ mv           # MoVe files (also renaming if it's not going to another directory)
     $ rm           # ReMove files (directories would need the -r flag, but see also rmdir)
```
```
  $ cp [opt] data2.txt data2new.txt   # opt: e.g. -a, -R, -r, -f, -b, -u
```
  mv has similar options
