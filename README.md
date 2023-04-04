# Ansible Infrastructure As Code

### Configuration Variables
Generic config variables - things which are required for the app / container to run - are stored in the relevant `group_vars` file. Anything that contains application specific config values, such as domain names, is stored in the vault at `vars/vault.yml`.