# Ansible Infrastructure As Code

This repo is the core of my network. It is deployed with Ansible which provisions all the services and applications running inside the lab. Everything in this repository is the "live" version of my lab and as soon as a change it made, it is published here.

## How does it work?

_I'm not going to try and explain how Ansible works - that's far too much for one readme and in all honesty, I don't know Ansible well enough to advise other people._

The following are the key points which explain how my specific deployment works. It's based off the work done by [Alex from the Self Hosted podcast](https://github.com/ironicbadger/infra):

- The `ansible-playbook` command is run using the `main.yml` playbook. In this file, all the host groups have roles specified. The playbook is executed and each role is run on the hosts.

  When only a single host is modified, and to save running the entire playbook, I run the above command but add `--limit host`, replacing "host" with the specific host group. To run on only Immich, I would run `ansible-playbook main.yml --limit immich` or to run on everything other than Nextcloud I would run `ansible-playbook main.yml --limit '!nextcloud'`.

- Host groups are defined in the `hosts.ini` file. This allows me to group specific hosts together based on common roles.

- The `group_vars` folder contains all the variables common between host groups. This is mainly used to specify packages to install or provide shared configurations.

- All custom roles are specified in the `roles` folder. Many of them run docker to deploy applications in a manner which allows easy configuration through files.

  Docker Compose files are specified in the `defaults` folder of each role. The specific configuration variables are listed at the top of the file and can be overridden in either `group_vars` or the `vault`.

- The `vault` file is stored in the `vars` folder. It uses the `ansible-vault` module to allow me to store every configuration value in the repository by encrypting them. You can have a look at [this file](https://github.com/alexmoras/infra/blob/main/vars/vault.example.yml) to see what my vault looks like (minus all my secrets).

  The `git-init.sh` file is run when first pulling the repository. It prevents me accidentally committing an unencrypted version of the vault. _99% less leaked secrets!_

## Can I use this to deploy my own lab?

Yes! But also, no. Everything is setup for how I run my lab. I assign specific IP addresses based on how I segment my network with VLANs, etc. Networks aren't a "one size fits all" thing.

So, the best approach is to build your own `infra` repo which is **influenced** by this one, rather than an exact copy. But if you want to try and deploy an exact copy of this repo, you're more than welcome to give it a go! I'd love to know how you get on.