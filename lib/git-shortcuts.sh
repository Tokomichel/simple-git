#!/bin/bash
echo -e "${GREEN} git-shortcuts.sh Lancement ${NC}"
# Raccourcis Git

# git commit -m "message"
gcm() {
    if [ -z "$1" ]; then
        echo "Usage: gcm 'message'"
        echo "Exemple: gcm 'Fix bug in user authentication'"
        return 1
    fi
    git commit -m "$1"
}

# git add . && git commit -m "message"
gca() {
    if [ -z "$1" ]; then
        echo "Usage: gca 'message'"
        echo "Exemple: gca 'Add new feature'"
        return 1
    fi
    git add . && git commit -m "$1"
}

# git add . && git commit -m "message" && git   push
gcp() {
    if [ -z "$1" ]; then
        echo "Usage: gcp 'message'"
        echo "Exemple: gcp 'Add new feature'"
        return 1
    fi
    git add . && git commit -m "$1" && git push
}

# git push
gp() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [ -z "$branch" ]; then
        echo "❌ Pas dans un répertoire Git"
        return 1
    fi
    
    echo "🚀 Push vers la branche '$branch'..."
    git push origin "$branch"
}

# git pull
gl() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [ -z "$branch" ]; then
        echo "❌ Pas dans un répertoire Git"
        return 1
    fi
    
    echo "⬇️  Pull depuis la branche '$branch'..."
    git pull origin "$branch"
}

# git status avec couleurs
gs() {
    git status --short --branch
}

# git branch
gb() {
    git branch -a
}

# git checkout
gco() {
    if [ -z "$1" ]; then
        echo "Usage: gco <branch_name>"
        echo "Branches disponibles:"
        git branch
        return 1
    fi
    git checkout "$1"
}

# git stash et checkout
gsco()
{
    if [ -z "$1" ]; then
        echo "Usage: gsco <branch_name>"
        return 1
    fi
    git stash && git checkout "$1"
}

# git checkout -b (nouvelle branche)
gcb() {
    if [ -z "$1" ]; then
        echo "Usage: gcb <new_branch_name>"
        return 1
    fi
    git checkout -b "$1"
}

#git stash pop et checkout
gspco()
{
    if [ -z "$1" ]; then
        echo "Usage: gspco <branch_name>"
        return 1
    fi
    git stash pop && git checkout "$1"
}

# git diff
gd() {
    git diff --color=always "$@"
}

# git log formaté
glog() {
    local count=${1:-10}
    git log --oneline --graph --decorate -n "$count"
}

# git add spécifique
ga() {
    if [ -z "$1" ]; then
        echo "Usage: ga <file_or_pattern>"
        echo "Exemple: ga src/"
        return 1
    fi
    git add "$@"
}

# git reset HEAD (unstage)
gun() {
    if [ -z "$1" ]; then
        git reset HEAD
    else
        git reset HEAD "$@"
    fi
}

# git stash avec message
gst() {
    if [ -z "$1" ]; then
        git stash
    else
        git stash push -m "$1"
    fi
}

# git stash pop
gsp() {
    git stash pop
}

# Fonction pour initialiser un repo git avec premier commit
ginit() {
    local message=${1:-"Initial commit"}
    
    if [ -d ".git" ]; then
        echo "❌ Déjà dans un répertoire Git"
        return 1
    fi
    
    echo "🎯 Initialisation du répertoire Git..."
    git init
    
    # Créer un .gitignore basique si il n'existe pas
    if [ ! -f ".gitignore" ]; then
        echo "📝 Création d'un .gitignore basique..."
        cat > .gitignore << EOF
# Logs
*.log

# Dependencies
node_modules/
__pycache__/
*.pyc

# Environment variables
.env
.env.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
EOF
    fi
    
    git add .
    git commit -m "$message"
    echo "✅ Répertoire Git initialisé avec le commit: '$message'"
}

# Fonction pour cloner et cd dans le répertoire
gcl() {
    if [ -z "$1" ]; then
        echo "Usage: gcl <repository_url> [directory_name]"
        return 1
    fi
    
    local repo_url="$1"
    local dir_name="$2"
    
    if [ -z "$dir_name" ]; then
        # Extraire le nom du répertoire depuis l'URL
        dir_name=$(basename "$repo_url" .git)
    fi
    
    echo "📦 Clonage de $repo_url..."
    git clone "$repo_url" "$dir_name" && cd "$dir_name"
}

alias gcm=gcm
alias gca=gca
alias gp=gp
alias gl=gl
alias gs=gs
alias gb=gb
alias gco=gco