# Architecture

`ModLoader-Client` is the Java agent (`com.happyuky7.openvoxelmoding.loader`): `Agent`
registers `Transformer`, which renames selected engine methods to `name$orig` in memory and
routes them through `Hooks`. Everything else (UI, survival, items, crafting, tiles, skins,
chat, keybinds, lighting, audio) hangs off the per-frame hook installed by `BuiltinUI`.
Mods are JARs in `instance/mods` implementing `ClientMod`; `ModContext` is their API.

`ModLoader-Server` is a plugin for the official dedicated server (`ModLoaderServer`,
plugin.yml name `ModLoader`): console on stdin, utility commands, colors. Example plugins
compile into `mods/` and are deployed to `plugins/` by the start scripts.

`openvoxel-modloader.github.io` is a static Vite/React site (markdown bundled at build time, hash router) for
GitHub Pages. VoxelNames (profiles/skins site with its Fastify API) is kept out of the org for now.

The original files under `Game`, `ServerTest` and `OpenVoxelLauncher.exe` are inputs only;
their checksums must remain unchanged.
