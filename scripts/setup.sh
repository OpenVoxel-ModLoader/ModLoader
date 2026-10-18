#!/usr/bin/env bash
# Clones every OpenVoxel-ModLoader repository next to this one.
set -euo pipefail
cd "$(dirname "$0")/../.."
for r in ModLoader-Client ModLoader-Server ModLoader-ModsExamples ModLoader-Server-Example openvoxel-modloader.github.io; do
  [ -d "$r" ] && { echo "$r already exists"; continue; }
  git clone "https://github.com/OpenVoxel-ModLoader/$r.git"
done
echo "Done. Client: ModLoader-Client/launch.sh  Server: ModLoader-Server/start.sh"
