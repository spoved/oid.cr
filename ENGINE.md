## Definitions

**Data**: The game *state*. Data such as health, inventory, experience, enemy type, ai state, movement speed etc. In Entitas these data live in *Components*.

**Logic**: The rules for how the data can be transformed. PlaceInInventory(), BuildItem(), FireWeapon() etc. In Entitas these are *Systems*.

**View**: The code responsible for displaying the game state to the player, rendering, animation, audio, ui widget etc. In my examples these will be *MonoBehaviours* living on *GameObjects*.

**Services**: Outside sources and sinks for information e.g. Pathfinding, Leaderboards, Anti-Cheat, Social, Physics, even the game engine itself.

**Input**: Outside input to the simulation, usually via limited access to parts of the game logic e.g. controller / keyboard / mouse input, network input.

## Architecture

### Service Modules

All services should extend `Oid::Service`

- ai
- application
- config
- input
- logger
- physics
- time
- view

Example of creating a service module

```crystal
# Define a service and extend the service module
class DebugLogService
  include Oid::Service::Logger
  spoved_logger

  def log(msg : String)
    logger.info(msg)
  end
end

# Register the service by creating a helper class that has a reference to each service in it
register_services(
  {
    name:    :logger,
    service: DebugLogService,
  }
)

# Create the services class
services = Services.new(
  logger: DebugLogService.new
)
```

### Controller Modules

All services should extend `Oid::Controller`

- physics
- view
