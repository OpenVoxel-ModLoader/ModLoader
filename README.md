# OpenVoxel ModLoader

A mod system for [OpenVoxel](https://open-voxel.net) that never modifies the game: the client
loader is a Java agent injected into the **official launcher**, and the server side is a plugin
for the **official dedicated server**. Current release: **ModLoader 1.0.0 for game 0.0.8**
(client version `0.0.8-Debug`).

| Repository | What | Release file |
|------------|------|--------------|
| [ModLoader-Client](https://github.com/OpenVoxel-ModLoader/ModLoader-Client) | Client loader: Minecraft-style UI, Creative/Survival, crafting, chests, skins, chat, controls, resource packs, languages, mod API. | `ModLoader-v1.0.0-vgame-0.0.8-client.jar` |
| [ModLoader-Server](https://github.com/OpenVoxel-ModLoader/ModLoader-Server) | Server core plugin + start scripts with an interactive console. | `ModLoader-v1.0.0-vgame-0.0.8-server.jar` |
| [ModLoader-ModsExamples](https://github.com/OpenVoxel-ModLoader/ModLoader-ModsExamples) | Example client mods (hello, HUD clock, block counter). | `hello-mod.jar`, `hud-clock.jar`, `block-counter.jar` |
| [ModLoader-Server-Example](https://github.com/OpenVoxel-ModLoader/ModLoader-Server-Example) | Example server plugin (Hunger Games mini-game). | `HungerGames.jar` |
| [openvoxel-modloader.github.io](https://github.com/OpenVoxel-ModLoader/openvoxel-modloader.github.io) | Docs & tutorials site (EN/ES): https://openvoxel-modloader.github.io/ | — |

## Quick start

**Client**

1. Download the client jar from the ModLoader-Client releases into `ModLoader-Client/dist/`
   (or clone and build with `./gradlew jar`).
2. Put the `ModLoader-Client` folder next to `OpenVoxelLauncher.exe` (or set `OPENVOXEL_HOME`).
3. Run `launch.bat` / `launch.ps1` (Windows) or `./launch.sh` (Linux); in the launcher select
   version **0.0.8-Debug** and press PLAY.
4. Drop mods into `ModLoader-Client/instance/mods`. Settings: `instance/config/user-config.properties`.

**Server**

1. Download the official `openvoxel-server-0.0.8-SNAPSHOT.jar` to `ModLoader-Server/server/openvoxel-server.jar`.
2. Download the server core jar into `ModLoader-Server/dist/`, put plugins into `mods/`.
3. Run `start.bat` / `start.ps1` / `./start.sh`; the window is a console (`help`, `say`, `stop`).

`scripts/setup.bat` / `scripts/setup.sh` clone every repository side by side.

## How it works

- `ModLoader-Client`: `Agent` registers an ASM `Transformer` that renames selected engine
  methods to `name$orig` in memory and routes them through `Hooks`; UI, survival, items,
  crafting, tiles (crafting table / chest / bed), skins, chat, keybinds, lighting and audio hang
  off the per-frame hook. Mods implement `ClientMod` and get a `ModContext`.
- `ModLoader-Server`: plugin `ModLoader` (console on stdin, utility commands, colors). Other
  plugins use the official API and are deployed from `mods/` to `plugins/` by the start scripts.
- Game/server JARs are compile-time only (`OPENVOXEL_GAME_JAR`, `OPENVOXEL_SERVER_JAR`) and are
  fetched from the official manifest in CI; they are never redistributed.

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) and [CHANGELOG.md](CHANGELOG.md).
