function dotfiles --description "Bootstrap/update my dotfiles via remote script"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Fei-Wang/dotfiles/main/bootstrap.sh)"
end
