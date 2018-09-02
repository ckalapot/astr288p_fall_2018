# Lecture 1:  Introduction to UNIX


## UNIX is a family of multi-tasking, multi-user computer operating systems (OS).
***
## Command Line Interface (CLI) vs. Graphical User Interface (GUI)
- A **CLI** is a console or text based representation where users type the commands to operate the software or devices.
- A **GUI** is a graphical representation where users interact with software or devices through graphical icons.

- **GUI**: Ease
- **CLI**: Advanced control, Speed, Efficient Scripting


  - GUI Communication Protocols: Mac (aqua) and Linux (X11 -> Wayland)
  - GUI: Linux has many many window managers*
     (e.g. twm, fvwm, enlightenment, gnome, cde, kde, unity, plasma)
  - CLI: one and only one (though minor differences do remain between Mac and Linux)

   *window manager: system software that controls the placement and appearance of windows within a windowing system in GUI

The notes below loosely follow the tutorials in [http://www.ee.surrey.ac.uk/Teaching/Unix/](http://www.ee.surrey.ac.uk/Teaching/Unix/) (see also
  [https://www.tutorialspoint.com/unix/unix-what-is-shell.htm](https://www.tutorialspoint.com/unix/unix-what-is-shell.htm))
you are recommended to walk yourself through these.
***

## Shells/Terminals
A **Shell** provides an interface between the user and Unix (OS). It is a command-line interpreter, which gathers input from you and executes programs based on that input. Finally, it displays program's output.

Shells can be **GUI** or **CLI** shells and act as an interface to the operating system's different services.

 They are named shells because they are the outermost layers around the OS kernels.

A **Terminal** is a hardware peripheral that interfaces with a human, it is composed of output to the user and input from the user, in other words of a screen and a keyboard. The **shell** runs in the **terminal** reading the commands you type and executes them.

What the GUI shows you is a virtual terminal (terminal emulator).
- xterm                  (probably the oldest terminal in X11)
- gnome-terminal         (Gnome terminal)
- xfce4-terminal         (XFCE4 terminal)
- konsole                (KDE terminal)
- emacs "M-x shell"      (yes, you can run a terminal inside of emacs, great for logging)


### What shells can we use?

There are many CLI shells available. Some examples:

  - bash  (sh: bourne shell)
  - tcsh  (csh: C-shell)
  - ksh   (korn shell)
  - xonsh (pythonesque shell, cf. ipython)

We will be using **bash**.

   How do you know which shell you are running?

   As is often in UNIX, several answers possible, that all need human parsing
   ````
   echo $SHELL
   grep $USER  /etc/passwd
   ps
   ````
   What are the allowed shells on your unix system?

   Use **cat** to view whats in **/etc/shells** or **chsh --list-shells**
   ````
   cat /etc/shells
   chsh --list-shells
   ````

   If a shell is not listed in **/etc/shells**, can I still use it?

   Yes, simply run it from the current shell (a shell within a shell; see A1)

### Changing your default shell

In this class, we will use **bash**, although in the future you may decide to use another default shell.
To change your default shell, type
```
chsh -s /bin/bash or
chsh --shell /bin/bash
```

For this to take effect, you need to open a new terminal!

### Shell options (as defined in /etc/passwd, see /etc/shells)
/etc/passwd contains essential information relevant for user login.
An example line:
```
kkalapot:x:58132:79485:Konstantinos kalapotharakos,,301-286-7323:/home5/kkalapot:/bin/bash
```
There's more information here than we need for the scope of this course, but the important fields are
  - kkalapot : User name.
  - x is the password (it always comes up as 'x'; the actual encrypted password is stored elsewhere)
  - 11822: User ID (UID)
  - 40845: Group ID (GID); we'll come back to this one later when we discuss file permissions
  - Konstantinos kalapotharakos,,301-286-7323: This is a comment field.
  - /home5/kkalapot: Path to a user's home directory when they log in.
  - /bin/bash: This means that on login shell /bin/bash is used. This can also be a command, as opposed to a shell.

  The file '/etc/passwd' changes when you define a new default shell
  ```
  grep kkalapot /etc/passwd
  chsh --shell /bin/bash kkalapot
  grep kkalapot /etc/passwd
  ```

CAVEAT: MacOS does not seem to use /etc/passwd (see http://docstore.mik.ua/orelly/unix3/mac/ch03_08.htm)


### Persistent shells with session management (cf. VNC)
If you don't need a full graphical interface, and still want to login to server (e.g. ursa) and maintain your session, use any of the following programs

  - screen        (often comes with UNIX)
  - tmux          (most of the screen capabilities and some more -> more powerful)

**screen** utility provides a way to run a command on a Linux system, detach from it, and then reattach later. This is particularly handy if you have a long-running process that you want to keep running even after you log out and still have the ability to reattach to it later and/or from another location. If is also useful if you have an unstable ssh login connection and allows you to reconnect to the same session if you get disconnected.

#### screen utility
* Run
```
$ screen
```
Once screen session started, you can run any command and keep the session running by detaching the session.

* Detaching
```
press "ctrl+a" then "ctrl+d"
```
Now, if you logout, your session will be left alive.
* Showing the available screen sessions
```
$ screen -list  #(or screen -ls)
There is a screen on:
        90067.pts-108.pfe22     (Detached)
1 Socket in /var/run/uscreens/S-kkalapot.
```
* Reattaching detached screen session
```
$ screen -r     #if only one screen is opened
$ screen -r 90067.pts-108.pfe22
$ exit          #to terminate
```


## bash shell

**Interactive**: The commands are run with user-interaction from keyboard. E.g. the shell can prompt the user to enter input.

**Non-interactive**: The shell probably runs from an automated process so it can't assume if can request input or that someone will see the output. Maybe it is best to write output to a log-file.

**Login**: The shell runs as part of the login of the user to the system. Typically used to do any configuration that a user needs/wants to establish his work-environment.

**Non-login**: Any other shell run by the user after logging on, or which is run by any automated process which is not coupled to a logged-in user.

*Interactive*  and *login* shell are controlled by one or more startup ("rc:resource configuration") files:

   * interactive, login shell:
      * /etc/profile
      * ~/.bash_profile
      * ~/.bash_login
      * ~/.profile
   * interactive, non-login shell:
     * /etc/bash.bashrc
     * ~/.bashrc\
   * non-interactive shell (usually running a shell script):
     * it loads the variable BASH_ENV and uses the expanded value as the name of a file to read and execute

Some of your personal files may already be present when your account was activated. Use the **ls -a** command to see these hidden (files starting with a dot) files.

With the **ls -a** command you will also see **.** and **..**    what are those?

The current directory **.** and the parent directory **..**

### Linux and Mac philosophy on interactive and login shells different?

This is often source of confusion and discussed online
(e.g. see http://unix.stackexchange.com/questions/119627/why-are-interactive-shells-on-osx-login-shells-by-default)

Here's a summary for Linux and Mac, and when they read the startup files (WARNING: they are not the same!)

```
  linux>  ssh localhost                                 # login
  	  bash: .bash_profile                           
	    tcsh: .cshrc .login                           # in that order

  linux>  xterm (or open a gnome-terminal)              # interactive
  	  bash: .bashrc
	    tcsh: .cshrc

  mac> ssh localhost                                    # login (enable in System Preferences -> Sharing -> Remote Login)
       -> .bash_profile

  mac> Terminal  (CMD-N)                                # login
       -> .bash_profile                                 # if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
       bash                                             # interactive
       -> .bashrc
```

If you use the **csh** variety, the **.login** and **.cshrc** files control which one is read for what type of session.

## Files and Directories

```
  ls                  LiSt files
  pwd                 Print Working Directory
  whoami              Isn't that obvious?
```

## How to get more help for a given COMMAND:
(this obviously means you know the name of the COMMAND)

```
  COMMAND --help
  COMMAND --version
  man COMMAND
  info COMMAND

  which COMMAND
  whatis COMMAND
  apropos COMMAND
  <google>
```  

  man pages have sections (the -s option) to narrow down search

## Files:  the "ls" command

```
  ls -l   # l for long
  ls -al  # all long
  ls -lt  # long, sort by modification time
  ls -ltr # long, sort by modification time, reverse order
  ls -lt | tac
  ls --full-time #what does this one do?
  ls -s   # sort by file size
  ls -R   # list subdirectories recursively
  ls -X   # sort alphabetically by entry extension
  ls -lh  # print sizes in human-readable format (e.g., 1K, 5M, 2G)
  ls -l --block-size=M  # round file sizes up to the nearest MB
```
  What is the '|' symbol doing?

  What is the 'tac' command?

  What are '.' and '..' ?


## Directories:

```
  pwd
  mkdir ASTR288P
  cd ASTR288P            (try typing just 'A' or "AS" and then <TAB>-complete)
  pwd
```
