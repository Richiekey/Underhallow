# UNDERHALLOW

## PLAYER CONTROL, MOVEMENT & INTERACTION SPECIFICATION V1.0

**Document ID:** PC-001  
**Version:** 1.0  
**Document Status:** DRAFT (Reconciliation Candidate V1.0)  
**Authority Level:** Level 1 — Foundation Specification  
**Parent Specifications:**  
* [North Star V1.0 (NS-001)](NORTH_STAR.md)
* [Creative Direction V1.0 (CD-001)](CREATIVE_DIRECTION.md)
* [Art Direction Bible V1.0 (AD-001)](ART_DIRECTION_BIBLE.md)
* [Core Gameplay Systems Specification V1.0 (CG-001)](CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [Engine & Technical Architecture Specification V1 (ETA-001)](ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)
* [World & Map Architecture Specification V1.0 (WM-001)](WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Master Specification Index & Build Governance V1.0 (MSI-001)](MASTER_SPECIFICATION_INDEX.md)

**Project:** Underhallow  
**Primary Domain:** Player Controller, Movement, Camera & Interaction  

---

# 1. Purpose

This specification defines how the player physically controls, navigates, interacts with, and experiences the world of **Underhallow**.

It establishes the foundation for:

* Player movement and locomotion
* Keyboard, mouse, and abstract action inputs
* Contextual and directional interaction
* Facing direction and orientation
* Tool usage activation interface
* Environmental and object interaction
* Player-facing collision philosophy
* Fixed isometric camera behavior and zoom
* Building and farming targeting interfaces
* Real-time directional combat control interface
* World, island, and interior transitions
* Player state categories and mutual exclusivity
* Hotbar selection and inventory interaction interfaces
* Input abstraction and accessibility
* Non-lethal defeat control flow
* Multiplayer player-to-player interaction interface

This document defines **player-facing behavior, control contracts, and system rules**, not engine-specific implementation code.

---

# 2. Control Philosophy

Underhallow uses a **Cozy Adventure RPG** control philosophy.

The player should feel:

* Responsive
* Free
* Comfortable
* In control
* Able to explore naturally

Controls must never feel sluggish, imprecise, or unnecessarily punishing.

The player controls a character who lives in a charming, strange, persistent world. Every movement, interaction, and action should support this sense of physical presence.

---

# 3. System Boundaries: What PC-001 Owns vs Does Not Own

To maintain clean architectural separation across the Underhallow specification library, PC-001 defines strict boundaries:

### What PC-001 Owns:
* Player locomotion, velocity, acceleration, and diagonal normalization.
* Logical input action abstractions and default keybindings.
* The contextual resolution rules between primary actions (Left Mouse Button) and interaction (`E`).
* Canonical interaction targeting hierarchy and target resolution algorithms.
* 8-directional facing resolution, orientation retention, and contextual auto-facing.
* Action commitment, interruption rules, and movement locking.
* Player controller state machine categories and state mutual exclusivity.
* Isometric camera behavior, tracking, look-ahead, boundaries, and zoom clamping.
* Player-facing collision philosophy and response rules.
* The activation and targeting interfaces for tools, farming tiles, building previews, and weapons.
* Player control handling during world transitions, interior entries, and defeat sequences.
* Player-facing interaction interface with other players in multiplayer.

### What PC-001 Does NOT Own:
* Farming economics, crop growth algorithms, seed definitions, or soil degradation (owned by [FB-001](FARMING_SYSTEM_SPECIFICATION.md)).
* Physical resource node spawning, regeneration, or depletion (owned by [RG-001](MASTER_SPECIFICATION_INDEX.md)).
* Naturally occurring wild plant/berry foraging generation (owned by [FR-001](MASTER_SPECIFICATION_INDEX.md)).
* Livestock welfare, care, feeding, or animal product simulation (owned by [LA-001](MASTER_SPECIFICATION_INDEX.md)).
* Cooking recipes, station processing, or food buff formulas (owned by [CK-001](MASTER_SPECIFICATION_INDEX.md)).
* Hunting creature stats, combat damage formulas, weapon balance, or creature AI (owned by [HU-001](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md)).
* Item data schemas, inventory capacity, stack limits, or crafting recipes (owned by [II-001](MASTER_SPECIFICATION_INDEX.md)).
* Constructible building catalogs, construction timers, or material recovery formulas (owned by [BI-001](BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md)).
* Island geography, layout, or regional borders (owned by [MI-001](MAIN_ISLAND_DESIGN_SPECIFICATION.md) and [PI-001](PERSONAL_ISLAND_DESIGN_SPECIFICATION.md)).
* Traversal vehicle mechanics, ferry scheduling, or transit networks (owned by [TR-001](MASTER_SPECIFICATION_INDEX.md)).
* Weather states, atmospheric effects, or rain simulation (owned by [WE-001](MASTER_SPECIFICATION_INDEX.md)).
* Day/night cycles, simulation time, or game clocks (owned by [TS-001](TIME_CALENDAR_SYSTEM_SPECIFICATION.md)).
* Economy, pricing, currency, or merchant trading rules (owned by [EC-001](MASTER_SPECIFICATION_INDEX.md)).
* Server network authority, replication protocols, or client-side prediction algorithms (owned by [ETA-001](ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)).
* Party structures, guilds, permissions, or social systems (owned by [MS-001](MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)).

---

# 4. Multiplayer Authority & Control Pipeline

Underhallow is **single-player-first, multiplayer-native**.

PC-001 defines the player-facing feel and intent; [ETA-001](ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) defines technical network authority.

The control pipeline operates strictly as:

```text
Physical Input (Keyboard / Mouse)
        ↓
Logical Input Action
        ↓
Local Player Intent & Controller Prediction
        ↓
Command Execution Request (Command Pipeline)
        ↓
Authoritative Validation (Server / Host Runtime)
        ↓
State Mutation (GameState / PlayerState)
        ↓
Network Replication & Event Emission
        ↓
Presentation & Animation Confirmation
```

In single-player mode, validation executes immediately within the local runtime. In multiplayer mode, the client predicts local movement for responsiveness, while authoritative validation guarantees placement, inventory consumption, and interaction legality without client-side spoofing.

---

# 5. Primary Control Model

Underhallow supports dual movement modalities:

### Direct Movement (Primary)
Direct keyboard control using:
* **WASD**
* **Arrow keys**

### Mouse Movement (Supported)
Click-to-move functionality allowing players to click a destination or interactable.

Both input streams feed into the same unified logical movement system:

```text
Keyboard Input ──┐
                 ├──► Unified Movement & Navigation System ──► Player Character
Mouse Click    ──┘
```

---

# 6. Input Abstraction & Action Mapping

Gameplay systems must never depend directly on physical hardware codes. All control logic interfaces through standardized logical actions:

| Logical Action | Default Primary Binding (PC V1) | Default Secondary Binding | Purpose |
| :--- | :--- | :--- | :--- |
| `move_up` | `W` | `Up Arrow` | Direct vertical screen-space up movement |
| `move_down` | `S` | `Down Arrow` | Direct vertical screen-space down movement |
| `move_left` | `A` | `Left Arrow` | Direct horizontal screen-space left movement |
| `move_right` | `D` | `Right Arrow` | Direct horizontal screen-space right movement |
| `interact` | `E` | `Space` | Universal contextual interaction trigger (world objects, NPCs) |
| `action_primary` | `Left Mouse Button` | `F` | Primary active hand action (use tool, attack with weapon, confirm placement) |
| `cancel` | `Right Mouse Button` | `Escape` | Cancel preview / close modal screens / un-focus |
| `hotbar_1` – `hotbar_8` | `1` – `8` | — | Select active hotbar slot |
| `toggle_inventory` | `Tab` | `I` | Toggle inventory screen |
| `open_map` | `M` | — | Open world map screen |
| `zoom_in` | `Mouse Wheel Up` | `PageUp` / `+` | Increment camera zoom level |
| `zoom_out` | `Mouse Wheel Down` | `PageDown` / `-` | Decrement camera zoom level |

This abstraction ensures that future controller or custom keybinding support can be introduced without modifying underlying gameplay mechanics.

---

# 7. Contextual Input Resolution Rules

To ensure predictable control semantics and avoid input collisions, Underhallow defines clear resolution rules for primary interactions:

### A. Contextual Interaction (`interact` — `E` / `Space`)
* `interact` is the **Universal World Contextual Interaction** key.
* It operates on whatever entity is currently focused by the **Canonical Interaction Targeting Hierarchy** (NPCs, harvestable crops, wild forage, chests, doors, inspectables).
* It is **independent of the equipped item**. A player holding a hoe, sword, or watering can who approaches an NPC or door presses `E` to talk or open without swinging their tool or striking.

### B. Primary Action (`action_primary` — `Left Mouse Button` / `F`)
`action_primary` operates as the **Equipped Hand Activation Action**. Its outcome is determined contextually by the current player state and hotbar selection:
1. **Direct Entity Click:** If the mouse cursor directly clicks on an in-range interactable entity in the world (e.g., clicking directly on Rowan or a storage chest), the system dispatches `interact` on that specific target.
2. **Tool Equipped (Hoe, Watering Can, Axe, Pickaxe):** Dispatches `use_tool` toward the targeted tile or resource node in the player's facing direction or cursor position.
3. **Weapon Equipped (Sword, Bow, Spear):** Dispatches `attack` along the player's facing vector or toward the cursor.
4. **Building Placement Active:** Confirms placement of the active ghost structure preview.
5. **Empty Hand / Inactive Item:** Performs no destructive action.

### C. Inventory vs. Target Cycling (`Tab` vs. `I`)
* `Tab` and `I` are strictly bound to `toggle_inventory`.
* `Tab` does **not** cycle targets. Target selection is resolved automatically by the Canonical Interaction Targeting Hierarchy based on proximity and the player's facing cone. If target cycling is added in the future as an accessibility option, it will receive a distinct, dedicated action (`cycle_target`), keeping `Tab` conflict-free.

---

# 8. Diagonal Movement & Normalization

Diagonal movement is fully supported.

The movement system must normalize composite directional vectors:

$$\vec{v}_{\text{normalized}} = \frac{\vec{v}}{\|\vec{v}\|} \quad \text{for } \|\vec{v}\| > 0$$

Moving diagonally must never allow a player to travel at $\sqrt{2} \approx 1.414\times$ speed. Maximum velocity remains identical whether moving along cardinal or diagonal vectors.

---

# 9. Locomotion Dynamics & Movement Speed

Underhallow uses continuous, responsive 2D movement with crisp acceleration and friction.

### Movement Parameters:
* **Continuous Locomotion:** Player movement is continuous in world space, not locked to discrete tile hops.
* **Acceleration & Friction:** Motion ramps up quickly and stops cleanly without sluggish sliding.
* **Context-Dependent Speed:** Base movement speed may be modified contextually by:
  * Authored roads and paved pathways (clean, unobstructed travel)
  * Difficult terrain such as dense wild vegetation or shallow wading water (subtle, readable speed reduction)
  * Temporary status conditions or environmental factors
* **Readability Invariant:** Speed modifications must remain subtle and readable. Navigation must never feel frustratingly bogged down.

---

# 10. Sprinting & Stamina Invariant

There is **no sprint system and no stamina/energy meter in Underhallow V1.0**.

This embodies **Core Operating Invariant 5 (No Stamina)**:
* Player activity is never artificially restricted by an energy or stamina meter.
* Players do not run out of breath while walking, farming, or exploring.
* Constraints are physical time, inventory capacity, and expedition risk.
* There is no sprint key, stamina bar, exhaustion state, or sprint cooldown.

World traversal across the island network is expanded through boats, ferries, cleared wilderness trails, and shortcut infrastructure governed by [TR-001](MASTER_SPECIFICATION_INDEX.md), while basic locomotion on foot remains free from stamina micromanagement.

---

# 11. Movement During Actions & Action Commitment

To guarantee responsive gameplay without sacrificing animation weight, actions use a clear commitment framework:

| Action Category | Movement Permitted? | Can Be Interrupted? | Resolution Behavior |
| :--- | :--- | :--- | :--- |
| **Locomotion (Walk)** | Yes | Yes (Immediate) | Directional velocity responds every frame |
| **Basic Interaction** | Contextual | Contextual | Short inspects allow immediate step-away |
| **Tool Usage** | Restricted | System-defined | Movement locked during swing/till/water animation |
| **Crop Harvesting** | Restricted | No | Locks movement for short harvest animation |
| **Combat Attack** | Contextual | Early recovery | Movement locked during active frames; early recovery upon completion |
| **Fishing** | Locked | System-defined | Movement locked while fishing line is active; lifecycle governed by FI-001 |
| **Building Placement** | Free before placement | Yes (Cancel preview) | Movement allowed during preview; brief lock on confirm |
| **Dialogue** | Locked | No | Movement locked while conversation window is active |
| **World Transition** | Locked | No | Complete control lock during scene load / fade |
| **Defeat State** | Disabled | No | Complete control lock until respawn at cottage |

---

# 12. Player Facing Direction

Player facing direction is an authoritative component of `PlayerState`.

* **8-Directional Facing:** Facing resolves to 8 cardinal and intercardinal directions (`NORTH`, `NORTHEAST`, `EAST`, `SOUTHEAST`, `SOUTH`, `SOUTHEAST`, `WEST`, `NORTHWEST`).
* **Stationary Retention:** When the player stops moving, their facing direction is strictly preserved. Stationary players do not snap back to a default facing direction.
* **Gameplay Relevance:** Facing direction dictates:
  * Tool targeting tile selection
  * Directional melee attack arcs
  * Fishing cast direction
  * Interaction cone priority
  * Character sprite presentation

---

# 13. Contextual Auto-Facing

Auto-facing occurs contextually to assist player intent without overriding manual skill:

* **NPC Interaction:** Initiating dialogue automatically turns the player to face the NPC.
* **Object Inspection:** Interacting with a sign, chest, or door orients the player toward the interactable.
* **Tool Usage:** Activating a tool faces the targeted tile or node.
* **Combat:** Attacks fire along the player's current facing vector or toward the targeting cursor; auto-facing does not violently snap the player away from their intended direction.

---

# 14. Interaction Philosophy & Universal Key (E)

Underhallow uses a **hybrid contextual interaction model**:

> **Approach → Contextual target detected → Prompt displayed → Press E (or click) to interact.**

* **The Universal Key:** **`E`** is the primary interaction action across the entire game world (`E — Talk`, `E — Harvest`, `E — Open`, `E — Read`, `E — Enter`, `E — Pick Up`).
* **Accessibility Standard:** The player is never required to hunt for single-pixel collision shapes on detailed pixel art.
* **Mouse Integration:** Direct clicking on an interactable within valid range executes the interaction command.

---

# 15. Canonical Interaction Targeting Hierarchy

When multiple interactables exist near the player, the active target is resolved through a strict deterministic priority sequence:

```text
Step 1: Interaction Validity Check (Is object currently interactable?)
                  ↓
Step 2: Proximity Range Check (Is object within its valid interaction radius?)
                  ↓
Step 3: Directional Cone Filter (Is object within the player's front facing arc?)
                  ↓
Step 4: Priority Tier Evaluation:
        Tier 1: Active Dialogue / Quest NPCs
        Tier 2: Harvestable Crops / Depletable Resource Nodes
        Tier 3: Doors / Portal Transitions / Containers (Chests)
        Tier 4: Loose Physical Dropped Items (Contextual Pickup)
        Tier 5: Immersive / Inspectable Objects (Signs, Statues, Furniture)
                  ↓
Step 5: Distance Tie-Breaker (If same tier, choose closest Euclidean distance)
                  ↓
Step 6: Display Targeted Feedback & Bind Universal Key (E)
```

### Proximity & Focus Resolution
When multiple valid objects are close together, the system deterministically highlights the highest-tier, closest object in the player's forward arc. Players can shift focus naturally by stepping slightly or turning toward the desired object.

---

# 16. Interaction Feedback & UI Standardization

All interactables share a standardized presentation language:

* **Contextual Prompt:** A clean, readable prompt anchored above or near the object (`[E] Talk to Rowan`, `[E] Harvest Carrot`, `[E] Enter Cottage`).
* **Prompt Suppression:** Prompts appear only when the player enters the interaction trigger volume, preventing screen clutter.
* **Sound & Visual Confirmation:** Successful interactions emit clear audio feedback and contextual visual changes (e.g., chest opens, bush berries disappear, NPC turns to face player).

---

# 17. Environmental & Hidden Interactions

* **Immersive World Objects:** Players can sit on benches, read signposts, examine ruins, inspect curious carvings, and activate mechanisms.
* **Subtle Mystery Discoveries:** In accordance with the mystery layer, some world secrets do not show bold UI prompts from a distance. They reveal themselves through subtle environmental anomalies (a discolored stone, strange sound, faint light) that yield an interaction prompt only when approached and closely inspected.

---

# 18. Physical Item Pickup & Dropped Items

* **Dropped Items as Physical Entities:** Discarded items or harvested resources dropped in the world exist as physical entities with ground-level footprints and depth sorting.
* **Contextual Pickup:** Approaching a dropped item displays a contextual pickup prompt (`[E] Pick up [Item Name]`).
* **Capacity Safeguard:** If inventory capacity is full, the item remains safely on the ground and displays an *"Inventory Full"* notification without destroying or losing the item.

---

# 19. Tool Usage Activation Interface

PC-001 governs the **activation and targeting interface** for tools:

```text
Equip Tool from Hotbar (1–8)
          ↓
Facing & Directional Target Selected
          ↓
Press ActionPrimary (Left Mouse / F)
          ↓
Movement Locked for Tool Action Duration
          ↓
Command Dispatched to Tool System
          ↓
Tool System Validates & Applies Mutation
          ↓
Animation & Sound Complete → Player Control Restored
```

* **Tool vs. Interaction Independence:** Holding a tool never disables contextual interaction (`E`). A player holding a hoe approaching an NPC will see `[E] Talk`, not an accidental tool strike.
* **No Resource Calculations:** Tool durability, damage numbers, and harvest yields are owned by [II-001](MASTER_SPECIFICATION_INDEX.md), [RG-001](MASTER_SPECIFICATION_INDEX.md), and [FB-001](FARMING_SYSTEM_SPECIFICATION.md).

---

# 20. Farming Tile Targeting Interface

PC-001 defines the player interface for farming interactions:

* **Grid Alignment:** When a farming tool (hoe, watering can, seeds) is equipped, the system projects an active tile targeting cursor on the nearest valid farm grid coordinate in front of the player.
* **Target Feedback:**
  * Green / highlighted border: Valid untilled ground (for hoe) or tilled ground (for seeds/water).
  * Red / disabled border: Invalid tile, out-of-bounds, or occupied plot.
* **Execution:** Activating the tool dispatches `TillSoilCommand`, `PlantCropCommand`, or `WaterCropCommand` to the authoritative runtime.
* **Grid Cleanliness:** The tile grid is hidden when non-farming tools are equipped.

---

# 21. Building Placement & Ghost Preview Interface

PC-001 defines the player interface for construction placement:

* **Ghost Preview:** Selecting a structure from the building catalog displays a translucent ghost preview following the cursor.
* **Snapping & Rotation:**
  * Major buildings snap to the structural construction grid.
  * Pressing `R` (or scroll wheel) rotates the preview through supported orientations.
  * Furniture and decorative objects support fine, expressive placement.
* **Validation Communicator:** Ghost tints green when placement is valid (unobstructed, valid terrain, within property boundary) and red when invalid.
* **Confirmation:** Left Click confirms placement; Escape / Right Click cancels without consuming materials.
* **Rule Authority:** Placement validation rules and persistence are governed by [BI-001](BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md).

---

# 22. Player-Facing Collision Philosophy

Underhallow utilizes a ground-footprint collision architecture:

* **Footprint Ground Collision:** The character's collision volume is constrained to the ground contact area at the feet, rather than a full-body upright bounding box. This prevents the character from being blocked by overhead geometry (tree canopies, roofs, eaves, hanging lanterns) and allows natural visual depth overlap.
* **Environmental Obstacles:** Solid terrain, cliffs, trees, large boulders, building walls, and closed gates block movement cleanly without sticky sliding artifacts.
* **NPC Soft Collision:** NPCs use soft collision volumes. An NPC will gently yield to the player; the player can never be permanently trapped or griefed in corners by NPCs.
* **Multiplayer Player Collision:** Other players use soft avoidance collision. Players cannot physically block doors, docks, or narrow paths to grief other players.
* **Impassable Water:** Deep water is a strict physical barrier. Players cannot walk into deep water; crossing waterways requires bridges or boats.
* **Elevation & Cliffs:** Cliffs represent impassable elevation boundaries. Movement remains strictly constrained to navigable authored paths; there is no freeform falling or fall damage.

---

# 23. Fixed Isometric Camera Model

The camera presentation is governed by strict architectural rules:

```text
Fixed Isometric Presentation (2:1 Dimetric standard)
           +
Smooth Target Tracking with Deadzone Filtering
           +
Subtle Directional Look-Ahead
           +
Clamped Player-Controlled Integer Zoom
           +
World Boundary Clamping
           +
STRICTLY NO CAMERA ROTATION IN V1.0
```

* **No Camera Rotation:** Camera rotation is **strictly disabled in V1.0** (per [SR-001](SPECIFICATION_RECONCILIATION.md), [AD-001](ART_DIRECTION_BIBLE.md), and [ETA-001](ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)). The camera orientation remains locked to a single fixed isometric angle. This protects 16-bit pixel-art hand-drawn sprite density, avoids costly 4-sided asset redundancy, and ensures spatial readability.
* **Smooth Tracking:** The camera tracks the player smoothly using asymptotic smoothing and deadzone filtering, avoiding jarring frame-to-frame snaps.
* **Directional Look-Ahead:** During sustained locomotion, the camera gently biases slightly forward in the direction of travel to expand forward visibility, easing back to center when stationary.
* **Controlled Zoom:** Players can adjust zoom within safe clamped limits (e.g., $1.0\times$ to $2.0\times$ / $3.0\times$). Zoom increments maintain integer pixel scaling to eliminate pixel shimmering and texture distortion.
* **Boundary Clamping:** The camera stops at authored region boundaries, preventing the rendering of empty outside-the-world space.

---

# 24. Player State Machine & Mutual Exclusivity

The player controller maintains an explicit state model to ensure **incompatible actions never execute simultaneously**:

### Core State Categories:
1. **`FREE` / `IDLE`:** Player is stationary, eligible to move, interact, equip, or activate tools.
2. **`MOVING`:** Player is traversing world space. Directional input is active.
3. **`INTERACTING`:** Player is executing a contextual interaction (opening chest, inspecting object).
4. **`TOOL_ACTION`:** Player is executing a tool strike (hoeing, watering, chopping). Movement is restricted.
5. **`ATTACKING`:** Player is executing a combat attack. Action commitment applies with early movement recovery.
6. **`FISHING`:** Player is engaged in fishing casting/minigame. Locomotion is locked.
7. **`HARVESTING`:** Player is gathering a crop or wild node. Locomotion is locked for harvest duration.
8. **`BUILDING`:** Player is in construction placement mode. Preview moves with cursor.
9. **`DIALOGUE`:** Player is actively conversing with an NPC. All movement and tool actions are locked.
10. **`TRANSITIONING`:** Player is traversing a world portal, boat route, or door. Controls disabled.
11. **`MENU`:** Full-screen interface (Inventory, Map, Crafting) is open. World simulation is paused in single-player.
12. **`DEFEATED`:** Health depleted during expedition. Controls disabled pending respawn.

### Mutual Exclusivity Invariant:
* A player cannot attack while in `DIALOGUE` or `MENU`.
* A player cannot use tools while `TRANSITIONING` or `DEFEATED`.
* Opening a modal menu immediately cancels active tool previews and returns the controller to a clean resting state.

---

# 25. Combat Control Interface

Combat operates as **simple, readable, real-time directional action** (grounded in [HU-001](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md)):

* **Direct Attack Action:** Left Click (`action_primary`) with a weapon equipped initiates a directional attack in the player's facing direction or toward the cursor.
* **Soft Targeting Assistance:** Combat uses soft cone detection to connect attacks with nearby hostile creatures without locking the player into an inflexible hard target camera lock.
* **Responsive Spacing:** Attack animations have clear windup and active frames, followed by early movement recovery. Evasion is based on positioning, spacing, and movement timing—there is no sprint, dash, or dodge-roll meter.
* **System Independence:** Weapon stats, creature health, hitboxes, damage numbers, and combat progression are governed by [HU-001](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md).

---

# 26. Click-to-Move Behavioral Boundary

Click-to-move provides an accessible alternative to keyboard navigation:

* **Walkable Destination:** Left-clicking an unobstructed walkable point generates an authoritative path toward that coordinate.
* **Interactable Destination:** Clicking directly on an interactable object moves the player into valid interaction range, automatically faces the object, and triggers the interaction upon arrival.
* **Unreachable Target:** Clicking an impassable area (water, cliff, solid wall) navigates the character to the closest valid reachable point.
* **Keyboard Override:** Any keyboard movement input (`W`, `A`, `S`, `D`) immediately cancels active click-to-move pathing and grants instant direct control to the keyboard.
* **Interaction Precedence:** Pressing `E`, activating a tool, or taking damage immediately halts click-to-move locomotion.
* **Implementation Boundary:** Click-to-move pathfinding is an engine presentation service; underlying physics and collision validation remain identical for both input modes.

---

# 27. World, Island & Interior Transitions

PC-001 governs the player control experience during transitions:

```text
Player Enters Portal Trigger / Boards Dock Ferry / Interacts with Door
                             ↓
            Player Controls Disabled & Movement Zeroed
                             ↓
               Transition Presentation (Fade / Animation)
                             ↓
                 New Map / Region Instantiated
                             ↓
            Player Positioned at Designated Target Marker
                             ↓
            Camera Snapped & Target Tracking Restored
                             ↓
                  Player Controls Fully Restored
```

* **Doors:** Doors use contextual interaction (`[E] Enter Cottage`) rather than accidental proximity walk-ins.
* **Travel:** Boarding boats at docks initiates a deliberate travel sequence; players do not teleport abruptly without diegetic context. Traversal mechanics belong to [TR-001](MASTER_SPECIFICATION_INDEX.md).

---

# 28. Defeat State & Expedition Return Flow

Underhallow operates on a **non-lethal defeat and expedition loss model** (Core Operating Invariant 6):

```text
Health Reaches Zero in Dangerous Wilderness / Dungeon
                          ↓
              Player Controls Immediately Disabled
                          ↓
             Defeat Animation & Atmospheric Fade Presentation
                          ↓
    Authoritative Expedition Resource Loss Applied (Expedition Loss)
                          ↓
    Player Respawned Safely at Cottage Bed on Personal Island
                          ↓
       Health Restored to Safe Minimum & Player Controls Restored
```

* **Permanent Progression Intact:** Player skill levels, tool ownership, personal island structures, and equipped items are never permanently lost.
* **Control Handover:** PC-001 ensures control disabling and restoration occur seamlessly without animation glitches or input lockups.

---

# 29. Multiplayer Player-to-Player Interaction

In multiplayer environments (governed by [MS-001](MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)):

* **Soft Avoidance Collision:** Players cannot form human walls or physically trap other players in cottages, shops, or narrow paths. Players gently slide past one another.
* **Proximity Interaction:** Approaching another player displays a dedicated social prompt (`[E] Inspect / Trade / Party`).
* **Non-Interference with Environment:** When another player stands near a crop or resource node, environmental interaction maintains clear targeting distinction to prevent misclicks.

---

# 30. Control Invariants

The following rules represent immutable requirements for the player control system:

* **PC-I01 — Responsive Locomotion:** Movement must respond immediately on the first frame of input. Sluggishness or input delay is unacceptable.
* **PC-I02 — No Stamina / No Sprint:** Movement speed is never governed by a draining stamina meter or sprint gauge.
* **PC-I03 — Diagonal Velocity Normalization:** Diagonal locomotion velocity must strictly equal cardinal velocity ($\|\vec{v}\| = 1.0$).
* **PC-I04 — Universal Contextual Interaction (E):** `E` is the universal interaction trigger. Distinct actions must not require separate ad-hoc keys.
* **PC-I05 — Facing Direction Preservation:** Stopping movement preserves facing direction; stationary characters never reset to an arbitrary default orientation.
* **PC-I06 — Fixed Isometric Camera:** Camera rotation is strictly disabled in V1.0. The camera maintains one fixed isometric orientation.
* **PC-I07 — Integer Pixel-Art Zoom Safety:** Zoom levels are clamped and tuned to integer pixel scaling to prevent sprite shimmering.
* **PC-I08 — Hidden Grid Invariant:** The tile placement grid is hidden during ordinary exploration and appears only during farming/building.
* **PC-I09 — Soft NPC Collision:** NPCs use soft collision and must never physically trap the player.
* **PC-I10 — Input Abstraction:** Gameplay logic operates exclusively on abstract input actions, never hardcoded hardware key codes.
* **PC-I11 — Action Mutual Exclusivity:** Incompatible player actions (e.g., attacking while reading dialogue) are strictly prevented by the state machine.
* **PC-I12 — Non-Lethal Defeat Continuity:** Defeat disables controls, triggers expedition return to Personal Island, and cleanly restores control without save corruption.

---

# 31. Relationship to Other Specifications

This specification serves as the foundational control layer for:

* **[Farming System Specification (FB-001)](FARMING_SYSTEM_SPECIFICATION.md):** Consumes tile targeting and tool usage activations.
* **[Hunting & Combat System Specification (HU-001)](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md):** Consumes directional attack actions and soft target cones.
* **[Building & Construction System Specification (BI-001)](BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md):** Consumes preview positioning, rotation inputs, and placement confirmation.
* **[Main Island Design Specification (MI-001)](MAIN_ISLAND_DESIGN_SPECIFICATION.md) & [Personal Island Design Specification (PI-001)](PERSONAL_ISLAND_DESIGN_SPECIFICATION.md):** Provide authored navigation boundaries, dock portals, and cottage transition targets.
* **[Engine & Technical Architecture Specification (ETA-001)](ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md):** Governs authoritative state management, simulation step boundaries, and network replication.
* **[Multiplayer & Social Systems Specification (MS-001)](MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md):** Governs social permissions, party mechanics, and multiplayer sessions.

---

# 32. Open Questions

### Blocking Questions (Pending Founder Review):
1. **Primary Action Input Multiplexing:** Does unifying `use_tool`, `attack`, and `confirm_placement` under a single `action_primary` (Left Mouse Button / `F`) that branches on the equipped hotbar slot align with the founder's vision, or should tools and weapons maintain independent primary keybindings?
2. **Ground Item Collection Mechanism:** Should dropped/placed items strictly require manual interaction (`[E] Pick up [Item]`) as currently drafted, or should an optional proximity-based collection model be formally designed when [II-001](MASTER_SPECIFICATION_INDEX.md) is drafted?
3. **Target Cycling Requirement:** Is the automatic Canonical Interaction Targeting Hierarchy (facing cone + proximity) sufficient for all V1 gameplay, or should a dedicated target cycling action (`cycle_target`) be formally reserved in the InputMap?

### Deferred Questions (To be tuned during implementation/playtesting):
1. **Locomotion Tuning Constants:** Final calibration of base velocity, acceleration curves, and friction damping on target hardware.
2. **Camera Look-Ahead Offset:** Exact pixel lead distance during sustained locomotion.
3. **Gamepad Controller Schemes:** Specific button assignments for gamepad controllers when official controller support is implemented.

---

# 33. Definition of Done

PC-001 is considered ready for full Level 1 approval when:

* Founder review confirms resolution of the open blocking questions in Section 32.
* Keyboard direct movement (WASD/Arrows) is fully functional with normalized diagonal velocity.
* Click-to-move is architecturally supported and cleanly overridable by keyboard.
* Absence of stamina and sprint meters is strictly verified.
* 8-directional player facing resolves cleanly and preserves orientation when stationary.
* Universal `E` key triggers contextual interactions via the canonical targeting hierarchy without tool interference.
* Contextual `action_primary` (Left Mouse Button) executes equipped tool actions, attacks, or placement cleanly.
* Tile targeting for farming and ghost preview for building function without permanent grid clutter.
* Ground-footprint collision prevents head clipping on scenery and NPC corner trapping.
* Fixed isometric camera smoothly follows the player with look-ahead, clamped zoom, and zero camera rotation.
* Player state machine enforces mutual exclusivity across all action states.
* World, dock, and interior transitions cleanly disable and restore player controls.
* Non-lethal defeat sequence smoothly returns the player to the Personal Island cottage.
* Input abstraction architecture supports full remapping and future gamepad integration.
* Automated unit and integration tests validate all core invariants.

---

# 34. Final Design Statement

> **The player controller in Underhallow should disappear into the experience. The player should never be thinking about how to manipulate an interface. They should simply think: "I want to walk over there," "I want to harvest that crop," "I want to talk to Rowan," or "I want to explore what lies past that ruined wall." The game should respond immediately, gracefully, and naturally.**
