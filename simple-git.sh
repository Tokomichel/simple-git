#!/bin/bash

# My Shell Library - Collection de raccourcis shell utiles
# Version: 1.0.0

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Charger tous les modules de la bibliothèque
# source "$SCRIPT_DIR/lib/git-shortcuts.sh"

# source "$SCRIPT_DIR/lib/docker-shortcuts.sh"
# source "$SCRIPT_DIR/lib/utils.sh"

# Fonction d'aide générale
msl_help() {
    echo "My Shell Library v1.0.0"
    echo "======================="
    echo ""
    echo "Commandes Git disponibles:"
    echo "  gcm 'message'     - git commit -m 'message'"
    echo "  gca 'message'     - git add . && git commit -m 'message'"
    echo "  gp                - git push"
    echo "  gl                - git pull"
    echo "  gs                - git status"
    echo "  gb                - git branch"
    echo "  gco <branch>      - git checkout <branch>"
    echo "  gcb <branch>      - git checkout -b <branch>"
    echo "  gd                - git diff"
    echo "  glog              - git log --oneline -10"
    echo "  gsco <branch>     - git stash && git checkout <branch>"
    echo "  gspco <branch>    - git stash pop && git checkout <branch>"
}

# Alias pour l'aide
alias msl=msl_help