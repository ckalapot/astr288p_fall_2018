# Lectures 4: More on Scripting
---
Create this lecture's folder
```
  $ cd ~/ASTR288p/lectures
  $ mkdir lecture04
  $ cd lecture04
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

- **A few more about variables**

*variables*:  $0 .. $9, $# and $@
```
#!/bin/bash
echo "I was called with $# parameters"
echo "My name is $0"
echo "My first parameter is $1"
echo "My second parameter is $2"
echo "All parameters are $@"
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
