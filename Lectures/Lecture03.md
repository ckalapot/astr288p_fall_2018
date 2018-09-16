# Lecture 3:  More on UNIX, Scripting
---
Create this lecture's folder
```
  $ cd ~/ASTR288p/lectures
  $ mkdir lecture03
  $ cd lecture03
```
## More UNIX commands/tools

### Links  (hard/soft)
```
	$ link / ln    # LiNk between files (hard/soft link)
```
```
  $ echo "This is a file." > file1.txt
  $ link file1.txt file2.txt           # hard link
  $ cat file1.txt
  $ cat file2.txt
  $ echo "New line for file1.txt" >> file1.txt
  $ cat file1.txt
  $ cat file2.txt
  $ echo "New line for file2.txt" >> file2.txt
  $ cat file1.txt
  $ cat file2.txt
  $ rm file1.txt
  $ ls
  $ cat file2.txt
  $ ln file1.txt file2.txt         # (like link, hard link)
  $ ln -s file1.txt file2.txt      # (symbolic/soft link)
```

Check what happens when you delete file1.txt

### Secure Copy (scp)
For windows you can download **pscp** or you can use bash (win10) or cygwin

```
  $ scp kkalap@ursa.astro.umd.edu:~/ASTR288p/lectures/lecture02 ./     # remote to local
  $ scp ./file3.txt kkalap@ursa.astro.umd.edu:~/ASTR288p/lectures/lecture02/     # local to remote
  $ scp somestudent@ursa.astro.umd.edu:~/ASTR288p/lectures/lecture02/file3.txt kkalap@ursa.astro.umd.edu:~/ASTR288p/lectures/lecture02/    

  $ scp -C ...        # for compression
```

### Wildcards
  **\***, **?**

  check also *.{dat,txt}

### Finding files:

1) **locate**    (but:   "**sudo updatedb**" - normally not enabled on Mac)
```
    $ locate -i file1.txt
```

2)  **find**       (arguably one of the more complex UNIX commands)
```  
    $ cd ~/ASTR288p
    $ find . -name "file*"    # finds the file name pattern (without the path)
    $ cat > file0.txt
    $ cat > file2.txt
    $ find . -name "file*"
    $ find . -name file*      # without the quotes, the shell expands the command; erratic behavior

    $ echo find . -name file*
    $ echo find . -name "file*"

    $ find . -path "*02/file*"    # finds the path name pattern (without the path)
    $ find . -type f              # finds only files
    $ find . -type d              # finds only directories
```

  Using **-iname**, **-ipath** makes the pattern case insensitive

### Tarballs

A **tarball** is a type of file archive. It is a convenient method of transporting multiple files and folders around.

### Creating an archive

To create an archive:
```
   $ mkdir for_tar
   $ cp ./*.* ./for_tar/
   $ tar -cvf tar01.tar ./for_tar/    # create
   $ tar -xvf tar01.tar               # extract
   $ tar -tf tar01.tar                # see the contents
   $ tar -czvf tar02.tar.gz ./for_tar/   # create a tar gzip file
   $ gzip file1.txt                      # compress the file adding the extension gz
   $ gzip -c file2.txt > file2.txt.gz    # compress the file (both files exist)
   $ gunzip file1.txt.gz                 # uncompress the file
   $ tar -tzf tar01.tar.gz               # see the contents
```
```
    c : create
    x : eXtract
    v : Verbose
    f : Filename specifier
    z : gzip compression
    t : see contents

    see also bzip2/bunzip2 tar -cj...
```

### A few more
```
  $ passwd
  $ who
  $ date
  $ cd ~/ASTR288p/
  $ du        # show the disk usage
  $ du -c *
  $ du -ch *
  $ du -sh ./lectures/
  $ du -h ./lectures/
  $ sort              # sort lines alphabetically or numerically (-n: sort numerically, -r: reverse order)
  $ sort < list1.txt              # take the input from a file
  $ sort < list1.txt > list2.txt  # take the input from a file and send the output to a file
```

#### Pipeline ( | )
```
  $ ls -lt | tac      # Pipes '|' send the output of one command as input of another command
  $ who | sort
  $ ls -l | grep "file*.*" | sort
  $ ls | wc -l
  $ find ~/anaconda3/ | less

  $ find . -path "*/lecture0?/*.dat" | sort > filelist.txt
  $ tar -cvf tar_of_dats.tar -T filelist.txt
```
---

## Scripting
(see also this [tutorial](https://www.shellscript.sh/))

Scripting in UNIX is nothing more than a few shell commands in a text file, which you can execute directly using the shell (the interpreter):

```
$ echo "echo hello world" > hello.sh
$ bash hello.sh
$ ls -l hello

$ chmod +x hello.sh
$ ls -l hello  
$ hello.sh
$ echo $PATH
$ ./hello.sh
```
```
$ echo '#!/bin/bash' > hello-bash.sh          # This indicates what kind of interpreter will be used (i.e. the shell under which the file will be executed)
$ echo 'echo Hello World' >> hello-bash.sh
$ chmod 755 hello-bash.sh
$ ./hello-bash.sh
```

### Permissions:

In the last section, we did something that made the script **executable**:

```
$ chmod +x hello.sh
```

This means that we added the permission to execute the code from a shell. Other permissions are read and write, which are permissions to read and write to files.

You can see what permissions a file has by doing
```
$ ls -l
```
and looking at some example output:
```
drwx------ 2 kkalapot s0845     262144 Jan 12  2017 .
drwx------ 8 kkalapot s0845     172032 Jan 12  2017 ..
-rw------- 1 kkalapot s0845    1549146 Jan 12  2017 S4_a45_s300.o1074040
-rw-r--r-- 1 kkalapot s0845      44100 Jan 12  2017 colmns.dat
-rw-r--r-- 1 kkalapot s0845          0 Jan 12  2017 individual_trajectories_3D_SNKRN.dat
-rw-r--r-- 1 kkalapot s0845         13 Jan 12  2017 norb.dat
-rw-r--r-- 1 kkalapot s0845         13 Jan 12  2017 norbeff.dat
-rw-r--r-- 1 kkalapot s0845         13 Jan 12  2017 nprob.dat
-rw------- 1 kkalapot s0845        403 Jan 12  2017 orbits_pulses.inc
-rwx------ 1 kkalapot s0845        412 Jan 12  2017 pbs_bro.bat
-rwx------ 1 kkalapot s0845        416 Jan 12  2017 pbs_ele.bat
-rwx------ 1 kkalapot s0845        412 Jan 12  2017 pbs_has.bat
-rwx------ 1 kkalapot s0845        412 Jan 12  2017 pbs_ivy.bat
-rw-r--r-- 1 kkalapot s0845  137290000 Jan 12  2017 sky_map_rt_B1_SNKRN_fact.dat
-rw-r--r-- 1 kkalapot s0845 1285170678 Jan 12  2017 trajectories_3D_E0_SNKRN_fact.dat
-rw-r--r-- 1 kkalapot s0845  831185232 Jan 12  2017 trajectories_3D_E0_SNKRN_fact_PC.dat
-rwx------ 1 kkalapot s0845     930024 Jan 12  2017 trajectories_approx_AE.exe
-rw------- 1 kkalapot s0845      50449 Jan 12  2017 trajectories_approx_AE.f
```
The columns are:
  - Permissions
  - Number of links to the file / directory
  - Name of owner (**user**)
  - The **group** the files belong to. Yours will be "student" or something similar. There are multiple groups that correspond to different types of user.
   - File size.
   - Date the file was last modified.
   - The filename

Permissions can be broken down into three sections: user, group, other.
The first character indicates if it's a directory (**d**), the next three characters correspond to the reqd, write, and execute perimissions for the user, and similarly for the group, and then other.

### Changing permissions
For example:
```
    $ chmod u=rwx,g=rx,o=r file5.txt
    $ chmod a+x : add execute access for all users
    $ chmod g-x : remove write access for group memebers
    $ chmod o-wx : remove write and execute access for non-user, non-group memebers
    $ chmod 754 file5.txt
```
- 4 stands for "read",
- 2 stands for "write",
- 1 stands for "execute", and
- 0 stands for "no permission."
```
$ setfacl -m u:kkalap:rwx file
$ getfacl file
$ setfacl -m g:spring:-rwx file
$ getfacl file
$ setfacl -m u:kkalap:rwx file
$ getfacl file
$ setfacl -x u:kkalap file
$ getfacl file
$ setfacl -R -m u:kkalap folder
```


---

**Comments**
```
#!/bin/bash
# This is a comment!
echo Hello World        # This is a comment, too!
```
**Variables**
```
#!/bin/bash
MESSAGE="Hello World"
echo $MESSAGE
```
```
#!/bin/bash
echo What is your name?
read NAME
echo "Hello $NAME"
```
See the difference
```
echo "Hello Constantinos"
echo "Hello "Constantinos""
echo "Hello \"Constantinos\""
echo 'Hello "Constantinos"'
```
similar for (\\,\$)

**Variable scope**
```
#!/bin/bash
echo "MYVAR is: $MYVAR"
MYVAR="I have changed"
echo "MYVAR is: $MYVAR"
```
```
$ MYVAR="Outside declared"
$ ./runme.sh
```
```
$ export MYVAR
$ ./runme.sh
$ echo $MYVAR
```
```
$ MYVAR="hello"
$ echo $MYVAR
$ source ./myvar2.sh        # . can be used instead source
$ echo $MYVAR
```
```
#!/bin/bash
echo "Type your name?"
read NAME
echo "Hello $NAME"
touch ${NAME}_file      # not touch $NAME_file
```
**Control flows**

- *for*
```
#!/bin/bash
for i in 1 2 3 4 5
do
  echo "Iteration $i"
done
```

  see how '*' is interpreted
```
#!/bin/bash
for i in See the files * I am finished
do
  echo "Variable i has the value: $i"
done
```
```
#!/bin/bash
for i in 1 2 3
do
  touch 0${i}.dat
done
```
- *while*
```
#!/bin/bash
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ]
do
  echo "Please type something in (bye to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```
```
#!/bin/bash
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ] && [ "$INPUT_STRING" != "quit" ]
do
  echo "Please type something in (bye to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```
  NOT: !

  AND: &&

  OR: ||

  mind the gap after "[" and before "]"

- *if*
```
#!/bin/bash
echo "Give me an integer number"
read X
if  [ "$X" -lt "0" ]; then
 echo "X is negative"
elif  [ "$X" -gt "0" ]; then
   echo "X is positive"
else
   echo "X is zero"
fi
```
check ';'

- **Bash comparison operators**

| String | Numeric | True if |
|:--------:|:---------:|:---------:|
| x=y    | x -eq y  | x is equal to y|
| x!=y    | x -ne y  | x is not equal to y|
| x<y    | x -lt y  | x is less than y|
| -    | x -le y  | x is less than or equal to y|
| x>y    | x -gt y  | x is greater than y|
| -    | x -ge y  | x is greater than or equal to y|
| -n x    | -  | x is not null|
| -z x    | -  | x is null|

- **Bash file evaluation operators**

| Operator | True if |
|:--------:|:---------:|
| -d *file*    | *file* exists and is a directory|
| -e *file*    | *file* exists |
| -f *file*    | *file* exists and is a regular file|
| -r *file*    | you have read permission on *file*|
| -s *file*    | *file* exists and is not empty|
| -w *file*    | you have write permission on *file*|
| *file1* -nt *file2*    | *file1* is newer than *file2*|
| *file1* -ot *file2*    | *file1* is older than *file2*|
```
#!/bin/bash
echo "Give me a filename"
read fnm
if  [ -f "$fnm" ]; then
 echo "The file already exists"
else
  touch $fnm
   echo "$fnm has been created"
fi
```
```
#!/bin/bash
echo "Write something"
read str
if  [ ! -z "$str ]; then
 echo "You wrote: '$str'"
else
  echo "You wrote nothing"
fi
```


## Environment variables

Any command typed in the terminal will find this from an executable file along the
directories in the $PATH environment variable:

```
   $ echo $PATH
   $ export PATH="~/ASTR288p/lectures/lecture03:$PATH"
   or
   $ export PATH=$PATH:"~/ASTR288p/lectures/lecture03"
```
Edit **.bashrc**
```
# added by kkalap (lecture03)
export PATH=$PATH:"~/ASTR288p/lectures/lecture03"
export EDITOR="/usr/bin/emacs"
alias edvi=vi
```
---
## Git: sharing your codes: a first encounter

We will come back to **git**, but the following commands will download the "astr288p" repository of codes and documentation that are helpful for this class.
```
  $ git clone https://github.com/ckalapot/astr288p_fall_2018
  $ ls
  $ cd astr288p_fall_2018
  $ ls -la
```

```
  $ git add lectures/Lecture03.md
  $ git commit -m "message"
  $ git push
```

Now, if we do
```
  $ git pull
```

Simple begginer's guide
(https://www.youtube.com/watch?v=0fKg7e37bQE)

````
$ less lectures/Lecture01.md
````
In *Markdown* language. Markdown is a lightweight markup language with plain text formatting syntax. It is designed so that it can be converted to HTML and many other formats.
Take a look at [this](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).
