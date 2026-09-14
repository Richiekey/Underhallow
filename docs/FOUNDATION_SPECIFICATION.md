# 🥕 Underhallow — Foundation Specification V1.0 (Draft)

**Document Status:** Pending Founder / Omni Review & Approval  
**Parent Document:** [Underhallow North Star V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)  
**Authority Level:** Product & System Definition (Layer 2)  
**Target Platform:** Modern Web Browser (Desktop first, Gamepad / Mouse + Keyboard)  
**Target Performance:** 60 FPS, <2s instant load time  

---

## 1. Document Objective
This Foundation Specification translates the visionary principles of **North Star V1.0** into concrete, unambiguous product definitions, gameplay mechanics, mathematical rules, and world systems. It resolves the open items in the V1.0 Decision Register to prepare for the Technical Architecture and Production Phase.

---

## 2. World & Spatial Architecture

### 2.1 Dual-World Topology
Underhallow exists across two distinct world scenes with seamless travel:

```
┌────────────────────────────────────────────────────────┐
│                      MAIN ISLAND                       │
│  - Town Square & Market (Clementine's Shop, Bulletin)  │
│  - Department of Agriculture Regional Branch Office    │
│  - Harbor & Pier (Ferry Skiff to Personal Island)      │
│  - Whispering Woods (Foraging, Wildlife, Hunting)      │
│  - Coastline & Old Watchtower Ruins                    │
└───────────────────────────▲────────────────────────────┘
                            │ Ferry Travel (Instant / Skiff Transition)
┌───────────────────────────▼────────────────────────────┐
│                    PERSONAL ISLAND                     │
│  - Starter Homestead & Rustic Cabin                    │
│  - Agricultural Soil Plot (Tilled, Watered, Planted)   │
│  - Storage Chest & Workbench                           │
│  - 3x3 Macro Sector Grid (Unlockable Expansion Land)   │
│  - Personal Shoreline & Pier                           │
└────────────────────────────────────────────────────────┘
```

### 2.2 Isometric Projection & Coordinate Standard
- **Projection Type:** 2:1 True Dimetric Isometric Projection.
- **Tile Dimensions:** 64px width × 32px height (Base Tile Unit `1.0 TU`).
- **Screen to World Transform:**
  $$\text{screenX} = (x - y) \times (\text{tileWidth} / 2)$$
  $$\text{screenY} = (x + y) \times (\text{tileHeight} / 2) - (z \times \text{tileHeight})$$
- **Depth Sorting (Z-Ordering):**
  Entities sorted each frame by `renderOrder = (tileX + tileY) * 1000 + tileZ * 10 + layerOffset`.
- **Pixel Art Benchmark:** Crisp nearest-neighbor scaling at integer multiples (1x, 2x, 3x zoom levels), 16-bit color warmth, warm amber sunlight transitions, cool misty violet night palettes.

### 2.3 Personal Island Grid Expansion System
- **Macro Layout:** The Personal Island is composed of a **3 × 3 Macro Grid** (9 sectors total).
- **Sector Size:** Each macro sector is **16 × 16 isometric tiles** (overall island = 48 × 48 tiles, 2,304 tiles total).
- **Starting Area:** Sector `(1, 1)` (Central Sector) is unlocked from Day 1, containing the player's cabin, starter crop beds, clearing, and a small water well.
- **Expansion Mechanics:**
  - Surrounding 8 sectors are initially covered by dense mist, overgrown brambles, or ancient stone markers.
  - Unlocking a sector requires:
    1. Gold / Hallows earned through trade.
    2. Specific tools or clearing materials (e.g., clearing wood/boulders).
    3. Progression milestone or Council Land Permit from Town Hall.
  - Unlocking an expansion sector permanently reveals new soil, natural springs, coastal access, or hidden archaeological plots.

---

## 3. The Three Primary Gameplay Pillars

### 3.1 Pillar I: Farming
Farming provides reliable progression, economic capital, and cozy routine.

#### Tile Agricultural States
1. **Virgin Turf / Grass:** Default ground state. Cannot be seeded until tilled.
2. **Tilled Soil (Dry):** Created by using the Hoe. Decays back to turf after 48 in-game hours if unplanted.
3. **Tilled Soil (Watered):** Created by using the Watering Can. Accelerates growth tick. Reverts to dry at midnight.
4. **Planted Seed:** Seed placed onto tilled soil.
5. **Growth Stages (1 to 4):**
   - *Stage 1: Germination (Sprout)*
   - *Stage 2: Vegetative Growth*
   - *Stage 3: Flowering / Fruiting*
   - *Stage 4: Mature / Harvestable*
6. **Harvested / Regrowth:** Single-harvest crops return to tilled soil; multi-harvest crops (e.g., Berry Bushes) revert to Stage 2.
7. **Withered / Anomalous:** Neglected without water for >3 consecutive days, or exposed to rare night fog anomalies.

#### Core Farming Tool Arsenal
- **Rusty Hoe:** Tills soil tiles (1x1 target). Upgradable to Copper (1x3), Iron (3x3).
- **Watering Can:** Holds 20 charges. Refillable at wells, ponds, or coast.
- **Seed Satchel:** Quick-select active seeds with plant preview overlay.
- **Harvest Sickle / Bare Hands:** Quick harvest with satisfying bounce and particle pop.

---

### 3.2 Pillar II: Hunting & Foraging
Hunting provides adventure, risk/reward, raw crafting resources, and exploration incentives outside the farm.

#### Encounter & Creature Ecosystem
- **Tier 0 Critters (Passive):**
  - Island Rabbits, Meadow Quails, Forest Squirrels.
  - Behavior: Flee upon player approach within 4 tiles.
  - Interaction: Slingshot or stealth trapping. Yields meat, pelts, feathers.
- **Tier 1 Wildlife (Neutral / Defensive):**
  - Bristle Boars, Badger Badasses.
  - Behavior: Ignore player unless provoked or entered territorial proximity (<2 tiles).
  - Combat: Simple charge attack with telegraphed visual dust wind-up.
  - Yields: Heavy hides, bones, rare truffles.
- **Tier 2 Anomalous Creatures (Mysterious / Nocturnal):**
  - Bramble Lurkers, Luminous Wisps (appear deep in Whispering Woods or at night).
  - Behavior: Evasive, pattern-based, dropped strange alchemical seeds and glowing residue.

#### Combat Mechanics Specification
- **Design Rule:** Approachable, rhythmic, non-punishing. Underhallow is NOT a twitch soulslike.
- **Actions:**
  - `Attack` (Tool/Weapon: Wooden Spear, Hunter's Bow, Slingshot, or Forager Knife).
  - `Dodge / Step-Back` (Short dash with 0.2s invulnerability frames to avoid telegraphed swings).
- **Health & Stamina:**
  - Stamina consumed by sprinting, tilling, chopping, and heavy attacks.
  - When Health hits 0: Player does NOT die permanently. The player faints, losing some energy, and wakes up at the Town Clinic or their Cottage bed next morning with a note from Clementine or the local Doctor.

---

### 3.3 Pillar III: Building & Customization
Building transforms the player's personal island into an intimate, distinctive personal sanctuary.

#### Placement Engine & Rules
- **Grid Snapping:** Clear green/red footprint indicator on isometric tiles.
- **Placement Categories:**
  1. **Surfacing & Paths:** Dirt trail, Cobblestone, Wood decking, Stepping stones.
  2. **Enclosures:** Rustic picket fence, Stone wall, Garden hedges, Gates.
  3. **Outdoor Furnishings & Deco:** Benches, Lanterns (dynamic light emission), Flower pots, Scarecrows, Tool racks.
  4. **Functional Outbuildings:**
     - *Tool Shed:* Expanded inventory storage.
     - *Drying Rack / Preserves Jar:* Processes raw crops into artisanal goods.
     - *Chicken Coop / Small Barn:* Animal husbandry (Tier 2 progression).
  5. **Cottage Expansion:** Expands interior floor plan, roof style, and exterior facade.

---

## 4. World Geography & Town Life

### 4.1 Main Island Districts
1. **Town Square:**
   - Central cobblestone plaza with fountain and bulletin notice board.
   - **Clementine's General Store & Bakery:** Sells starter seeds, flour, coffee, and daily baked goods. Buys fresh produce.
   - **The Department of Agriculture Field Office:** Imposing, slightly too formal government office with filing cabinets, bureaucratic paperwork, and official crop quota inquiries.
   - **Blacksmith & Carpenter:** Tool upgrades and structural blueprints.
2. **Harbor & Fishmarket:**
   - Wooden docks where Barnaby the Ferryman docks his tugboat.
   - Direct travel link to the player's Personal Island.
   - Fishing pier and tidal foraging.
3. **Whispering Woods:**
   - Dense canopy, winding dirt paths, ancient mossy stones, hunting grounds, wild berry patches.
   - Deeper trails blocked by fallen timbers or old departmental warning signs.

---

## 5. Narrative Architecture & The Mystery Layer

### 5.1 Dual-Tone Execution
Underhallow deliberately balances two emotional registers:
- **Surface Layer:** Warm, comforting, humorous, satisfying daily routine.
- **Underlying Mystery:** Strange memos, soil that whispers or hums during rainstorms, crops that grow with unnatural symmetry, NPCs who evade questions about why the mainland ferries stopped coming.

### 5.2 Key Narrative Cast (Foundation Group)
- **Clementine:** Warm-hearted, generous local shopkeeper. Secretly worried about supply shipments that haven't arrived in months.
- **Officer Vance (Dept. of Agriculture):** Clipboards, stamped permits, polite smiles. Insists everything is strictly routine and according to Directive 44-B.
- **Robinhood:** Reclusive trapper living in a ramshackle hut in the Whispering Woods. Knows the forest secrets and talks about "the things beneath the roots."
- **Barnaby:** Old sea captain running the ferry skiff. Tells stories of the sea and the forgotten history of Underhallow.

---

## 6. Economy, Progression, and Core Loop

### 6.1 Economy Fundamentals
- **Currency:** Gold Coins (`G`).
- **Primary Earn Loops:**
  - Selling high-quality crops.
  - Selling gathered pelts, timber, and forage items.
  - Fulfilling daily town bulletin requests.
- **Primary Sink Loops:**
  - Purchasing seeds, fertilizers, blueprints, and livestock.
  - Purchasing island expansion sector permits.
  - Tool upgrades (Copper, Iron, Steel).

### 6.2 Day/Night Cycle & Time Flow
- **Ratio:** 1 real-world minute = 1 in-game hour (Full 24-hour cycle = 24 real minutes).
- **Day Schedule:**
  - `06:00 AM`: Morning rooster, day start, crops update growth stage.
  - `12:00 PM`: Midday market bell.
  - `06:00 PM`: Sunset, dusk lighting, shops close, tavern opens.
  - `10:00 PM`: Nightfall, ambient lanterns ignite, nocturnal fauna active.
  - `02:00 AM`: Exhaustion warning if player has not slept in bed.

---

## 7. Recommended Technical Architecture (Browser-First)

### 7.1 Core Technology Stack
- **Language & Tooling:** TypeScript + Vite (fast HMR, lightweight bundle, zero runtime bloat).
- **Rendering Pipeline:**
  - Dedicated **2D Canvas / WebGL Isometric Renderer** with integer scaling for pixel-art clarity.
  - Texture atlas sprite packing for low memory footprint and high cache efficiency.
  - Smooth 60 FPS fixed-timestep game loop (`1/60s` physics/logic tick + interpolated render tick).
- **Architecture Pattern:** Decoupled Model-View:
  - `Simulation / State Machine`: Pure TypeScript game logic (inventory, grid, farming ticks, time). Purely deterministic and serializable.
  - `Render System`: Reads state and draws isometric sprites, animations, and particle effects.
  - *Benefit:* Ensures that when multiplayer is added in the future, the state simulation is already completely decoupled from rendering!
- **Persistence:** IndexedDB with JSON schema migration for instant local saving, auto-saving every in-game morning, and export/import capability.
- **Input System:** Unified Input Manager supporting:
  - Keyboard: `WASD` / Arrow movement, `E` interact, `Space` use tool, `1-8` hotbar select, `Tab` inventory.
  - Mouse: Tile hover cursor with isometric diamond highlight, left click action, right click context.
  - Gamepad: Analog stick movement, button mappings.

---

## 8. Milestone 1 Production Roadmap: "The First Playable Loop"

In direct fulfillment of **Section 34 of the North Star**:
```
Enter the world ──► Explore Main Island ──► Discover Town ──► Meet NPC
         │
         ▼
Receive objective ──► Gather / Explore ──► Travel to Personal Island
         │
         ▼
Farm (Till/Water/Plant) ──► Harvest ──► Build / Customize ──► Return to Town
```

### Production Slices:
1. **Slice 1 — Engine & Isometric Foundations:**
   - 2:1 Isometric grid math, camera viewport with smooth scrolling, player entity with 8-direction/4-direction pixel movement and collision.
2. **Slice 2 — Personal Island & Farming System:**
   - Starter island grid, tool mechanics (Hoe, Watering Can, Carrot Seeds), soil state transitions, crop growth timer, harvesting into inventory.
3. **Slice 3 — Harbor & Dual-Island Navigation:**
   - Travel interaction at dock, scene transition between Personal Island and Main Island Town Square.
4. **Slice 4 — Town Square & NPC Dialogue:**
   - Clementine's store, dialogue system with portrait modal, buying seeds and selling harvested crops.
5. **Slice 5 — Building & Foraging Slice:**
   - Path/fence tile placement on Personal Island; forest perimeter with basic gatherables and critter interaction.
6. **Slice 6 — Polish & Human QA Playtest:**
   - Audio effects, cozy color grading, UI polish, verifying the first loop feels undeniably fun and distinctly *Underhallow*.

---

## 9. Next Steps & Approvals
Upon Founder / Omni approval of this Foundation Specification:
1. Lock Foundation Specification V1.0.
2. Draft **Technical Architecture Specification (Layer 3)** with exact engine interfaces and data schemas.
3. Establish project codebase repository structure and commence Slice 1 implementation.
