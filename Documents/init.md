## Using it on a fresh Ubuntu install

```bash
# 1. Bare minimum to bootstrap (transcrypt needs openssl + bsdmainutils)
sudo apt update && sudo apt install -y yadm git curl gpg openssl bsdmainutils xxd

# 2. Install transcrypt before cloning, so the smudge filter exists when
#    yadm checks out encrypted files.
sudo curl -fsSL https://raw.githubusercontent.com/elasticdog/transcrypt/main/transcrypt \
  -o /usr/local/bin/transcrypt && sudo chmod +x /usr/local/bin/transcrypt

# 3. Clone WITHOUT bootstrap first — encrypted files will land as ciphertext
#    until transcrypt is initialized with the password.
yadm clone --no-bootstrap https://github.com/Sergter/yadm-repo.git

# 4. Initialize transcrypt in the yadm repo with the SAME password used
#    on the original machine. This force-checks-out and decrypts the files.
yadm enter transcrypt -c aes-256-cbc -p '<your-strong-password>' -y
#  ...or import from a gpg-encrypted credentials dump:
#  yadm enter transcrypt --import-gpg ~/transcrypt-creds.gpg

# 5. Now run the bootstrap.
yadm bootstrap

# 6. Re-source shell so nvm/path are picked up
exec bash -l