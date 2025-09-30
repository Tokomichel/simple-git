# SIMPLE-GIT

Simplify your git command
## Installation remote (recommandée)
Pour installer sans avoir à cloner le projet, il fous suffit d'utiliser la commande curl comme ceci:
```bash
curl curl -sSL https://raw.githubusercontent.com/Tokomichel/simple-git/main/install-remote.sh | bash
```
et en suite depuis n'importe quel terminal (linux tels que le git bash de windows)

```bash
source ~/.simple-git/lib/git-shortcuts.sh
```
## Installation via clonage du projet
Pour commencer clone le repo dans n'importe quel dossier de votre pc
```bash
git clone https://github.com/Tokomichel/simple-git
```

Puis lancez le script d'installation
```bash
./install.sh
```

Pendant l'installation vous pourrez choisir d'installer la bibliothèque maintenant ou plus tard.

Pour finaliser l'installation vous devrez entrer la commande suivante dans votre terminal
```bash
source ~/.simple-git/lib/git-shortcuts.sh
```

## Utilisation

Ici figurent juste quelques exemples d'utilisation de la bibliothèque.

Pour commencer il faut entrer la commande suivante dans votre terminal pour voir l'ensemble des commandes disponibles.
```bash
msl
```
* Pour faire un commit
```bash
gcm "message"
```
* Pour faire un git add commit et push
```bash
gca "message" 
```
* Pour faire un git add commit et push
```bash
gcp "message"
```

Voilà quelques exemples d'utilisation de la bibliothèque.
Je suis ouvert à toutes suggestions pour améliorer la bibliothèque.


