#!/bin/bash

# Script d'installation pour Simple git

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Répertoires
INSTALL_DIR="$HOME/.simple-git"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🚀 Installation de Simple Git${NC}"
echo -e "${BLUE}====================================${NC}"

# Créer le répertoire d'installation
echo -e "${YELLOW}📁 Création du répertoire d'installation...${NC}"
mkdir -p "$INSTALL_DIR"

# Copier les fichiers
echo -e "${YELLOW}📋 Copie des fichiers...${NC}"
cp -r "$CURRENT_DIR/"* "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/simple-git.sh"
chmod +x "$INSTALL_DIR/uninstall.sh"

# Détecter le shell utilisé
SHELL_NAME=$(basename "$SHELL")
case "$SHELL_NAME" in
    "bash")
        SHELL_RC="$HOME/.bashrc"
        ;;
    "zsh")
        SHELL_RC="$HOME/.zshrc"
        ;;
    *)
        SHELL_RC="$HOME/.bashrc"
        echo -e "${YELLOW}⚠️  Shell non détecté, utilisation de .bashrc par défaut${NC}"
        ;;
esac

# Ligne à ajouter au fichier de configuration du shell
SOURCE_LINE="source \"$INSTALL_DIR/simple-git.sh\""

# Vérifier si déjà installé
if grep -q "simple-git.sh" "$SHELL_RC" 2>/dev/null; then
    echo -e "${YELLOW}⚠️  Simple Git semble déjà installé dans $SHELL_RC${NC}"
    read -p "Voulez-vous réinstaller ? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Installation annulée${NC}"
        exit 0
    fi
    
    # Supprimer l'ancienne ligne
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' '/simple-git.sh/d' "$SHELL_RC"
    else
        # Linux
        sed -i '/simple-git.sh/d' "$SHELL_RC"
    fi
fi

# Ajouter la ligne de source au fichier de configuration
echo -e "${YELLOW}⚙️  Configuration de $SHELL_RC...${NC}"
echo "" >> "$SHELL_RC"
echo "# Simple git" >> "$SHELL_RC"
echo "$SOURCE_LINE" >> "$SHELL_RC"

# Créer un lien symbolique dans /usr/local/bin si possible
if [ -w "/usr/local/bin" ]; then
    echo -e "${YELLOW}🔗 Création du lien symbolique global...${NC}"
    ln -sf "$INSTALL_DIR/simple-git.sh" "/usr/local/bin/sg"
fi

echo -e "${GREEN}✅ Installation terminée !${NC}"
echo ""
echo -e "${BLUE}📖 Pour utiliser la bibliothèque :${NC}"
echo -e "   1. Redémarrez votre terminal ou tapez : ${YELLOW}source $SHELL_RC${NC}"
echo -e "   2. Tapez ${YELLOW}msl${NC} pour voir toutes les commandes disponibles"
echo ""
echo -e "${BLUE}🎯 Exemples d'utilisation :${NC}"
echo -e "   ${YELLOW}gcm 'Mon message de commit'${NC}"
echo -e "   ${YELLOW}gca 'Add new feature'${NC}"
echo -e "   ${YELLOW}mkcd mon-nouveau-projet${NC}"
echo -e "   ${YELLOW}weather Paris${NC}"
echo ""
echo -e "${GREEN}🎉 Profitez de votre nouvelle bibliothèque shell !${NC}"

# Proposer de charger immédiatement
read -p "Voulez-vous charger la bibliothèque maintenant ? (Y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    source "$INSTALL_DIR/simple-git.sh"
    source "$INSTALL_DIR/lib/git-shortcuts.sh"
    echo  "$INSTALL_DIR/simple-git.sh"
    echo "$INSTALL_DIR/lib/git-shortcuts.sh"
    echo -e "${GREEN}🔄 Bibliothèque chargée ! Tapez 'msl' pour voir l'aide.${NC}"
fi