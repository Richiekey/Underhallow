# UNDERHALLOW

## PLAYER CONTROL, MOVEMENT & INTERACTION SPECIFICATION V1.0

**Document Status:** Draft  
**Version:** 1.0  
**Parent Specification:** [Core Gameplay Systems Specification V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)  
**Project:** Underhallow  

---

# 1. Purpose

This specification defines how the player physically controls, navigates, interacts with, and experiences the world of **Underhallow**.

It establishes the foundation for:

* Player movement
* Keyboard and mouse controls
* Interaction
* Facing direction
* Tool usage
* Environmental interaction
* Collision
* Camera behavior
* Building and farming targeting
* Combat controls
* World transitions
* Interior transitions
* Player states
* Hotbar behavior
* Input architecture
* Accessibility
* Interaction feedback

This document defines **player-facing behavior and system rules**, not implementation-specific code.

---

# 2. Control Philosophy

Underhallow uses a **Cozy Adventure RPG** control philosophy.

The player should feel:

* Responsive
* Free
* Comfortable
* In control
* Able to explore naturally
* Able to interact with the environment without fighting the controls

The game should combine:

> **Free-feeling movement + contextual interaction + simple action combat + environmental interaction**

The player should never feel that the underlying systems are unnecessarily getting in the way of the world.

---

# 3. Primary Control Model

Underhallow supports both:

### Direct Movement

Keyboard movement using:

* WASD
* Arrow keys

### Mouse Movement

Click-to-move functionality is supported.

The input system therefore supports:

```text
Keyboard
   ↓
Direct Player Movement

Mouse
   ↓
Click-to-Move
```

Both methods control the same underlying player movement system.

---

# 4. Input Abstraction

Movement and interaction systems must not be directly coupled to individual physical input devices.

The architecture should conceptually operate through actions:

```text
MoveUp
MoveDown
MoveLeft
MoveRight
Interact
UseTool
Attack
OpenInventory
OpenMap
HotbarSelect
Cancel
```

Keyboard and mouse inputs map to those actions.

This allows future input methods to be added without rewriting the gameplay systems.

---

# 5. Diagonal Movement

Diagonal movement is supported.

The movement system must normalize diagonal velocity so that:

> Moving diagonally does not make the player move faster than moving horizontally or vertically.

The player's maximum movement speed remains consistent regardless of direction.

---

# 6. Movement Speed

Underhallow uses **context-dependent movement speed**.

Movement speed can change depending on the current movement context.

Examples may include:

* Normal terrain
* Difficult terrain
* Special environmental conditions
* Temporary movement effects

However, movement speed changes must remain readable and should not make basic navigation frustrating.

---

# 7. Sprinting

There is **no sprint system in V1.0**.

The player has a standard movement speed.

This is consistent with the broader decision to remove stamina/energy restrictions.

There should therefore be no:

* Sprint stamina
* Sprint meter
* Energy drain
* Sprint cooldown

introduced into the V1 player controller.

Future movement abilities may be introduced independently if justified.

---

# 8. Movement During Actions

Movement behavior depends on the action being performed.

Some actions temporarily commit the player to an animation or state.

Others can be interrupted by movement.

Examples:

| Action             | Movement             |
| ------------------ | -------------------- |
| Walking            | Allowed              |
| Talking            | Restricted/committed |
| Tool use           | Action-dependent     |
| Harvesting         | Action-dependent     |
| Fishing            | Restricted           |
| Attacking          | Action-dependent     |
| Building placement | Restricted           |
| Reading dialogue   | Restricted           |

The individual systems may define more specific rules.

The player controller must therefore support **action-specific movement locking** rather than using one universal rule.

---

# 9. Player Facing Direction

Facing direction is a meaningful part of the player controller.

The player's orientation affects:

* Tool usage
* Combat
* Environmental interaction
* NPC interaction
* Fishing
* Directional actions
* Animation

The player should naturally face the direction of movement.

---

# 10. Auto-Facing

Auto-facing is **context-dependent**.

For example:

* NPC conversation may automatically face the NPC.
* Tool actions may orient toward the target.
* Combat may preserve deliberate player orientation.
* Environmental interactions may orient the player toward the object.

Automatic orientation should make interactions feel natural without taking control away from the player during skill-based actions.

---

# 11. Interaction Philosophy

Underhallow uses a **hybrid interaction model**.

The primary interaction model is:

> Approach → contextual interaction becomes available → interact.

However, direct clicking can also be used where appropriate.

The system should not require the player to precisely click tiny pixel-art objects.

---

# 12. Universal Interaction Key

**E** is the primary interaction key.

Examples:

```text
E → Talk
E → Open
E → Harvest
E → Read
E → Enter
E → Inspect
E → Pick Up
```

The action performed by E depends on the current interaction context.

---

# 13. Contextual Interaction

The interaction system determines the most appropriate action based on:

* Distance
* Facing direction
* Object type
* Player state
* Equipped item
* Interaction priority
* World context

The player should not need a separate key for every object type.

---

# 14. Interaction Range

Interaction range is **context-sensitive**.

Different interactions can have different valid ranges.

For example:

* NPC conversation
* Picking up an item
* Opening a chest
* Harvesting
* Inspecting an object

may each have different ranges.

The player should generally need to be reasonably close to the object.

The system should also incorporate directional awareness so that objects behind the player do not unnecessarily become the active interaction target.

---

# 15. Interaction Targeting

When several interactables are nearby, the system selects an appropriate target using contextual priority.

Target selection can consider:

1. Interaction validity
2. Distance
3. Player facing direction
4. Object priority
5. Current player state
6. Current equipped tool

The exact priority table should be maintained centrally rather than duplicated across gameplay systems.

---

# 16. Multiple Nearby Interactables

When multiple valid targets exist simultaneously, the player can cycle/select between available interaction targets where necessary.

This prevents ambiguous situations where the game chooses an unexpected object.

The system should make the currently selected interaction clear to the player.

---

# 17. Interaction Feedback

All interactable objects should use a standardized interaction-feedback framework.

Feedback can include:

* Interaction prompt
* Animation
* Sound
* Particle effects
* UI notification
* Item popup
* Dialogue
* Object state change

The exact feedback depends on the interaction.

This provides consistency across:

* NPCs
* Crops
* Trees
* Containers
* Doors
* Buildings
* Furniture
* Quest objects
* Mystery objects

---

# 18. Interaction UI

Interaction UI should appear primarily when the player is close enough to interact.

Example:

> **E — Talk**

or:

> **E — Harvest**

The UI should remain unobtrusive.

Underhallow should not fill the screen with interaction labels.

---

# 19. Environmental Interaction

Environmental interaction is a major part of the Underhallow experience.

Players should be able to interact with appropriate world objects for both gameplay and immersion.

Examples:

* Read signs
* Inspect objects
* Open containers
* Sit on benches
* Examine statues
* Interact with furniture
* Investigate unusual objects
* Enter buildings
* Activate mechanisms

Environmental interaction is especially important for the game's mystery layer.

---

# 20. Hidden Interactions

Some interactions may intentionally lack obvious prompts.

These are primarily reserved for:

* Mystery content
* Secrets
* Lore
* Special discoveries

Ordinary gameplay interactions should remain discoverable.

Hidden interactions should reward curiosity rather than create arbitrary frustration.

---

# 21. Item Pickup

Underhallow uses a **context-sensitive pickup system**.

Ordinary ground resources can be picked up through contextual interaction.

Important or unique objects may require deliberate interaction.

The pickup system must respect:

* Inventory capacity
* Item type
* Current player state
* Interaction range

---

# 22. Dropped Items

Dropped items exist as **physical world objects**.

They can therefore:

* Occupy space
* Be visually represented
* Be picked up
* Participate in world interactions

The system should avoid creating excessive numbers of persistent objects that could negatively affect browser performance.

---

# 23. Tool Usage

Tools use a direct directional interaction model.

The player:

1. Equips the tool.
2. Faces the intended target.
3. Activates the tool.
4. The tool performs its action.

Example:

```text
Equip Axe
   ↓
Face Tree
   ↓
Use Tool
   ↓
Axe Animation
   ↓
Tree State Changes
   ↓
Resources Produced
```

---

# 24. Tool Targeting

Tool targeting is contextual.

Some tools may use a visible target indicator.

Others can rely primarily on:

* Facing
* Range
* Collision
* Target validity

Target indicators should be used when they materially improve precision.

They should not clutter ordinary exploration.

---

# 25. Farming Targeting

Farming interactions use the underlying world grid.

The player can select the appropriate farming action and target a valid tile.

The system should clearly communicate:

* Valid tile
* Invalid tile
* Selected action
* Expected placement

Exact farming mechanics belong to the Farming Systems Specification.

---

# 26. Grid Visibility

The underlying grid is **not permanently visible**.

The grid becomes visible when relevant, particularly during:

* Farming
* Building
* Placement
* Other grid-dependent activities

This preserves the natural visual appearance of the isometric world.

The player should experience the world as a physical environment rather than as a constantly visible grid.

---

# 27. Building Placement

Building uses a **ghost/preview placement system**.

The player selects a structure and receives a visual preview showing where it would be placed.

The preview communicates:

* Position
* Size
* Orientation
* Validity
* Collision
* Occupied tiles

Invalid placements must be clearly distinguishable.

---

# 28. Building Rotation

Buildings support multiple orientations.

Rotation is available during placement.

The system should ensure that rotation remains consistent with:

* Grid alignment
* Collision
* Doors
* Entrances
* Building footprint
* Pathing

---

# 29. Collision Philosophy

Underhallow uses a **hybrid collision model**.

The world may use grid logic for:

* Building placement
* Farming
* Structured world objects

while physical movement uses natural collision shapes.

This allows the world to remain visually organic while retaining predictable placement rules.

---

# 30. Environmental Collision

Objects that can meaningfully obstruct the player can have collision.

Potential collision objects include:

* Buildings
* Trees
* Rocks
* Fences
* Cliffs
* Water
* Furniture
* Other environmental structures

Collision should be designed to prevent frustration.

Invisible or excessively large collision boundaries should be avoided.

---

# 31. NPC Collision

NPCs use **soft collision behavior**.

NPCs should not behave like immovable walls.

If the player approaches an NPC:

* The NPC can shift appropriately.
* The player should not become permanently trapped.
* Crowded areas should remain navigable.

---

# 32. Creature Collision

Creatures also use contextual collision.

Their collision behavior may vary according to whether they are:

* Passive
* Neutral
* Hostile
* Being hunted
* In combat

Combat encounters can use more deliberate collision rules than ordinary wildlife.

---

# 33. Water

The player cannot freely walk into deep water.

Water acts as a world boundary where appropriate.

Boats provide the primary mechanism for travelling between islands.

Shallow-water behavior can be introduced where appropriate to specific environments without implying a full swimming system.

---

# 34. Elevation and Cliffs

Underhallow uses a **mostly visual elevation model**.

The isometric world may contain:

* Hills
* Cliffs
* Raised areas
* Ledges
* Terrain elevation

but movement remains constrained to explicitly navigable spaces.

There is no general-purpose fall-damage/falling system in V1.

---

# 35. Camera Philosophy

Underhallow uses a controlled isometric camera.

The camera supports:

* Isometric presentation
* Player following
* Limited look-ahead
* Player-controlled zoom
* Player-controlled rotation

The camera should preserve the game's pixel-art composition while providing sufficient visibility for exploration.

---

# 36. Camera Rotation

Camera rotation occurs in **90-degree increments**.

The player can rotate between the supported isometric orientations.

This keeps:

* Pixel-art composition consistent
* Tile orientation predictable
* Building orientation understandable
* World presentation coherent

Continuous free rotation is not required.

---

# 37. Camera Following

The camera smoothly follows the player.

A limited look-ahead can shift the camera slightly toward the direction the player is travelling.

This helps the player see where they are going without allowing the camera to drift excessively away from the character.

---

# 38. Camera Boundaries

The camera respects world boundaries.

It should not expose:

* Empty space
* Outside-map areas
* Unintended hidden content
* Unfinished world geometry

Camera constraints may vary by world location where necessary.

---

# 39. Camera Zoom

The player can control camera zoom within a limited range.

Zoom should never:

* Break the intended composition
* Reveal unfinished content
* Make characters unreadably small
* Create excessive rendering cost

The available zoom range should be tuned through playtesting.

---

# 40. Camera and Pixel Art

The camera system must preserve the visual integrity of Underhallow's pixel-art style.

Particular care must be taken to prevent:

* Unnecessary pixel shimmering
* Blurry sprites
* Unstable scaling
* Sub-pixel artifacts
* Inconsistent sprite sizes

The exact rendering solution belongs to the Technical Architecture and Art/Rendering specifications.

---

# 41. Movement Animation

The player controller should support appropriate animation states including:

* Idle
* Walking
* Tool use
* Attacking
* Fishing
* Harvesting
* Interaction
* Hurt
* Defeat
* Other future contextual actions

Running animation is not required in V1 because sprinting has been removed.

Animation should communicate player state clearly.

---

# 42. Player State Machine

The player controller should use explicit movement/action states.

A conceptual state model is:

```text
                ┌────────────┐
                │    IDLE    │
                └─────┬──────┘
                      │
                  Movement
                      │
                      ▼
                ┌────────────┐
                │  MOVING    │
                └─────┬──────┘
                      │
              ┌───────┼────────┐
              ▼       ▼        ▼
          INTERACT   TOOL     ATTACK
              │       │        │
              └───────┼────────┘
                      ▼
                    IDLE
                      │
                    EVENT
                      ▼
                  DEFEATED
```

Additional states may include:

* Fishing
* Building
* Transitioning
* Dialogue
* Menu
* Stunned
* Entering/Exiting

The state system must prevent incompatible actions from executing simultaneously.

---

# 43. Action Commitment

Actions can have different commitment levels.

Some actions can be immediately interrupted.

Others must complete their current animation/action.

This allows the game to maintain responsive controls without making every action cancellable.

Combat, tool use, fishing and interactions can define their own commitment behavior.

---

# 44. Tool vs Interaction

The player controller separates:

**Interact**

from:

**Use Equipped Tool**

This is important.

For example:

> Player equips axe → approaches NPC → pressing E can still talk to the NPC.

The equipped tool should not automatically override contextual interactions.

---

# 45. Control Separation

The core actions are conceptually separated into:

```text
Movement
Interaction
Tool Use
Combat
Inventory
Hotbar
Camera
Menus
```

This prevents individual gameplay systems from hijacking unrelated controls.

---

# 46. Hotbar

Underhallow uses a hotbar.

The hotbar provides rapid access to commonly used:

* Tools
* Seeds
* Items
* Consumables
* Other usable objects

The exact number of slots is deferred to the Inventory Specification.

---

# 47. Quick Use

The player does **not** have unrestricted quick-use behavior for every inventory item.

Quick-use behavior is reserved for item categories where it improves gameplay.

This prevents the control scheme from becoming overloaded.

---

# 48. Combat Control Philosophy

Combat uses **simple directional real-time combat**.

The player controls movement directly and attacks through a dedicated action.

Combat should feel:

* Responsive
* Readable
* Simple
* Accessible

It should not become a complex ability-rotation system.

---

# 49. Combat Targeting

Combat uses **soft targeting** rather than a hard lock-on system.

The player remains responsible for positioning and facing.

Target assistance may help determine which nearby creature an attack connects with, but the player should retain meaningful directional control.

---

# 50. Attack Commitment

Attacks are **interruptible**.

The player can move out of an attack sequence rather than being completely locked into a long animation.

This supports responsive combat and prevents simple encounters from feeling unnecessarily sluggish.

Attack animations must still provide enough commitment and timing to make combat meaningful.

---

# 51. Player Interaction with NPCs While Equipped

The interaction system remains contextual.

If the player is carrying a tool and approaches an NPC:

> **E → Talk**

rather than:

> **E → swing tool**

unless the specific context explicitly requires tool use.

This protects the social/cozy identity of the game.

---

# 52. Mouse Controls

Mouse input is context-sensitive.

Mouse actions can be used for:

* Click-to-move
* Selecting targets
* Placement
* UI interaction
* Other contextual actions

The mouse should not be permanently assigned to one world action.

---

# 53. Pause Behavior

Opening major menus pauses the single-player world where appropriate.

This includes menus such as:

* Inventory
* Major configuration screens
* Other full-screen management interfaces

The exact list of pause-sensitive interfaces should be defined by the relevant systems.

---

# 54. Time During Interaction

The game clock **pauses during major interaction states** where the player is effectively removed from active world simulation.

This includes appropriate cases such as:

* Dialogue
* Inventory
* Major menus
* Certain interaction screens

World-time-sensitive activities such as active exploration continue normally outside these paused states.

---

# 55. World Transitions

Travel between islands uses a **hybrid diegetic transition**.

The intended flow is:

```text
Walk to Dock
     ↓
Interact
     ↓
Board / Travel Sequence
     ↓
Transition
     ↓
Arrive at Destination
```

The player should feel that they travelled rather than simply selecting a menu option.

---

# 56. Interior Transitions

Interior transitions are **building-dependent**.

Different buildings may use:

* Seamless entry
* Short transitions
* Separate interior scenes

The decision depends on:

* Building type
* Interior complexity
* World streaming requirements
* Gameplay importance

The player experience should remain consistent enough that entering a building never feels confusing.

---

# 57. Doors

Doors use an interaction-based model.

The player approaches a door and uses:

> **E — Enter**

where appropriate.

Automatic door opening is not the universal behavior.

This gives important entrances a clear interaction point.

---

# 58. Furniture Interaction

Furniture can be interactive.

However, not every decorative object needs a gameplay interaction.

The intended model is:

> **Functional furniture + selected immersive interactions**

Examples:

* Bed → sleep/rest
* Chest → storage
* Crafting station → crafting
* Chair → sit
* Bookshelf → potentially inspect/read

Decorative objects can remain purely visual where interaction adds no value.

---

# 59. Avatar Customization

Full avatar customization is **not a V1 requirement**.

The controller must nevertheless be designed so that player appearance can be expanded later.

Potential future customization includes:

* Hair
* Clothing
* Accessories
* Equipment appearance
* Other cosmetic elements

---

# 60. Equipment Visibility

Equipped equipment should be visible on the player where appropriate.

This provides immediate visual feedback about what the player is carrying/equipping.

Visual representation should remain consistent with the pixel-art style.

---

# 61. Input Remapping

V1 should architect the input system to support remapping.

However, a complete control-remapping UI is not required immediately.

The underlying system should separate:

> **Input action**

from:

> **Physical key/button**

This keeps future accessibility and controller support possible without major architectural changes.

---

# 62. Controller Support

Gamepad/controller support is **not a V1 requirement**.

However, the input abstraction should avoid making future controller support impossible.

The initial control target is:

> **Desktop browser + keyboard + mouse**

---

# 63. Mobile/Touch

Mobile/touch is **not a V1 target**.

Underhallow should not compromise the desktop control experience in order to support touch prematurely.

However, the input architecture should remain sufficiently abstract that touch support can be explored later.

---

# 64. Accessibility

Basic accessibility is required from V1.

The system should support appropriate accessibility features including:

* Readable UI
* Adjustable UI scale where feasible
* Clear interaction feedback
* Non-color-only interaction indicators
* Reduced excessive visual effects where practical
* Clear state communication

Accessibility should be treated as part of the system design rather than a last-minute patch.

---

# 65. AFK Behavior

If the player remains inactive, the world does not automatically enter a special AFK state in V1.

The game continues according to its normal rules unless the player explicitly pauses.

This means players should not assume that standing still automatically freezes:

* Time
* NPCs
* World simulation
* Environmental activity

---

# 66. Defeat State

Defeat is a dedicated player state.

The conceptual sequence is:

```text
Combat
   ↓
Defeat
   ↓
Defeat Feedback
   ↓
Resources From Current Expedition Lost
   ↓
Return to Personal Island
   ↓
Player Regains Control
```

The player does not enter a traditional permanent-death state.

Permanent progression remains intact.

---

# 67. Control Invariants

The following rules are protected.

### Invariant 1 — Responsive Movement

Basic movement must always feel responsive.

### Invariant 2 — No V1 Stamina

Movement is not restricted by an energy/stamina meter.

### Invariant 3 — Contextual Interaction

The player should not need a separate button for every world interaction.

### Invariant 4 — E Is Primary Interaction

E remains the default interaction action.

### Invariant 5 — Facing Matters

Orientation matters for tools, combat and relevant environmental interactions.

### Invariant 6 — No Permanent Camera Chaos

Camera rotation and zoom remain controlled.

### Invariant 7 — No Permanent Grid Overlay

The underlying grid is hidden during ordinary exploration.

### Invariant 8 — Soft NPC Collision

NPCs must not easily trap the player.

### Invariant 9 — Combat Remains Simple

Combat supports hunting and exploration rather than becoming the game's dominant system.

### Invariant 10 — Input Is Abstracted

Gameplay systems operate on actions rather than directly depending on physical input devices.

### Invariant 11 — Desktop First

V1 prioritizes browser desktop controls.

### Invariant 12 — Future Expansion

Controller, touch and expanded customization should remain technically possible.

---

# 68. High-Level Player Control Loop

The resulting player-control architecture can be represented as:

```text
                   INPUT
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
       Keyboard     Mouse     Future Input
          │          │
          └─────┬────┘
                ▼
          INPUT ACTIONS
                │
       ┌────────┼────────┐
       ▼        ▼        ▼
   MOVEMENT  INTERACTION  CAMERA
       │        │
       │        ├──────────────┐
       │        ▼              ▼
       │      TOOLS          WORLD
       │        │              │
       ▼        ▼              ▼
    PLAYER STATE / ACTION STATE
                │
                ▼
             ANIMATION
                │
                ▼
             FEEDBACK
```

This structure should remain independent of the specific rendering implementation.

---

# 69. Relationship to Other Specifications

This document establishes the player-facing control foundation for:

### Inventory Specification

Defines hotbar, item selection and inventory interaction.

### Farming Specification

Defines grid targeting, crop interaction and farming actions.

### Hunting & Combat Specification

Defines attack behavior, hit detection and combat states.

### Building & Personal Island Specification

Defines placement, rotation and construction interaction.

### Time & World Simulation Specification

Defines the relationship between movement, menus, world time and day/night.

### Technical Architecture Specification

Defines the actual implementation architecture behind these behaviors.

---

# 70. Deferred Decisions

The following remain intentionally outside this specification:

* Exact movement speed values
* Exact interaction distances
* Exact camera zoom values
* Exact camera follow distance
* Exact hotbar slot count
* Exact collision shapes
* Exact pathfinding algorithm
* Exact animation frame counts
* Exact attack ranges
* Exact tool ranges
* Exact farming grid dimensions
* Exact building footprints
* Exact controller mappings
* Complete accessibility settings
* Final mobile controls

These should be resolved in the relevant detailed specifications or during implementation tuning.

---

# 71. Definition of Done

The Player Control, Movement & Interaction system is considered ready for implementation when:

* Keyboard movement works.
* Click-to-move is supported.
* Diagonal movement is normalized.
* No stamina/sprint system exists.
* Context-dependent movement locking works.
* E functions as the primary interaction action.
* Interaction targeting is contextual.
* Facing direction is supported.
* Tool targeting works.
* Farming/building can use grid targeting.
* Building preview/rotation is supported.
* Hybrid collision is implemented.
* NPC collision cannot easily trap the player.
* Isometric camera follows the player.
* 90° camera rotation works.
* Limited zoom works.
* Camera boundaries work.
* Interaction feedback is standardized.
* Player states are explicit.
* Hotbar interaction exists.
* Simple real-time directional combat can connect to the controller.
* Island travel supports a diegetic transition.
* Interior transitions can vary by building.
* Basic accessibility considerations are included.
* Input abstraction allows future controller/touch support.

---

# 72. Final Design Principle

The player controller should disappear into the experience.

The player should not be thinking:

> *"How do I make the game do what I want?"*

They should simply think:

> **"I want to walk over there."**  
> **"I want to pick that up."**  
> **"I want to talk to that person."**  
> **"I want to investigate that strange thing."**  
> **"I want to go deeper into this forest."**  

And the game should respond naturally.

That is the control standard for **Underhallow**.
