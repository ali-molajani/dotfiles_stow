# dotfiles_stow
New version of my dotfiles focused on productivity using GNU stow
I added two bash scrips to automate the stow process 
# how it works 
You should clone the repo in `home` directory of the user to use the below command:
```bash
stow nvim
```
if you clone that somewhere else you should tell stow where is home (or the entry point for your config files) as shown in below command:
```bash
stow nvim -t ~
```
