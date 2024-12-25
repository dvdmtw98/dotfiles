# Start SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Add all private keys in ~/.ssh with corresponding public keys
for key in ~/.ssh/*; do
    # Skip public keys, directories, and non-private key files
    if [[ -f "$key" && "$key" != *.pub ]]; then
        # Check if the MIME type matches a private key (application/x-pem-file)
        if [[ $(file -b --mime "$key") == "application/x-pem-file"* ]]; then
            # Check if a corresponding public key exists
            pub_key="${key}.pub"
            if [[ -f "$pub_key" ]]; then
                ssh-add "$key" >/dev/null 2>&1
            fi
        fi
    fi
done

# Source .zshrc for interactive settings
[ -f ~/.zshrc ] && source ~/.zshrc
