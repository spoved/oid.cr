## Definitions

**Data**: The game *state*. Data such as health, inventory, experience, enemy type, ai state, movement speed etc. In Entitas these data live in *Components*.

**Logic**: The rules for how the data can be transformed. PlaceInInventory(), BuildItem(), FireWeapon() etc. In Entitas these are *Systems*.

**View**: The code responsible for displaying the game state to the player, rendering, animation, audio, ui widget etc. In my examples these will be *MonoBehaviours* living on *GameObjects*.

**Services**: Outside sources and sinks for information e.g. Pathfinding, Leaderboards, Anti-Cheat, Social, Physics, even the game engine itself.

**Input**: Outside input to the simulation, usually via limited access to parts of the game logic e.g. controller / keyboard / mouse input, network input.

## Architecture
