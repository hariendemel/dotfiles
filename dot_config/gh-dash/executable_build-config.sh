#!/bin/bash
# Merges every YAML file in config.d/ (sorted by filename) into config.yml,
# the file gh-dash actually reads. Re-run this before launching gh-dash
# whenever a file under config.d/ changes.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

yq eval-all '. as $item ireduce ({}; . * $item)' config.d/*.yml > config.yml
