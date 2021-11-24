An example for [tfmigrate](https://github.com/minamijoyo/tfmigrate) with [Atlantis](https://github.com/runatlantis/atlantis)

This repository contains all configurations for running atlantis in local with docker-compose, but most of them are actually not related in tfmigrate. To use tfmigrate with Atlantis:

1. Install tfmigrate. ([atlantis/Dockerfile](atlantis/Dockerfile))
2. Add a custom workflow for tfmigrate in server side repo config. ([atlantis/repos.yaml](atlantis/repos.yaml))
3. Generate an atlantis.yaml for tfmigrate dynamically in pre workflow hooks. ([atlantis/hooks/pre_workflow_hooks.sh](atlantis/hooks/pre_workflow_hooks.sh))

See [atlantis/](atlantis/) directory for more detail.
