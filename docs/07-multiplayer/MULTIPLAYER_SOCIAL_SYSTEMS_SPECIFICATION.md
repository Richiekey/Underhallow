# Underhallow

## Multiplayer & Social Systems Specification V1.0

**Document ID:** MS-001  
**Version:** V1.0  
**Status:** DRAFT  
**System Level:** Level 2 — Cross-Cutting Gameplay & Social System  
**Classification:** Core World System (Social & Community Infrastructure)  
**Parent Specifications:**
* [North Star V1.0 (NS-001)](../01-product/NORTH_STAR.md)
* [Foundation Specification V1.0 (FS-001)](../01-product/FOUNDATION_SPECIFICATION.md)
* [Specification Reconciliation V1.0 (SR-001)](../00-governance/SPECIFICATION_RECONCILIATION.md)
* [Engine & Technical Architecture Specification V1 (ETA-001)](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)
* [Core Gameplay Systems Specification V1.0 (CG-001)](../03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](../03-gameplay/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)
* [World & Map Architecture Specification V1.0 (WM-001)](../04-world/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Player Progression Specification V1.0 (PR-001)](../03-gameplay/PLAYER_PROGRESSION_SPECIFICATION.md)
* [Farming System Specification V1.0 (FB-001)](../03-gameplay/FARMING_SYSTEM_SPECIFICATION.md)
* [Hunting & Combat System Specification V1.0 (HU-001)](../03-gameplay/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md)

---

# 1. Purpose

The **Multiplayer & Social Systems Specification** defines how players connect, collaborate, communicate, organize, share spaces, and interact within Underhallow.

Per [CG-001 §4](../03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md), Social & Multiplayer is a **Core World System** providing cross-pillar community, co-op, trade, and shared-space infrastructure that allows players pursuing any lifestyle pillar to connect and collaborate.

In accordance with the foundational directives established in `NS-001`, `SR-001`, and `ETA-001`, Underhallow is:

> **A single-player-first, multiplayer-native cooperative RPG and life-simulation game.**

Multiplayer in Underhallow is neither an isolated game mode nor a second-class after-thought. It is a cross-cutting architecture that natively extends every primary lifestyle pillar (Farming, Hunting, Gathering, Crafting, Building, Exploration, and Trading) from a solo endeavor into a shared social reality.

This specification sets forth the comprehensive rules, networking behaviors, state ownership models, permission structures, and social mechanics governing:
* Player sessions and instance routing.
* Parties (4–6 players).
* Guilds (~50 members) and guild hierarchy.
* Guild Islands and communal infrastructure.
* Cross-island visitation and granular permission matrices.
* Cooperative farming, shared hunting, and world events.
* Secure player-to-player direct trading and market escrow.
* Text communication channels and player presence.
* Disconnect tolerance, reconnect grace windows, and anti-griefing safety.

---

# 2. Design Goals

1. **Single-Player Autonomy (The Zero-Compulsion Invariant):** Every system must remain 100% complete, functional, and deeply rewarding for a player who never joins a party or a guild. Multiplayer is an invitation, never a tax or prerequisite.
2. **Cozy, Low-Friction Cooperation:** Joining a friend, tending their crops, tracking creatures together, or building a guild hall must feel effortless, natural, and free of toxic competition.
3. **Ironclad State Ownership:** Clear lines of demarcation between personal assets and communal assets. A visitor can never steal crops or tear down structures without explicit, cryptographically verifiable server authorization.
4. **Server-Authoritative Fairness:** The dedicated game server decides all gameplay mutations (damage, loot drops, inventory changes, crops watered, items transferred). Clients request; servers validate.
5. **Resilient Social Continuity:** Disconnections, client crashes, or momentary latency spikes must not destroy party progress, wipe pending trades, or strand players in hostile territory.
6. **Community Permanence:** Guilds and Guild Islands provide enduring foundations for long-term player groups to build monuments, communal farms, and shared histories.

---

# 3. Non-Goals

1. **No Open-World Non-Consensual PvP:** Underhallow V1 does not feature open-world player killing, crop raiding, grief looting, or hostile territory conquest. The world is a shared haven, not a battlefield against other players.
2. **No Mandatory Group Gating:** No main story quests, core tool recipes, crop seeds, or vital hunting progression paths may require a multiplayer party or guild to unlock or complete.
3. **No Unbounded Mega-Servers (MMO Clustering):** Underhallow uses instanced dedicated servers and regional world instances, not a single monolithic million-player grid. Zone caps are carefully scaled to preserve coziness and performance (PC target 60 FPS).
4. **No Real-Time Voice Chat in V1:** Built-in spatial or party VoIP is deliberately deferred to avoid platform overhead and complex audio moderation in V1. High-fidelity text chat with multiple targeted channels is the authoritative communication standard.
5. **No Client-Authoritative Economic Mutations:** Clients never broadcast "I picked up item X" or "I gave gold Y" directly to peers. All transactions route through dedicated server validation and Supabase persistence.

---

# 4. Social & Ownership Hierarchy

Underhallow organizes game state and social agency into four clearly nested tiers:

```text
┌───────────────────────────────────────────────────────────────────┐
│                           LEVEL 4: WORLD                          │
│  Shared Public Regions (Main Island / Towns / Public Dungeons)    │
│  Public Expeditions, Seasonal Festivals, Global Marketplace Hub   │
└─────────────────────────────────┬─────────────────────────────────┘
                                  │
┌─────────────────────────────────▼─────────────────────────────────┐
│                           LEVEL 3: GUILD                          │
│  Guild Island, Guild Bank, Guild Projects, Communal Farms         │
│  Guild Progression Perks, Crest, Ranks & Permissions (~50 max)    │
└─────────────────────────────────┬─────────────────────────────────┘
                                  │
┌─────────────────────────────────▼─────────────────────────────────┐
│                           LEVEL 2: PARTY                          │
│  Temporary Group (4–6 players), Expedition Tethering, Shared XP   │
│  Party Chat, Encounter Scaling, Revive Link, Compass Blips        │
└─────────────────────────────────┬─────────────────────────────────┘
                                  │
┌─────────────────────────────────▼─────────────────────────────────┐
│                          LEVEL 1: PLAYER                          │
│  Character Identity, Progression Tree, Personal Inventory         │
│  Personal Island, Homestead, Private Storage, Unlocked Recipes    │
└───────────────────────────────────────────────────────────────────┘
```

### 4.1 Invariant Ownership Rules
1. **Personal Island Sovereign Rule:** A player's Personal Island belongs exclusively to that player account. Other players cannot access it unless granted permission by the owner or invited via an active party session.
2. **Guild Island Communal Rule:** A Guild Island belongs to the guild entity. Individual contributions (donated materials, constructed buildings) become communal assets governed by guild permissions unless located on designated Personal Plots.
3. **Personal Inventory Sovereign Rule:** Items in a player's backpack or personal lockbox cannot be accessed, moved, or deleted by any other player, party leader, or guild officer.

---

# 5. Session Architecture & Server Routing

Underhallow uses Godot dedicated headless servers combined with Supabase for authentication and persistent storage (`ETA-001`).

```text
┌────────────────┐     WebSocket / REST     ┌─────────────────────┐
│  Godot Client  ├─────────────────────────►│  Supabase Services  │
│  (Windows PC)  │   Auth, Profile, Social  │  Auth, DB, Storage  │
└───────┬────────┘                          └──────────┬──────────┘
        │                                              │
        │ Godot High-Level ENet / WebRTC               │ Database Sync
        ▼                                              ▼
┌─────────────────────────────────────────────────────────────────┐
│              Dedicated Underhallow Game Server                  │
│  - Authoritative World Simulation (GameTime, Crops, AI, Spawns) │
│  - Zone Instance Coordinator (Main Island, Personal, Guild)     │
│  - Party & Guild State Manager                                  │
│  - Security, Validation & Anti-Cheat Logic                      │
└─────────────────────────────────────────────────────────────────┘
```

### 5.1 Connection Lifecycle
1. **Authentication:** The client authenticates against Supabase Auth, obtaining a secure JWT and player UUID.
2. **Session Handshake:** The client contacts the Game Server Gateway with its token and character ID. The server validates credentials, loads player persistent records, and determines target spawn destination.
3. **Zone Allocation:**
   * **Personal Island:** Spawned on an instanced server node.
   * **Guild Island:** Spawned on the persistent guild instance node.
   * **Main Island / Public Zones:** Spawned in the player's assigned public region shard (capacity 32–48 concurrent players per shard).
4. **Heartbeat & Keepalive:** The client and server exchange UDP keepalive packets at 20 Hz tick rates. A missing heartbeat triggers a graceful disconnect countdown.

---

# 6. Party System (4–6 Players)

The party is the primary temporary social unit for cooperative activities, hunting expeditions, dungeon crawls, and social farming visits.

### 6.1 Party Parameters
* **Maximum Size:** 4 players baseline (expandable to 6 players via high-tier Guild Perk / Campfire Feast upgrades).
* **Duration:** Dynamic session-based. Disbands when all members leave or the leader dissolves it.
* **Formation Methods:**
  * Direct radial menu invite on nearby player (`E` interaction).
  * Targeted chat invite (`/invite PlayerName`).
  * Friend list contextual invite from UI.
  * Guild roster contextual invite.

### 6.2 Party Roles & Leadership
| Role | Authority & Responsibilities |
| :--- | :--- |
| **Party Leader** | Invites new members, removes members, transfers leadership, sets loot distribution rules, initiates cross-zone party travel, places map waypoints. |
| **Party Member** | Accepts/declines invites, views shared party status, speaks in Party Chat, sees shared waypoints, participates in group combat scaling. |

### 6.3 Party UI & Presence
When grouped, each player's HUD displays the Party Widget:
* **Member Nameplate:** Character portrait, current Health bar, active buffs/debuffs.
* **Location Indicator:** Zone name (e.g., "Personal Island", "Whispering Ridge").
* **Proximity Status:** In Range (<50m), Out of Range (>50m), Different Zone, or Disconnected.
* **Compass & Map Blips:** Color-coded icons on the compass ring and mini-map showing party member positions and orientation.

---

# 7. Party Shared Activities & Synchronization

### 7.1 Cross-Zone Rallying & Fast Travel
* **The Whistle / Beacon Call:** When a party leader enters an expedition gate or dungeon portal, a prompt appears on all party members' screens: *"Party Leader has entered [Dungeon/Zone]. Travel together?"* (Accept / Decline).
* **Rallying Campfire:** Deployable camping item that allows party members in the same region to fast-travel to the campfire position once every 15 minutes of real time, provided the player is out of combat.

### 7.2 Proximity Tethering & Shared Aura
* Players within **30 meters** of at least one party member receive the **"Camaraderie"** passive buff (+5% movement speed, +5% bonus tracking focus generation).
* Camping, cooking, and sleeping near a party campfire accelerate health recovery and provide shared well-rested buffs for the next expedition.

---

# 8. Party Loot & Reward Distribution

To preserve the cozy, non-toxic ethos of Underhallow, **loot ninja behavior is mathematically impossible**.

### 8.1 Loot Distribution Models
The party leader selects the loot rule prior to engaging encounters:

| Loot Rule | Mechanism | Best Used For |
| :--- | :--- | :--- |
| **Instanced Personal Drops (Default)** | Every party member sees and loots their own private drop pile from harvested creatures, nodes, and chests. Player A's loot cannot be seen or touched by Player B. | Standard expeditions, casual hunting, farming visits. |
| **Round-Robin Rolling** | Rare materials or equipment dropped by major bosses trigger a 30-second on-screen roll prompt: **Need / Greed / Pass**. Highest roll wins item directly to inventory; tie-breaks resolved by server RNG. | High-tier guild expeditions, rare trophy hunting. |
| **Shared Harvest Bonus** | When hunting creatures or felling large grove trees, all players who actively dealt damage, applied debuffs, or contributed tracking clues within the encounter receive 100% of standard harvest materials plus a +10% "Co-op Synergy" bonus yield. | Cooperative creature hunts and grove felling. |

### 8.2 Anti-Parasite (AFK Leech) Rule
To prevent passive leeching:
* A player must have participated in the encounter (dealt damage, taken damage, applied support buffs, or contributed tracking pings within 60 seconds) and be within **80 meters** of the encounter location to qualify for boss loot rolling or shared quest credit.

---

# 9. Guild System (~50 Members)

Guilds represent the enduring social and economic backbone of Underhallow's cooperative world.

### 9.1 Founding & Charter Requirements
1. **Founder Level:** Character must be Progression Tier 3 (Journeyman) or higher.
2. **Founding Cost:** 10,000 Gold + 50 Hardwood + 50 Stone Bricks.
3. **Charter Signatures:** Requires 3 online player signatures (Founder + 2 founding members in a party) at the Town Hall Registry on the Main Island.
4. **Naming & Identity:**
   * Guild Name: 3 to 24 alphanumeric characters (profanity-filtered, server-unique).
   * Guild Tag: 3 to 5 characters, displayed as `[TAG] PlayerName`.
   * Heraldry: Custom crest designer with 32 emblems, 16 background patterns, and 24 color swatches.

### 9.2 Guild Scale & Cap
* **Base Capacity:** 30 members.
* **Expanded Capacity:** Up to 50 members maximum through Guild Progression unlocks (Milestone 3). Capped at 50 to maintain cohesive, intimate community culture rather than anonymous zerg clans.

---

# 10. Guild Ranks & Permissions Matrix

Underhallow features a comprehensive 5-tier role hierarchy with customizable operational permissions.

| Permission Flag | Guild Master | Officer | Veteran | Member | Recruit |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Manage Guild Info / Crest** | Yes | No | No | No | No |
| **Promote / Demote Members** | Yes | Yes (Below Officer) | No | No | No |
| **Invite / Kick Members** | Yes | Yes | No | No | No |
| **Withdraw from Guild Bank** | Unlimited | Daily Cap (5k Gold) | Daily Cap (1k Gold) | Items Only | No |
| **Deposit to Guild Bank** | Yes | Yes | Yes | Yes | Yes |
| **Place / Demolish Guild Buildings** | Yes | Yes | Place Only | No | No |
| **Harvest Communal Guild Crops** | Yes | Yes | Yes | Yes | Permission Only |
| **Plant Communal Guild Crops** | Yes | Yes | Yes | Yes | Yes |
| **Manage Island Visitor Access** | Yes | Yes | No | No | No |
| **Trigger Guild Research Upgrades** | Yes | Yes | No | No | No |
| **Declare Guild Expeditions** | Yes | Yes | Yes | No | No |

---

# 11. Guild Bank & Vault Storage

The Guild Bank is an instanced communal vault located inside the Guild Hall on the Guild Island and accessible via a branch teller on the Main Island.

### 11.1 Structure & Tabs
* **Storage Tabs:** Starts with 2 tabs (48 slots each); expandable to 6 tabs (288 slots total) through guild research.
* **Specialized Categorization:** Tabs can be custom-named and icon-tagged (e.g., "Seeds & Fertilizer", "Crafting Wood & Ore", "Cooked Rations", "Rare Hunting Trophies").
* **Guild Treasury:** Shared currency vault for Gold and Guild Tokens.

### 11.2 Access Controls & Daily Quotas
* Officers can configure per-rank daily withdrawal limits for both items (e.g., maximum 5 items/day for Members) and Gold (e.g., 500 gold/day).
* High-value items (Tier 4+ gear, rare relics) can be locked with an **"Officer Approval Required"** flag, requiring an online Officer or Guild Master to approve withdrawal requests via an in-game queue.

### 11.3 Audit Logging
The server maintains an append-only audit log of the last 500 Guild Bank transactions:
* Timestamp (`GameTime` + Real-world UTC).
* Member ID and Name.
* Action (Deposit, Withdraw, Move).
* Item ID, Stack Size, and Quality rating.
* Gold amount added or removed.

---

# 12. Guild Progression & Research Milestones

Guilds progress collectively by depositing resources, completing communal bounty boards, and conducting guild hunting expeditions.

```text
┌─────────────────────────────────────────────────────────────────┐
│                    GUILD PROGRESSION TIERS                      │
├─────────┬───────────────────────────────────────────────────────┤
│ TIER 1  │ Guild Charter, 30 Member Cap, Guild Hall Foundation,  │
│ (Settler)│ 2 Bank Tabs, Basic Communal Farm (64 tiles).         │
├─────────┼───────────────────────────────────────────────────────┤
│ TIER 2  │ 40 Member Cap, 4 Bank Tabs, Windmill & Silo Projects, │
│ (Builder)│ Guild Trophy Workshop, +5% Communal Crop Growth.     │
├─────────┼───────────────────────────────────────────────────────┤
│ TIER 3  │ 50 Member Cap, 6 Bank Tabs, Guild Island Harbor Dock, │
│(Preserver) Communal Forge, Guild Expedition Rally Portal,       │
│         │ +10% Hunting Group XP, 6-Player Party Size Cap.       │
└─────────┴───────────────────────────────────────────────────────┘
```

* **No Pay-to-Win:** Guild research provides convenience, communal aesthetics, expanded shared storage, and minor cooperative synergy buffs. It never provides disproportionate combat stats or unfair market monopolies.

---

# 13. Guild Islands & Communal Architecture

As established in `WM-001` and `SR-001`, each guild unlocks a persistent, instanced **Guild Island** separate from players' Personal Islands.

### 13.1 Spatial Layout & Zones
1. **The Harbor & Welcome Plaza:** Arrival point for visiting guild members and invited guests. Contains bulletin board, travel boat, and mail courier.
2. **The Guild Hall:** Central monument building housing the Guild Bank, War Room / Expedition Map, trophy pedestals, and guild crafting benches.
3. **Communal Farm Fields:** Dedicated tilling grids (up to 256 tiles) designed for large-scale cooperative agriculture.
4. **Communal Workshops:** Tiered processing facilities (Sawmill, Smelter, Tannery, Preserves Jar cluster) that process bulk guild resources.
5. **Personal Plot Quarter:** Dedicated residential sectors where members can be assigned private plots to decorate and build personal homesteads on the guild island.

### 13.2 Construction Permissions & Blueprints
* Guild projects use a **"Contribution Blueprint"** mechanic. An Officer places a transparent ghost footprint for a structure (e.g., Communal Greenhouse).
* Any guild member can approach the ghost footprint and deposit required materials (e.g., 200 Timber, 100 Glass, 50 Nails).
* Once 100% of materials are contributed, the blueprint enters an assembly timer or allows any member with a Hammer tool to complete construction animations.

---

# 14. Personal Plots on Guild Islands

To allow members to feel invested in their communal home, Guild Islands feature modular residential parcels:
* **Plot Dimensions:** Standard 16x16 tile plots (up to 20 plots per island).
* **Assignment Authority:** Granted by Guild Master or Officer to a specific member.
* **Plot Rights:** The assigned member has full Personal Island building rights inside their plot boundary (can place personal furniture, beds, and decorative items).
* **Departure & Eviction Protocol:**
  * If a member leaves or is removed from the guild, their plot structures remain intact for a **7-day Grace Period**.
  * The evicted member can visit the Harbor to claim all personal items from an **Eviction Retrieval Chest**.
  * After 7 days, the plot is automatically cleared, and remaining personal items are routed to the player's Main Island Mailbox.

---

# 15. Cross-Island Travel & Visitation

Players navigate between worlds using the **Travel Harbor** and skiff boat NPCs:

```text
                        ┌───────────────────┐
                        │    MAIN ISLAND    │
                        │  (Town / Harbor)  │
                        └─────────▲─────────┘
                                  │
                 ┌────────────────┼────────────────┐
                 ▼                                 ▼
        ┌──────────────────┐             ┌──────────────────┐
        │ PERSONAL ISLAND  │◄───────────►│   GUILD ISLAND   │
        │  (Player Owned)  │   Direct    │  (Guild Owned)   │
        └──────────────────┘  Travel     └──────────────────┘
                 ▲
                 │
                 ▼
        ┌──────────────────┐
        │  FRIEND ISLAND   │
        │(Visitor Access)  │
        └──────────────────┘
```

### 15.1 Island Access Control Rules
Before a player can board a skiff to another player's island, the server verifies access rights:
* **Personal Island Privacy Settings:**
  * **Private (Default):** Only the owner can enter.
  * **Party Only:** Current party members can enter while the owner is online and on the island.
  * **Friends:** Anyone on the player's friend list can visit.
  * **Open Passcode:** Any player who enters a 4-digit code provided by the owner can visit.
* **Guild Island Access:** Open to all guild members at all times. Non-guild visitors require an invitation from an online member or an "Open Island Open House" event active.

---

# 16. Island Granular Permission Matrix

To prevent griefing while encouraging genuine help, Underhallow enforces a granular role-based permissions matrix for all property interactions:

| Action Category | Owner | Trusted / Co-Owner | Guild Member | Party Guest | Public Visitor |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Walk & Explore** | Yes | Yes | Yes | Yes | Yes |
| **Water Crops** | Yes | Yes | Yes | Yes | No |
| **Fertilize Crops** | Yes | Yes | Yes | No | No |
| **Plant Seeds** | Yes | Yes | Designated Plots | No | No |
| **Harvest Mature Crops** | Yes | Yes | Designated Plots | Option-Locked | No |
| **Till / Dig Soil** | Yes | Yes | No | No | No |
| **Chop / Mine Decor Trees/Rocks**| Yes | Yes | No | No | No |
| **Place Buildings / Furniture** | Yes | Yes | Personal Plot | No | No |
| **Demolish Structures** | Yes | No | No | No | No |
| **Access Storage Chests** | Yes | Assigned Chests | Communal Only | No | No |
| **Pet / Feed Livestock** | Yes | Yes | Yes | Yes | No |

* **Option-Locked Harvest:** By default, guests cannot pick up harvested crops. If the owner enables "Co-Op Farm Day" mode, harvested crops automatically enter a shared basket or split evenly among participants.

---

# 17. Cooperative Farming System

Farming cooperatively with friends or guildmates is designed to be joyful, efficient, and grief-free.

### 17.1 Assisting & Work Sharing
* **Watering Assistance:** When a friend or party member waters your tilled plots, the water hydration duration lasts **1.5x longer** than standard, rewarding social teamwork.
* **Multi-Tile Tilling & Sowing:** Two players tilling adjacent tiles trigger a visual sync particle ("Teamwork!") that grants +10% tool animation speed.
* **Shared Fertilizer Application:** Players can contribute specialized fertilizers to friends' crops to boost quality tiers without overwriting crop ownership metadata.

### 17.2 Crop Ownership & Harvest Resolution
* Every growing crop on a tile stores:
  ```json
  {
    "tile_index": 142,
    "crop_id": "crop_spectral_pumpkin",
    "planter_id": "uuid-player-1",
    "island_owner_id": "uuid-player-1",
    "growth_stage": 4,
    "quality_tier": "gold",
    "assisted_by": ["uuid-player-2"]
  }
  ```
* When harvested by an authorized helper, the harvest yields standard crops directly into the island owner's Silo/Chest, while the helper receives:
  * 15% bonus yield directly in their backpack as a **"Neighborly Tithe"**.
  * Farming Mastery XP.
  * +1 Social Karma Token.

### 17.3 Offline Simulation & State Catch-Up
In accordance with Invariant 9, `ETA-001`, and `TS-001`:
* Communal crops and personal farm grids simulate deterministically against authoritative `GameTime`.
* When an island instance is unloaded or all members are offline, real-time tick accumulation pauses on the server. Upon any player loading the island, the server executes a fast-forward catch-up calculation for all elapsed `GameTime` hours, maturing crops and updating water depletion without requiring active 24/7 background CPU simulation.


---

# 18. Cooperative Hunting & Combat Mechanics

Hunting together combines tracking, strategy, threat coordination, and tactical creature engagement.

### 18.1 Shared Tracking & Clue Discovery
* When a party member discovers a creature trail (paw prints, broken branches, fresh droppings), examining it with the magnifying glass / tracking tool reveals the trail to **all party members** within 60 meters.
* The creature's silhouette and direction of travel appear highlighted on all party members' screens.

### 18.2 Threat & Aggro Distribution
Creatures in Underhallow utilize a multi-factor threat model:
* **Damage Factor:** Direct hits build standard threat.
* **Proximity & Position Factor:** Creatures prioritize players who corner them or block their escape path.
* **Noise & Tool Clatter:** Loud actions (traps snapping, firearms, heavy swings) pull immediate visual attention.
* **Flanking Synergy:** If Player A maintains the creature's frontal attention, Player B attacking from the rear flank deals **+20% stagger damage**, encouraging tactical positioning.

### 18.3 Downed State & Resuscitation (Non-Lethal Defeat Invariant)
In accordance with `HU-001` and Invariant 6 (Non-Lethal Defeat):
* When a player's health drops to zero during a cooperative expedition:
  1. The player enters a **Downed State** (crawling at 30% speed, cannot attack, 60-second bleedout timer).
  2. Any party member can approach and hold `E` for 4 seconds to **Revive** them, restoring 35% health.
  3. If all party members are downed simultaneously, or the bleedout timer expires with no one nearby:
     * The party suffers an **Expedition Defeat**.
     * All players are rescued by the Island Wardens and returned to the Harbor Infirmary.
     * Temporary resources gathered during the current expedition run are lost, but permanent gear, equipped tools, and island progression are **NEVER lost**.

---

# 19. Direct Player Trading System

Players can engage in secure, synchronous peer-to-peer trades when standing in proximity.

```text
┌────────────────────────────────────────────────────────┐
│                   DIRECT TRADE WINDOW                  │
├──────────────────────────┬─────────────────────────────┤
│      MY OFFERING         │       THEIR OFFERING        │
│  [Item Slot 1] x5        │  [Item Slot 1] x1           │
│  [Item Slot 2] x1        │  [Item Slot 2] x50          │
│  [Item Slot 3] (Empty)   │  [Item Slot 3] (Empty)      │
│  Gold: 1,500             │  Gold: 0                    │
├──────────────────────────┼─────────────────────────────┤
│  [x] LOCK OFFER          │  [x] LOCKED BY PARTNER      │
│  [   ACCEPT TRADE   ]    │  [   ACCEPT TRADE   ]       │
└──────────────────────────┴─────────────────────────────┘
```

### 19.1 Secure Two-Step Escrow Protocol
1. **Initiate:** Player A selects "Trade" on Player B. Player B receives prompt and accepts. Both players enter a locked movement state within 5 meters.
2. **Stage 1 (Item Staging):** Both players drag items and input gold into their respective trade matrices (up to 8 item slots each).
3. **Stage 2 (Lock Offer):** Both players must click **"Lock Offer"**. Once locked, no items can be added, removed, or altered.
4. **Stage 3 (Mutual Acceptance):** Both players must click **"Accept Trade"**. If either player alters their offer before locking, both locks automatically disengage.
5. **Anti-Scam Delay:** If an offer is changed right before locking, a **3-second safety cooldown** prevents immediate acceptance.
6. **Server Atomic Execution:** The server validates inventory capacity on both sides, deducts items simultaneously, deposits items simultaneously, and commits the transaction atomically. If either side lacks inventory space, the trade aborts with a clear descriptive error.

---

# 20. Marketplace & Mailbox Integration

For asynchronous trading between players who are offline or in different instances:
* **The Main Island Auction House / Exchange:** Physical kiosk in the central marketplace where players can list items for sale.
* **Listing Duration:** 24, 48, or 72 real-world hours.
* **Listing Fee:** 3% non-refundable gold fee to prevent marketplace spam and artificial inflation.
* **Sales Tax:** 5% cut deducted upon successful sale.
* **Delivery via Courier Mailbox:** Purchased items and collected gold profits are delivered via persistent in-game mail to the recipient's homestead mailbox.

---

# 21. In-Game Chat & Communication Architecture

Underhallow features a lightweight, high-performance text communication framework.

### 21.1 Chat Channels
| Channel | Command | Scope & Visibility | Default Color |
| :--- | :---: | :--- | :--- |
| **Say (Proximity)** | `/s` or Enter | Players within 25 meters in same instance | #FFFFFF (White) |
| **Yell (Area)** | `/y` | Players within 100 meters in same instance | #FF5555 (Light Red) |
| **Party** | `/p` | All party members across all instances | #55FF55 (Light Green) |
| **Guild** | `/g` | All online guild members across all servers | #55FFFF (Cyan) |
| **Direct Message** | `/w [name]` | Target player private whisper | #FF55FF (Magenta) |
| **System / Info** | N/A | Local notifications, loot rolls, server alerts | #FFFF55 (Yellow) |

### 21.2 Chat Features & Safety Controls
* **Item Linking:** Shift-clicking an item in inventory inserts `[Item Name]` into the chat bar, allowing others to hover and view its full tooltip, stats, and quality.
* **Rate Limiting:** Maximum 4 messages per 5 seconds on public channels to prevent spamming.
* **Profanity & Hate-Speech Filter:** Client-side and server-side regex dictionary filter replacing offensive words with asterisks.

---

# 22. Player Presence & Friend List

* **Friend System:** Account-level friend list stored in Supabase.
* **Presence States:** Online, Busy (blocks trade/party invites), Away, Offline / Invisible.
* **Contextual Actions:** Right-clicking a friend allows:
  * "Join Party" / "Invite to Party"
  * "Visit Island" (if permissions allow)
  * "Send Whisper"
  * "Remove Friend" / "Block Player"

---

# 23. Disconnect Handling & State Resilience

Network hiccups, game crashes, and brief drops must never ruin the player's experience.

### 23.1 The 180-Second Grace Window
* When a player unexpectedly drops connection during a party session or expedition:
  1. The server retains the player's character entity as a **"Disconnected Ghost"** for 180 seconds.
  2. The ghost cannot take damage from environmental hazards and is ignored by creature threat AI.
  3. The player's party slot and instance reservation are held.
  4. If the player reconnects within 180 seconds, they seamlessly resume control at their exact coordinate.
  5. If the timer expires, the server securely saves the character's state and moves their coordinate to the last safe tavern/camp.

---

# 24. Social Safety, Moderation & Anti-Griefing

Cozy gameplay requires absolute protection against harassment, trolling, and vandalism.

1. **Instant Island Eviction:** An island owner can open the Visitor List at any time and click **"Evict"** on any visitor. The evicted player is instantly teleported back to the Main Island harbor.
2. **Player Blocking:** Blocking a player:
   * Mutes all chat, emotes, and whispers from them.
   * Hides them from friend lists and party searches.
   * Permanently bars them from entering your Personal Island.
3. **In-Game Reporting:** Players can submit reports for harassment, inappropriate guild names, or exploitation directly through the UI, generating a server log snapshot for moderator review.
4. **Anti-Grief Rollback:** If an authorized co-owner goes rogue and destroys property, the island owner can use the **Homestead Warden NPC** to revert island structures to a snapshot from 1 hour, 6 hours, or 24 hours prior.

---

# 25. Guild Abandonment & Inactivity Succession

To prevent guilds from becoming orphaned dead ends when a Guild Master stops playing:
1. **Active Window:** The Guild Master must log in at least once every 30 days.
2. **Succession Protocol:** If the Guild Master is inactive for **30 consecutive days**:
   * Succession rights pass automatically to the highest-ranking Officer with the most recent login activity.
   * A 7-day notification period alerts all members.
   * If no Officer exists or none log in, succession passes to the oldest active Veteran.
3. **Guild Dissolution:** If a guild has zero active logins across all members for **90 consecutive days**, the guild is placed in hibernation. The Guild Island instance is unmounted and archived in Supabase cold storage until an original member returns.

---

# 26. World Events & Public Shared Expeditions

Multiplayer expands onto the Main Island through scheduled communal events:
* **The Seasonal Harvest Festival:** Players bring high-quality crops to the Town Square community cauldron, unlocking town-wide celebration buffs (e.g., +15% crafting speed for 48 hours).
* **Great Wilds Beast Surges:** Rare behemoths appear in deep expedition zones. Up to 16 players across multiple parties can participate in tracking, subduing, or pacifying the creature, with scaled rewards for all contributors.
* **Public Fishing Derbies:** 30-minute timed fishing tournaments at the coastal docks with real-time leaderboard widgets.

---

# 27. Server Authority & Anti-Cheat Invariants

In strict adherence to `ETA-001`:

1. **Movement Authority:** Clients run client-side prediction, but the server validates velocity, collision boundaries, and teleport thresholds.
2. **Action Validation:** The server confirms distance, tool durability, item prerequisites, and cooldown timers before executing any chop, mine, till, or attack action.
3. **Economic Ledger Invariant:** Currency and inventory items are never created, destroyed, or exchanged by client code. Every transaction must be logged and cryptographically verified on the dedicated server.
4. **Time & Simulation Authority:** Growth of crops, fermentation cycles, and expedition timers are governed by server-authoritative `GameTime`, completely immune to local client clock manipulation.

---

# 28. Data Models & Database Schemas (Supabase)

```sql
-- Guilds Table
CREATE TABLE guilds (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(24) UNIQUE NOT NULL,
    tag VARCHAR(5) NOT NULL,
    crest_data JSONB NOT NULL,
    founder_id UUID REFERENCES auth.users(id),
    tier INT DEFAULT 1,
    member_count INT DEFAULT 1,
    bank_gold BIGINT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Guild Memberships Table
CREATE TABLE guild_members (
    guild_id UUID REFERENCES guilds(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    rank VARCHAR(16) NOT NULL DEFAULT 'recruit', -- 'master', 'officer', 'veteran', 'member', 'recruit'
    contribution_points BIGINT DEFAULT 0,
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    last_active TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    PRIMARY KEY (guild_id, user_id)
);

-- Island Permissions Table
CREATE TABLE island_permissions (
    island_owner_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    target_user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    permission_level VARCHAR(16) NOT NULL, -- 'co_owner', 'trusted', 'visitor', 'blocked'
    can_harvest BOOLEAN DEFAULT FALSE,
    can_plant BOOLEAN DEFAULT FALSE,
    can_build BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    PRIMARY KEY (island_owner_id, target_user_id)
);

-- Active Parties Table (In-Memory / Redis / Fast State)
-- Cached on dedicated game server; persistent session fallback
CREATE TABLE party_sessions (
    party_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    leader_id UUID REFERENCES auth.users(id),
    max_size INT DEFAULT 4,
    loot_rule VARCHAR(24) DEFAULT 'instanced_personal',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
```

---

# 29. GDScript Client/Server Interfaces

### 29.1 PartyManager Interface (`src/network/party_manager.gd`)
```gdscript
class_name PartyManager
extends Node

signal party_updated(members: Array)
signal party_disbanded()
signal party_invite_received(inviter_name: String, party_id: String)
signal loot_awarded(item_id: String, quantity: int)

# Client RPC Requests
func request_invite_player(target_player_id: String) -> void:
    rpc_id(1, "server_invite_player", target_player_id)

func request_leave_party() -> void:
    rpc_id(1, "server_leave_party")

func request_set_loot_rule(new_rule: String) -> void:
    rpc_id(1, "server_set_loot_rule", new_rule)

# Server-authoritative validation
@rpc("any_peer", "call_reliable")
func server_invite_player(target_player_id: String) -> void:
    var sender_peer_id = multiplayer.get_remote_sender_id()
    if not ServerAuth.is_party_leader(sender_peer_id):
        return
    ServerPartyService.send_invite(sender_peer_id, target_player_id)
```

### 29.2 TradeManager Interface (`src/network/trade_manager.gd`)
```gdscript
class_name TradeManager
extends Node

signal trade_requested(partner_name: String)
signal trade_window_opened(partner_data: Dictionary)
signal trade_state_changed(is_my_locked: bool, is_partner_locked: bool)
signal trade_completed()
signal trade_aborted(reason: String)

func request_trade(target_peer_id: int) -> void:
    rpc_id(1, "server_request_trade", target_peer_id)

func stage_trade_item(slot_index: int, item_instance_id: String) -> void:
    rpc_id(1, "server_stage_item", slot_index, item_instance_id)

func toggle_trade_lock(locked: bool) -> void:
    rpc_id(1, "server_toggle_lock", locked)

func confirm_trade_acceptance() -> void:
    rpc_id(1, "server_confirm_acceptance")
```

---

# 30. Edge Cases & Recovery Protocols

1. **Simultaneous Guild Bank Withdrawal Collision:** Two officers attempt to withdraw the same stack of rare Ingots on the exact same server tick.
   * *Resolution:* The server database transaction uses row-level locking (`SELECT ... FOR UPDATE`). The first transaction succeeds; the second receives an instant rejection notification: *"Item no longer available in vault."*
2. **Server Crash During Active Trade Escrow:** The dedicated server loses power while a trade confirmation packet is mid-flight.
   * *Resolution:* Trade operations execute inside atomic database transactions in Supabase. If the transaction does not receive full two-sided commit acknowledgment before shutdown, the entire trade rolls back, and items remain in their original owners' backpacks upon reboot.
3. **Player Evicted While Mid-Craft Animation:** An island owner revokes permissions or kicks a guest while the guest is actively using the forge.
   * *Resolution:* The crafting action is instantly halted, deposited crafting ingredients return to the guest's inventory, and the guest is smoothly transitioned to the harbor arrival skiff without crash or animation lock.
4. **Split-Brain Party Invites:** Two players simultaneously invite each other to different parties.
   * *Resolution:* The server timestamps invites to the millisecond. The earlier invite is presented; the later invite receives a *"Player already invited you"* prompt.

---

# 31. Definition of Done & QA Verification

A build satisfies the **Multiplayer & Social Systems Specification V1.0** when:

* [ ] 4 players can form a party via direct interaction, chat commands, and friend lists.
* [ ] Party member health, location, and compass blips update smoothly in real time (<100ms latency on LAN/low-ping dedicated server).
* [ ] A player can visit another player's Personal Island, subject to permission toggles.
* [ ] An unauthorized visitor cannot till, harvest, place, or demolish any property on another player's island.
* [ ] Assisting with farm watering grants appropriate hydration duration and neighborly reward tithes.
* [ ] Downed players in cooperative hunting can be revived by party members within 60 seconds; total wipe returns party safely to harbor with inventory rules strictly enforced.
* [ ] Direct peer-to-peer trade executes with a two-step lock and mutual confirm escrow; anti-scam delay functions on late modification.
* [ ] Guilds can be founded with 3 members, custom crest, and assigned ranks.
* [ ] Guild Bank permits deposit, withdrawal according to rank daily quotas, and displays an accurate audit log.
* [ ] Guild Island loads with shared communal buildings, farm plots, and assigned personal residential plots.
* [ ] Chat routing delivers messages cleanly to Say, Party, Guild, and Direct Message channels with rate limiting and profanity filtering.
* [ ] Disconnecting mid-session activates the 180-second grace window, allowing seamless reconnect without loss of party state.
