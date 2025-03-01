# launch-mac

Scripts and instructions for launching items on window session startup. Mac version. 

##
To clone the repo 

```
git clone git@github.com:mjbmon/mps-buildtools.git
```

Notes and scripts for launching things on window session start-up.


We need to be able to launch things automatically, when the user
first starts the initial session. To do this in a more or less
portable way we will assume that there is a script located in a
known location and then put launch items into that script. There
may be several possible places. For now we assume that the script
is a shell script called `launch_init.sh` and that it is located
in `~/.local/.initial` which will NOT EVER be in the executable
path, so there is very little chance of executing it by accident.
Plus, it will not be executable. The script filename and the script location
are arbitrary and for security reasons it might be a good idea to
change either or both.

To launch on Mac OS we create an applescript that runs the `launch_init.sh`
script. Then we turn the applescript into an app, then finally install the app
in `Settings->General->Login Items & Extensions`

## Creating  the `launch_init.sh` script.

The `launch_init.sh` script is a normal shell script created with
a text editor.
```text
#!/bin/bash
echo "Running the launch_init.sh script"
echo "Hello, world"
pwd
echo ${PATH}
sleep 10
```
This file is intended to be modified by the user for whatever needs
to be launched at the beginning of the session. 

## Testing the `launch_init.sh` script.

Execute the following command
```
 (source ./launch_init.sh )
```
We put this in parentheses to protect the current shell and we
use source because the script is not executable.

The output should look something like this
```
Running the launch_init.sh script
Hello, world
/Users/mark/Github/launch-mac
/Users/mark/.cargo/bin:/opt/homebrew/bin:/opt/homebrew ...
```

## Installing the `launch_init.sh` script.

We install the script as follows
```text
 mkdir -p ~/.local/.initial
 cp launch_init.sh ~/.local/.initial
```
This creates the target directory `~/.local/.initial` and copies the
script into it. At this point there is nothing to tell the system
how or when to run this script.

## Building the applescript app.

The applescript is created in a file `launch.scpt` with any text editor
and contains the following
```text
do shell script "~/.local/.initial/launch_init.sh > ~/launch_init.log"
```

Open this file with the following command
```text
 open launch.scpt
```
and this will start the `Script Editor` application. Choose
`File->Export` and under `File Format` choose `Application`, then `Save`.
This will create an application `launch.app`.

## Testing the applescript (initial test).
To test the new app
```text
 open launch.app
 cat ~/launch_init.log
```
and the output should be
```text
Running the launch.sh script
Hello, world
```

## Installing the applescript app.

We can now install the app to be run whenever the user logs into a
window session. This will not happen if the user accesses the account
in some other way, such as ssh.

To do this, go to  `Settings->General->Login Items & Extensions`.
In the section `Open at Login` click on `+` to add the application.
This pops up a folder window that lets you search for and select
the app, in the directory where the app was just created.

## Testing the launch_init script.

To test the installation we just log out and log back into the session.
Then cat the `launch_init.log` in the home directory. Compare with the
result from running the script directly.
```
Running the launch_init.sh script
Hello, world
/
/usr/bin:/bin:/usr/sbin:/sbin
```
This is **very obviously** not what we want!





## Modify the launch_init script.

The launch_init script does not do anything useful so far. Here
is a modified script that sets working directory, the path, and then launches the terminal
```
#!/bin/bash
cd ~
export PATH=${PATH}

echo "Running the launch_init.sh script"
echo "Hello, world"
pwd
echo ${PATH}
sleep 10

```

To install this script we merely copy it to `~/.local/.initial/launch_init.sh`
and log out of and back into the session. The browser should open
automatically.

## Alternative approach.

Rather than heavily modify the `launch_init.sh` script a better approach is
to have that script call another script to launch the browser. This way
we can easily add various things to be launched. We don't want this to get






## Questions

  - What about security?

  - Note that the launch_init.sh script does not have to be
    executable, in fact it should NOT be.

  - Note that the normal `.bashrc` etc are NOT run. HOWEVER,
    when wezterm is launched and the user creates new tabs or
    windows then `.bashrc` IS run.

  - We can edit and update the launch_init.sh script at any time.
    No effect will be seen until we log out and back in.

  - What about the applescript and app? Do I need to keep them around?
    Try it.

## TODO

 - Create a github repo called launch_mac and put all this stuff in
   it, with a README.md file (and a zip file to download?)

 - Similarly, launch_linux?  (maybe more than one).

 - Now need to add code to launch a specific app or apps. For
   example launch_diary.sh

 - Work on linux. Different distros might be quite different.

 - Look up issues with desktops (spaces).

 - Move app to different desktop. On mac just drag in the toolbar,
    eventually it goes to the next desktop.

Or grab in toolbar and
    use control-2 to move to desktop 2. **That does not work.**

