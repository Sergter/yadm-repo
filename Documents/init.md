## Using it on a fresh Ubuntu install

```bash
# 1. Bare minimum to bootstrap (transcrypt needs openssl + bsdmainutils)
sudo apt update && sudo apt install -y yadm git

# 3. Clone WITHOUT bootstrap first — encrypted files will land as ciphertext
#    until transcrypt is initialized with the password.
yadm clone --no-bootstrap https://github.com/Sergter/yadm-repo.git

# 5. Now run the bootstrap.
yadm bootstrap

# 6. Re-source shell so nvm/path are picked up
exec bash -l