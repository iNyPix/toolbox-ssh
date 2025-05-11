# toolbox-ssh

I created this repo to contain scripts and configuration files to configure easily and quickly my toolbox and vscodium. Now, I can connect to my dev toolbox via VSCodium without the "Dev Container" Microsoft extension.

## Initialize ssh-server in the toolbox

This script will try to install `openssh-server` package via `dnf`, modify the `sshd_config`(ssh-server), `.ssh/config`("client") and start the server.

Authorize execution

```bash
chmod +x init.sh
```

Execute `init.sh` script with 2 arguments (PORT, TOOLBOX-NAME).  
- PORT -> the ssh's port.
- TOOLBOX-NAME -> name to identify the ssh connection.  (will be "toolbox-**TOOLBOX-NAME**")

```bash
./init.sh 2242 dev
```

## Connexion to the toolbox

Open VSCodium, VSCode… And connect via ssh to the hostname `toolbox-TOOLBOX-NAME`.

## Use toolbox's terminal

If you want to use the toolbox's terminal instead of the local terminal, or you have installed the flatpak version of VSCodium, for example (you will see an error if you try to open the terminal).  

Open the remote settings JSON via `F1` and `Preferences: Open Remote Settings (JSON)(SSH: toolbox-TOOLBOX-NAME) ` and add these lines :

```json
{
    "terminal.integrated.defaultProfile.linux": "bash",
    "terminal.integrated.profiles.linux": {
        "bash": {
            "path": "/usr/bin/bash",
            "args": []
        }
    }
}
```

## Next ?

Automatically start the toolbox and ssh-server before trying to connect via ssh
