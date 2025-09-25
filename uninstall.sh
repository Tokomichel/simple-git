#!/bin/bash

# Script de désinstallation pour Simple git

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

INSTALL_DIR="$HOME/.simple-git"

echo -e "${YELLOW}🗑️  Désinstallation de Simple git${NC}"
echo -e "${YELLOW}======================================${NC}"

# Détecter le shell
SHELL_NAME=$(basename "$SHELL")
case "$SHELL_NAME" in
    "bash") SHELL_RC="$HOME/.bashrc" ;;
    "zsh") SHELL_RC="$HOME/.zshrc" ;;
    *) SHELL_RC="$HOME/.bashrc" ;;
esac

# Supprimer les lignes du fichier de configuration
if [ -f "$SHELL_RC" ]; then
    echo -e "${YELLOW}🧹 Nettoyage de $SHELL_RC...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' '/# Simple git/d' "$SHELL_RC"
        sed -i '' '/simple-git.sh/d' "$SHELL_RC"
    else
        sed -i '/# Simple git/d' "$SHELL_RC"
        sed -i '/simple-git.sh/d' "$SHELL_RC"
    fi
fi

# Supprimer le lien symbolique
if [ -L "/usr/local/bin/msl" ]; then
    echo -e "${YELLOW}🔗 Suppression du lien symbolique...${NC}"
    rm -f "/usr/local/bin/msl"
fi

# Supprimer le répertoire d'installation
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}📁 Suppression du répertoire d'installation...${NC}"
    rm -rf "$INSTALL_DIR"
fi

echo -e "${GREEN}✅ Désinstallation terminée !${NC}"
echo -e "${YELLOW}⚠️  Redémarrez votre terminal pour que les changements prennent effet.${NC}"