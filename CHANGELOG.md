# Change log

## 2026-10-12 — OpenVoxel ModLoader 1.0.0 (repo split)

- Project split into `repos/` for the GitHub org OpenVoxel-ModLoader: `modloader-client`
  (agent, examples, instance, scripts), `modloader-server` (core plugin + HungerGames
  example + start scripts), `docs` (static Pages site), `voxelnames` (API + site).
- Brand "Voxelite" → "OpenVoxel ModLoader"; jars `ModLoader-v1.0.0-vgame-0.8.0-client.jar`
  and `ModLoader-v1.0.0-vgame-0.8.0-server.jar` in each repo's `dist/`.
- Scripts for Windows and Linux: `launch.bat/.ps1/.sh` (client; tells the user to pick
  0.0.8-Debug in EN/ES), `start.bat/.ps1/.sh` (server, interactive console), `build.bat/.sh`
  + Gradle wrapper 9.1 with `OPENVOXEL_GAME_JAR` / `OPENVOXEL_SERVER_JAR`.
- GitHub Actions: build + release-on-tag for client/server, Pages deploy for docs.
- Docs site made static (markdown bundled, hash router, `public/mods.json` catalogue).

## 2026-10-12 — Voxelite Loader 0.8.0 (fifth pass)

- Loader moved to the standard layout `src/main/java/com/happyuky7/openvoxelmoding/loader`
  (package = folder) and `src/main/resources`; Gradle build (`build.gradle.kts`, wrapper
  9.1) producing the same fat agent jar as `build.bat`. Old jars archived.
- Crafting (`Recipes`, `Containers`): 2x2 grid in the survival inventory, 3x3 crafting
  table; shaped recipes at any offset/mirrored (sticks, torches, slabs, stairs, doors,
  glass, tools/swords/armor per tier, golden apple, bread, crafting table, chest, bed).
- Materials: ores drop coal/ingots/gems; stick, redstone, lapis; leaves may drop apples.
- Tiles (`Tiles`): crafting table, chest (27 slots, persisted per world seed) and bed
  (sleep at night → morning + spawn point) placed on real engine blocks and drawn over
  them; right click opens them, breaking drops the tile (and chest contents).
- `GameEventManager.fire` hook routes right clicks on tiles; `applyEdit` registers tiles.

## 2026-10-12 — Voxelite Loader 0.8.0 (fourth pass)

- Rebindable controls (`Keybinds`): Minecraft defaults (Shift sneak, Ctrl sprint, Q drop);
  the engine's own `GLFW.glfwGetKey` calls in InputHandler are redirected through
  `Hooks.glfwGetKey` so remaps apply everywhere. Controls screen: click a key, press the
  new one, Reset. Saved as `keys.*` in user-config.properties.
- Drop items: Q throws one (Ctrl+Q the stack) along the view direction with a pickup
  delay; in the inventory Q drops the hovered/carried stack, clicking outside the window
  or closing it with something carried throws it too.
- Skins: the launcher-cached skin is applied immediately on world enter (server skin/model
  replaces it when it arrives); with a custom server model the skin texture is still used
  for previews and the first-person arm.
- Web: skin proxy cache 60 s with `?refresh`, profile page bypasses caches.

## 2026-10-12 — Voxelite Loader 0.8.0 (third pass)

- Drops are world entities (`Drops`): broken blocks pop out, fall, spin, magnet to the
  player and stack into the inventory; pickup popup + sound.
- Eating: hold right click 1.6 s with crunch sounds and a first-person animation; food is
  consumed from the stack.
- Sounds (`SoundSystem`): named events (step/break/place/pickup/eat/pop/hurt/click) play
  WAVs from `client/instance/sounds/` (numbered variants) with synthesized fallbacks.
- Music (`Music`): shuffled `client/instance/music/*.wav`, Options → Music, `/music`.
- Lighting (`Lighting`): chunk shader replaced after the engine compiles its own — distance
  fog blended with the sky colour, softer light curve, stronger AO, cool night / warm
  torch tint; Options → Fog.
- Flight: horizontal boost to ~11 m/s × fly speed, vertical speed softened.
- Skins: the local uuid is always treated as local even when the server lists it as a
  remote player; no server skin → launcher cache / default is applied.
- Menus: closing a loader screen no longer unpauses mouse look while another menu (pause,
  inventory) is still open.
- Server: `HungerGames` plugin (`projects/hungergames`, `/hg start|stop|status`).
- Web workspace switched to pnpm (`pnpm-workspace.yaml`, `allowBuilds: esbuild`).

## 2026-10-12 — Voxelite Loader 0.8.0 (second pass)

- Loader renamed **Voxelite Loader**; JAR `OpenVoxelModLoader/Voxelite-0.8.0.jar`.
- Items: swords, pickaxes/shovels/axes, armor (4 tiers) and food with generated sprites;
  hotbar/inventory now hold `Items.Stack` (block or item, with count).
- Survival: hunger + regeneration + starvation, eating (right click), armor slots and armor
  bar, hearts/hunger/armor HUD above the hotbar, fall damage reduced by armor.
- Mining: hold left click; break time per block and tool (pickaxe/shovel/axe, tier speed),
  blocks that need a tool drop nothing without it; drops stack into the inventory; placing
  consumes blocks (`VoxelEngine.applyEdit` hook).
- Creative inventory: tabs Blocks / Tools / Combat / Food, pagination (wheel), armor slots,
  shift-click quick move, tooltips with stats.
- Third person (F5) shows the held block/item in the right hand; cape and elytra wings
  rendered locally (`config/cape.png`, vanilla cape layout, default generated).
- Sneak (Ctrl) edge guard for bridging (`PhysicsEngine.moveHorizontal` hook).
- Chat: formatting codes shown literally in the input field, colored only when printed;
  Tab completion (commands + players), Up/Down sent history, wheel/PageUp/PageDown scroll
  with scrollable history view; `/help` lists client commands then forwards to the server.
- Languages: `Lang` with bundled en_us/es_es, mod `assets/<id>/lang/*.json`, instance
  `lang/*.json`; Options → Language; all loader UI strings translated.
- Resource packs: `client/instance/resourcepacks/<name>/...` overrides textures
  (`Texture.decode` hook), Options → Textures switches live.
- Skins: previews and the first-person arm use the applied skin; offline fallback to the
  launcher's cached skin in `Game/skins`.
- ESC always closes only the current loader screen.
- Mod API: `onFrame`, `ModContext.chat/registerCommand/translate/getInstanceDirectory`;
  example mods in `examples/` (hello-mod, hud-clock, block-counter).
- Server: HappyModdingTest 1.2.0 adds an interactive console (stdin), `/help` with colors,
  `/say`, `/list`, `/kick`, `/stop`; `launch-server.ps1` now shows output live and logs it.
- Web: `web/` monorepo — Fastify API (profiles, skin/model proxy, mods catalogue with
  uploads/downloads, markdown docs per language) + VoxelNames (React/Vite, 2D skin
  renderer, account linking) + Voxelite Hub (mods, tutorials, docs, upload), i18n en/es.

## 2026-10-12 — v8 (Minecraft-style client)

- Loader wraps game methods in memory with ASM (`Transformer` + `Hooks`); the JAR on disk
  is untouched.
- Minecraft-style menus/options/mods/controls/skin/account screens.
- Creative / Survival modes, first-person hand, F3 debug screen, Steve/Alex two-layer skins
  with upload, chat colors and client commands, session fix, MC-style hotbar/inventory.

## 2026-10-12

- Added Java-agent mod loading and isolated ModsSystem layout, client menus, inventory,
  F3 overlay, sound, server wrapper and HappyModdingTest plugin.
