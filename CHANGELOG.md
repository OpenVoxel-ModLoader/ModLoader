# Change log

## 2026-10-18 — OpenVoxel ModLoader 1.1.0-pre3 (client + server, pre-release)

- Native blocks: `ctx.nativeBlock(id)...register()` adds real `BlockType` constants (BlockType `<clinit>` extended
  in memory, ASM-generated subclass), deterministic type ids 1024..4095 shared by client and server; the agent
  also runs on dedicated servers (`agent/`, `=server`). Registration in `onLoad` is deferred safely.
- `/give [player] <item> [count]` like Minecraft (inventory, stacking, drops overflow, never replaces the held item),
  server-routed with `openvoxel.command.give(.others)`.
- Tab list header/footer: YAML lists or `
` text (several lines).
- Full Javadoc published on the website; template mod no longer spams chat (`/where`).
- Server list MOTD (`gameplay.motd`, agent patches the status reply) and real max players; join message is `gameplay.welcome-message`.
- Tab completion per argument position.
- Client and server code split into packages; `Permissions` moved to `server.permissions` (breaking for plugins).

## 2026-10-18 — OpenVoxel ModLoader 1.1.0-pre2 (client + server, pre-release)

- Client: ModLoader block code stored in the block state (bits 32..55 hash of namespace:path, facing 56..57)
  so blocks mesh with world lighting, persist in saves and sync to other ModLoader players; BlockRegistry +
  `ModContext.registerBlock`; death screen; Minecraft pick block; explained connection errors; game-styled main menu.
- Server: `Permissions` API (provider interface), ops.yml / permissions.yml, every command gated by a node,
  `/op /deop /gamemode /whitelist /msg /spawn /setspawn /warp /setwarp /delwarp /warps /perms`, tablist.yml,
  `gameplay` section in server.properties.yml; start scripts remove older core jars from plugins/.

## 2026-10-18 — OpenVoxel ModLoader 1.1.0-pre1 (client, pre-release)

- Torches: wall torches (tilted model variant via `BlockType.getModel(state)` hook, facing +
  "upside" bit in the state), support rules (pop off when the block below/behind breaks),
  never replaced by placed blocks (`BlockPlacement.canReplaceInto` hook).
- Client-side mobs (`Mobs`): pig and zombie box models, wander/chase AI, melee combat with
  swords/knockback, drops (porkchop, rotten flesh), `/mobs` command.
- Recipe book (`RecipeBook`) in the survival inventory (2x2) and crafting table (3x3).
- Creative inventory rewritten: icon tabs (blocks, tools, combat, food, materials,
  inventory), counts shown, Minecraft right-click semantics; `/clear`.
- Chat: suggestion popup with argument completers, Up/Down selection; Tab player list (`Net`).
- Control channel for ModLoader servers (`ML:` chat lines: hello, cmds, gm, tab);
  `/mlhello` on join; game mode requests go to the server when it answers.
- Fix: camera aspect synced to the framebuffer every frame — menus on maximized/fullscreen
  windows were drawn stretched and clicks missed the buttons.
- First-person arm pose, chest tile textures, `ModContext.setHotbarSlot`.

## 2026-10-12 — OpenVoxel ModLoader 1.0.0 (repo split)

- Project split into `repos/` for the GitHub org OpenVoxel-ModLoader: `modloader-client`
  (agent, examples, instance, scripts), `modloader-server` (core plugin + HungerGames
  example + start scripts), `docs` (static Pages site), `voxelnames` (API + site).
- Brand "Voxelite" → "OpenVoxel ModLoader"; jars `ModLoader-v1.0.0-vgame-0.0.8-client.jar`
  and `ModLoader-v1.0.0-vgame-0.0.8-server.jar` in each repo's `dist/`.
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
