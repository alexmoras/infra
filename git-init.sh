#!/bin/bash
# sets up a pre-commit hook to ensure that vault.yaml is encrypted
#
# credit goes to nick busey from homelabos for this neat little trick
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355

if [ -d .git/ ]; then
rm .git/hooks/pre-commit
cat <<EOT >> .git/hooks/pre-commit
if ( git show :vars/vault.yml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "🔒 Vault Encrypted. Safe to commit. 🔒"
else
echo "⚠️ Vault not encrypted! Run 'ansible-vault encrypt vars/vault.yml' and try again. ⚠️"
exit 1
fi
EOT

fi

chmod +x .git/hooks/pre-commit