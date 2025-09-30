#!/bin/bash

# Installation universelle de Simple Git depuis GitHub
# Usage: curl -sSL https://raw.githubusercontent.com/VOTRE-USERNAME/simple-git/main/install-remote.sh | bash

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Installation de Simple Git${NC}"
echo -e "${BLUE}==============================${NC}"
echo ""

# ⚠️ MODIFIEZ CETTE LIGNE avec votre nom d'utilisateur GitHub
REPO_URL="https://github.com/Tokomichel/simple-git"
INSTALL_DIR="$HOME/.simple-git"
BRANCH="main"  # ou "master" selon votre branche principale

# Vérifier si git est installé
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git n'est pas installé.${NC}"
    echo -e "${YELLOW}Installez Git puis réessayez.${NC}"
    exit 1
fi

# Vérifier si déjà installé
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠️  Simple Git est déjà installé.${NC}"
    echo -e "${YELLOW}♻️  Mise à jour en cours...${NC}"
    rm -rf "$INSTALL_DIR"
fi

# Cloner le repository
echo -e "${YELLOW}📦 Téléchargement depuis GitHub...${NC}"
if git clone --quiet --depth 1 --branch "$BRANCH" "$REPO_URL" "$INSTALL_DIR"; then
    echo -e "${GREEN}✅ Téléchargement terminé${NC}"
else
    echo -e "${RED}❌ Erreur lors du téléchargement${NC}"
    echo -e "${YELLOW}Vérifiez l'URL du repository et votre connexion internet${NC}"
    exit 1
fi

# Rendre les scripts exécutables
echo -e "${YELLOW}🔧 Configuration des permissions...${NC}"
find "$INSTALL_DIR" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

# Détecter le shell
SHELL_NAME=$(basename "$SHELL" 2>/dev/null || echo "bash")
case "$SHELL_NAME" in
    "bash") SHELL_RC="$HOME/.bashrc" ;;
    "zsh") SHELL_RC="$HOME/.zshrc" ;;
    *) SHELL_RC="$HOME/.bashrc" ;;
esac

# Ligne à ajouter (adaptée au nom du fichier principal de votre projet)
SOURCE_LINE="source \"$INSTALL_DIR/simple-git.sh\""

# Supprimer l'ancienne configuration si elle existe
echo -e "${YELLOW}⚙️  Configuration de $(basename $SHELL_RC)...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' '/# Simple Git/d' "$SHELL_RC" 2>/dev/null || true
    sed -i '' '/simple-git.sh/d' "$SHELL_RC" 2>/dev/null || true
else
    # Linux et Git Bash
    sed -i '/# Simple Git/d' "$SHELL_RC" 2>/dev/null || true
    sed -i '/simple-git.sh/d' "$SHELL_RC" 2>/dev/null || true
fi

# Ajouter la nouvelle configuration
echo "" >> "$SHELL_RC"
echo "# Simple Git" >> "$SHELL_RC"
echo "$SOURCE_LINE" >> "$SHELL_RC"

echo ""
echo -e "${GREEN}✅ Installation terminée avec succès !${NC}"
echo ""
echo -e "${BLUE}📖 Pour utiliser immédiatement :${NC}"
echo -e "   ${YELLOW}source $SHELL_RC${NC}"
echo ""
echo -e "${BLUE}🎯 Ou redémarrez votre terminal${NC}"
echo ""
echo -e "${BLUE}📚 Commandes disponibles :${NC}"
echo -e "   ${YELLOW}sg${NC}                   - Afficher l'aide complète"
echo -e "   ${YELLOW}gcm 'message'${NC}        - git commit -m 'message'"
echo -e "   ${YELLOW}gca 'message'${NC}        - git add . && git commit -m"
echo -e "   ${YELLOW}gp${NC}                   - git push"
echo -e "   ${YELLOW}gl${NC}                   - git pull"
echo -e "   ${YELLOW}gs${NC}                   - git status"
echo ""
echo -e "${GREEN}🎉 Profitez de Simple Git !${NC}"
echo ""

# Proposer de charger immédiatement (optionnel)
if [ -t 0 ]; then
    read -p "Voulez-vous charger Simple Git maintenant ? (Y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        if source "$INSTALL_DIR/simple-git.sh" 2>/dev/null; then
            echo -e "${GREEN}🔄 Simple Git chargé ! Tapez 'msl' pour commencer.${NC}"
        # Charger aussi les raccourcis git si le fichier existe
        fi
    fi
fi

source "$INSTALL_DIR/simple-git.sh"
# source "$INSTALL_DIR/lib/git-shortcuts.sh"
# curl -sSL https://raw.githubusercontent.com/Tokomichel/simple-git/main/install-remote.sh