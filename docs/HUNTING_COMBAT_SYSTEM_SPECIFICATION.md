# Underhallow — Hunting & Combat System Specification V1.0

**Document ID:** HU-001  
**Version:** V1.0  
**Status:** DRAFT  
**System Level:** Level 2 — Gameplay System  
**Parent Specifications:**
* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)
* [Core Gameplay Specifications V1.0 (CG-001)](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [Player Progression Specification V1.0 (PR-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md)
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)
* [World & Map Architecture Specification V1.0 (WM-001)](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Master Specification Index & Build Governance V1.0 (MSI-001)](file:///c:/Users/HP/Documents/Underhallow/docs/MASTER_SPECIFICATION_INDEX.md)

**Primary Pillar:** Hunting  
**Related Systems:** Exploration, Inventory, Crafting, Farming, Economy, Building, NPCs, Time/Simulation, Equipment, Progression  

---

## 1. Purpose

The Hunting & Combat System defines how players encounter, track, fight, harvest, interact with, and progress through Underhallow's wildlife and hostile creatures.

The system exists to make hunting a **full lifestyle pillar**, equal in importance to farming.

Hunting is not simply a combat minigame.

It combines:

* Exploration
* Tracking
* Creature discovery
* Combat
* Harvesting
* Resource gathering
* Processing
* Trading
* Wildlife interaction
* Farm protection
* Character progression

The intended fantasy is:

> **Explore dangerous places, track creatures, hunt them, bring their resources home, and build a life around what you discover.**

---

# 2. Design Philosophy

## 2.1 Hunting Is a Lifestyle

Hunting is a legitimate way to play Underhallow.

A player should be able to spend most of their time:

* Tracking wildlife
* Exploring remote areas
* Hunting creatures
* Harvesting resources
* Processing or selling their finds
* Improving hunting equipment
* Protecting farms
* Searching for rare creatures
* Completing hunting-related quests
* Building wealth

A dedicated hunter should be capable of becoming economically successful without being required to become a farmer.

---

## 2.2 Combat Supports Hunting

Combat exists primarily because the world contains creatures and dangers that players may need to confront.

However, combat is not intended to transform Underhallow into a traditional action RPG.

The target experience is:

> **Simple to learn, satisfying to master.**

Players should understand the basic combat loop almost immediately while still finding meaningful differences between weapons, creatures, positioning, equipment, and hunting approaches.

---

## 2.3 Exploration + Hunting

Exploration and hunting are tightly connected.

Some of the most valuable creatures should not simply be unlocked by reaching a high Hunting Level.

Players may instead need to:

* Discover a hidden area
* Follow tracks
* Observe environmental clues
* Travel at a particular time
* Find unusual habitats
* Complete exploration objectives
* Discover an NPC or quest
* Encounter unusual world conditions

Therefore:

> **Hunting progression increases capability; exploration creates opportunity.**

---

# 3. Core Hunting Loop

The intended hunting loop is:

**Explore → Discover → Track → Approach → Hunt/Fight → Defeat → Harvest → Decide what to do with resources**

After harvesting, the player has multiple economic choices:

### Option A — Sell Raw

**Hunt → Harvest → Sell**

This is fast and convenient but produces lower economic value.

### Option B — Process

**Hunt → Harvest → Process → Sell/Use**

Processing requires additional time, infrastructure, effort, or resources but can produce significantly higher-value goods.

### Option C — Use

**Hunt → Harvest → Process → Craft/Consume/Build**

Resources can feed into other systems rather than being sold.

**Processing is never mandatory.**

A hunter who wants immediate income can sell raw materials.

A hunter who wants greater economic value can invest in processing.

---

# 4. Combat Philosophy

Combat follows the broader Underhallow control philosophy:

> **Cozy Adventure RPG**

Combat should be approachable rather than mechanically overwhelming.

The system should emphasize:

* Positioning
* Facing
* Timing
* Weapon choice
* Creature behavior
* Exploration knowledge
* Equipment
* Player decisions

It should not depend on:

* Extremely complex combos
* Difficult execution
* Constant button inputs
* Punishing stamina management
* Competitive PvP mechanics

---

# 5. Combat Controls

Combat follows the existing player-control specification.

The basic model is:

**Face target → Attack**

Combat uses:

* Directional movement
* Facing direction
* Soft targeting
* Context-sensitive interaction
* Weapon-specific attacks

The player does not need to precisely click tiny hitboxes to attack.

---

## 5.1 Soft Targeting

Combat uses **soft targeting**.

The system should assist the player's attack toward a reasonable nearby target while preserving player control.

This makes combat accessible while allowing positioning to remain meaningful.

Soft targeting should not automatically play the combat encounter for the player.

---

# 6. Attacks

## 6.1 Attack Types

The exact attack behavior depends on the equipped weapon.

Weapon categories may include:

* Melee
* Ranged
* Special

Different weapons can therefore create different combat experiences.

---

## 6.2 Attack Speed

Weapons may have different attack speeds.

A fast weapon may:

* Attack quickly
* Deal less damage per hit
* Provide greater responsiveness

A slower weapon may:

* Attack more slowly
* Deal greater damage
* Require better timing

Exact numerical balancing is implementation-specific.

---

## 6.3 Combos

Complex combo systems are not required for V1.

Weapons may receive simple chained attacks or additional techniques later.

The combat architecture should therefore allow:

> **Basic attack → simple advanced attack patterns**

without requiring a complex combo framework from the beginning.

---

## 6.4 Cooldowns

Normal attacks do **not** require artificial cooldowns as a universal rule.

Special attacks, abilities, or specific weapons may use cooldowns where appropriate.

---

## 6.5 Attack Cancellation

Attacks follow the existing movement/action rules.

Player movement may interrupt/cancel attacks where the action permits it.

Combat should therefore remain responsive rather than locking the player into long animations unnecessarily.

---

# 7. Weapons

Weapons form part of player progression.

## 7.1 Weapon Categories

The architecture supports:

1. **Melee weapons**
2. **Ranged weapons**
3. **Special weapons**

The initial launch roster should remain manageable rather than introducing excessive weapon categories.

---

## 7.2 Weapon Tiers

Weapons have progression tiers.

Higher-tier equipment may provide:

* Greater effectiveness
* Improved efficiency
* New capabilities
* Access to stronger encounters
* Different tactical possibilities

Higher tier should not simply mean:

> "Old weapon, but with a bigger number."

Capability upgrades are preferred where appropriate.

---

## 7.3 Weapon Rarity

Weapons can have rarity levels.

Rarity may affect:

* Base performance
* Special properties
* Acquisition difficulty
* Economic value
* Unusual effects

Rarity should remain understandable and should not turn Underhallow into a loot-box-style equipment treadmill.

---

## 7.4 Durability

Weapons have durability.

Durability exists to create an equipment-maintenance decision without becoming excessively punitive.

Durability loss may occur through:

* Combat
* Heavy use
* Environmental conditions
* Other system-specific interactions

Repair/replacement mechanics belong to the broader equipment/crafting economy.

---

# 8. Basic Hunting Equipment

Hunting should not be inaccessible to new players.

Players can craft basic hunting equipment using common materials such as:

* Wood
* Stone
* Other basic early-game resources

Therefore:

> **A new player does not need a specialized progression path before they can begin hunting.**

Advanced equipment can require:

* Hunting skill
* Rare materials
* Exploration
* NPC relationships
* Crafting
* Special discoveries
* Economic investment

---

# 9. Player Health & Defense

## 9.1 Health

Players have a straightforward health system.

Health should be easy to understand and visually communicate.

The system should avoid unnecessary RPG stat complexity.

---

## 9.2 Defense

Players may have defensive equipment or bonuses.

Defense can come from:

* Equipment
* Armor
* Other progression systems

Defense should complement combat rather than become mandatory numerical optimization.

---

## 9.3 Defensive Actions

Combat supports both:

* **Dodge**
* **Block**

These should remain simple and readable.

Different weapons or equipment may favor different defensive approaches.

---

## 9.4 Healing

Healing can come from:

* Food
* Healing items
* Other appropriate consumables

The system should allow players to prepare for dangerous expeditions without turning healing into a complicated resource-management minigame.

---

# 10. Creatures

Underhallow contains multiple creature categories.

The creature ecosystem supports:

* Peaceful wildlife
* Hostile creatures
* Monsters
* Special creatures
* Rare creatures
* Boss-level creatures

Not every creature is intended to be a combat encounter.

---

# 11. Creature Behavior

Creatures should feel like inhabitants of the world rather than moving targets.

Creature behavior can include:

* Movement
* Feeding
* Resting
* Wandering
* Fleeing
* Attacking
* Territorial behavior
* Time-of-day behavior
* Environmental responses

Important creatures may receive more sophisticated behavior than ordinary wildlife.

---

## 11.1 Peaceful Wildlife

Peaceful creatures should generally remain peaceful.

Ordinary wildlife should not randomly become aggressive simply to create combat.

This preserves the cozy character of the world.

Specific creatures may have defensive or territorial behavior where appropriate.

---

## 11.2 Creature AI

The architecture supports:

* Basic behavior for ordinary creatures
* More sophisticated behavior for important creatures

This allows development effort to be concentrated where it produces the most value.

---

# 12. Territories

Some creatures have territories.

Territories can communicate:

* Where creatures live
* Where they hunt
* Where they rest
* Where rare creatures may appear
* Where dangerous encounters occur

Territorial behavior should reinforce exploration.

A player should gradually learn:

> "If I want to find this creature, I know where to look."

---

# 13. Creature Schedules

Creature schedules exist where they improve the world.

Examples include:

* Day/night behavior
* Feeding periods
* Resting locations
* Seasonal behavior if seasons are later introduced
* Territory movement

Important creatures may receive more detailed schedules.

Not every creature needs a complicated simulation.

---

# 14. Creature Damage & Behavior

Creature responses should depend on the creature.

Possible responses include:

* Attacking
* Fleeing
* Retreating toward territory
* Becoming more aggressive
* Changing behavior
* Attempting to protect territory

Creatures are not required to behave identically.

---

# 15. Hunting

Hunting is broader than simply killing creatures.

It consists of:

1. Finding
2. Tracking
3. Approaching
4. Fighting or interacting
5. Defeating/capturing where applicable
6. Harvesting
7. Processing or selling

---

# 16. Tracking

Tracking is a formal hunting mechanic.

Players may identify creatures through environmental clues such as:

* Footprints
* Tracks
* Disturbed vegetation
* Sounds
* Droppings
* Damaged environments
* Other creature-specific clues

Tracking should reward observation.

The goal is not to create a complicated forensic simulator.

It should instead produce moments where the player thinks:

> "Something was here."

and follows the world to discover what it was.

---

# 17. Hunting Equipment

Advanced hunting may use specialized equipment.

Examples may eventually include:

* Tracking tools
* Specialized weapons
* Ranged equipment
* Harvesting tools
* Creature-specific equipment

However:

> **Basic hunting equipment remains craftable from common resources.**

Specialized equipment should provide meaningful advantages rather than being an arbitrary requirement for ordinary hunting.

---

# 18. Hunting Approaches

Different creatures may reward different approaches.

Possible approaches include:

* Direct combat
* Ranged attacks
* Tracking
* Positioning
* Observation
* Preparation
* Environmental awareness

This allows players to develop a personal hunting style.

---

# 19. Rare Creatures

Rare creatures should generally be rare because they are **difficult to discover**, not merely because they have extremely high levels.

Rare encounters may depend on:

* Hidden locations
* Specific habitats
* Exploration
* Time of day
* Creature behavior
* Tracking
* Quests
* World events
* Unusual conditions

A player should be able to discover something extraordinary through curiosity and luck.

---

# 20. Hunting Skill

Hunting is a formal character skill.

Hunting Skill increases through meaningful hunting activity.

It may progress through:

* Successful hunts
* Tracking
* Harvesting
* Discovering creatures
* Hunting quests
* Other meaningful hunting accomplishments

Grinding meaningless actions should not be required.

---

# 21. Hunting Progression

Hunting progression can unlock:

* Better weapons
* Advanced hunting equipment
* Hunting techniques
* New creatures
* Better harvesting capabilities
* Specialized equipment
* Access to advanced hunting opportunities

Hunting Level may also determine whether a player is sufficiently prepared to tackle stronger creatures.

However:

> **Hunting Level should not be the only gate to creatures.**

Exploration remains equally important.

---

# 22. Hunting Specialization

Players can develop a hunting specialization.

Possible specialization directions include:

* Big-game hunting
* Tracking
* Ranged hunting
* Harvesting
* Rare creature hunting

Specialization is part of the broader soft-specialization philosophy.

Players should be able to develop hunting deeply without permanently locking themselves out of other lifestyles.

---

# 23. Creature Difficulty

Combat danger varies by creature.

The world should contain:

* Easy creatures
* Moderate threats
* Dangerous creatures
* Elite creatures
* Boss encounters

Ordinary creatures should generally be approachable.

More dangerous creatures should provide meaningful risk and reward.

---

# 24. Elite Creatures

Elite creatures are significantly more dangerous than ordinary wildlife.

They may have:

* Stronger attacks
* Better defenses
* Unique behavior
* Better rewards
* Rare materials
* Unique drops

Elite encounters should feel like meaningful discoveries rather than ordinary enemies with inflated statistics.

---

# 25. Bosses

The system supports two broad boss categories:

### Story Bosses

Creatures or enemies tied to narrative progression.

### World Bosses

Rare, exceptional creatures encountered through exploration or special world circumstances.

World bosses should remain rare enough to preserve their significance.

---

# 26. Loot & Creature Resources

Creatures provide resources that can support multiple systems.

Possible outputs include:

* Food
* Materials
* Crafting resources
* Processable resources
* Sellable resources
* Rare items

Hunting should therefore feed into the wider Underhallow economy.

---

# 27. Predictable + Rare Drops

Creature drops should generally be understandable.

Players should learn:

> "This creature gives me this type of material."

However, rare drops may exist.

The intended model is:

**Mostly predictable resources + occasional rare discoveries.**

This prevents hunting from feeling like pure gambling.

---

# 28. Unique Hunting Rewards

Some rare creatures can provide unique resources or items.

These should be associated with meaningful discoveries rather than ordinary farming of the same creature hundreds of times.

---

# 29. Resources Outside Combat

Hunting resources must have meaningful uses outside combat.

They may contribute to:

* Farming
* Crafting
* Building
* Food
* Processing
* Trading
* Quests
* NPC relationships
* Other professions

This makes hunting economically and mechanically interconnected with the rest of Underhallow.

---

# 30. Harvesting

Defeating a creature does not automatically mean the player has received every valuable resource.

The player must **harvest the creature**.

Harvesting should be a distinct interaction within the hunting loop.

Harvesting can produce raw resources whose value depends on what the player does next.

---

# 31. Raw vs Processed Resources

This distinction is fundamental.

### Raw Resource

Immediately obtainable after harvesting.

Examples might include:

* Raw meat
* Hide
* Bones
* Other creature materials

Raw resources can be sold immediately.

Their economic value is intentionally lower.

### Processed Resource

Raw materials can be processed into more valuable goods.

Processing may involve:

* Buildings
* Crafting stations
* Recipes
* Time
* Additional materials
* Skill progression

Processed goods should generally command higher value.

---

# 32. Processing Is Optional

Processing must **never be a mandatory step** before selling.

The player can choose:

> **Convenience over maximum value**

or:

> **Additional work for greater value**

This supports different player personalities.

A player who needs quick money can sell raw materials.

A dedicated economic player can invest in processing infrastructure and maximize returns.

---

# 33. Hunting Economy

Hunting is a legitimate economic profession.

The hunter economy can contain:

**Creature → Raw Material → Processed Material → Finished Product**

Different players can participate at different stages.

For example:

* Hunter gathers raw material.
* Another player/system processes it.
* Another player uses it in crafting.
* A trader sells the finished product.

This creates opportunities for a broader economy later.

---

# 34. Hunting Wealth

Hunters can become wealthy.

However, wealth should depend on:

* Skill
* Effort
* Discovery
* Risk
* Market conditions
* Processing decisions
* Rare finds
* Player strategy

There should not be a guaranteed "best" profession.

---

# 35. Hunting & Exploration

Hunting should naturally encourage exploration.

Players may discover:

* New creature habitats
* Rare creatures
* Hidden hunting grounds
* Valuable resources
* Hunting quests
* New equipment
* Lore

This reinforces the larger Underhallow world design.

---

# 36. Combat & Exploration Gates

Combat may sometimes be relevant to exploration, but it should not become a universal requirement.

Some areas may contain:

* Dangerous creatures
* Creature guardians
* Combat-related challenges

Other areas may instead require:

* Tools
* Quests
* Exploration
* Skills
* Environmental navigation
* NPC interaction

This keeps the world from becoming:

> "You cannot explore unless you are strong enough to fight."

---

# 37. Creature-Guarded Resources

Some valuable resources may be located in dangerous areas or near dangerous creatures.

This creates optional risk/reward decisions.

The player may think:

> "I could get this resource, but is it worth dealing with that creature?"

---

# 38. Defeat

Combat defeat is **non-lethal**.

On defeat:

* The player loses some expedition resources according to the established defeat rules.
* The player returns to their Personal Island.
* Time/progression consequences apply according to the broader defeat system.
* Equipment is not permanently deleted.

Defeat should feel meaningful without destroying hours of progress.

---

# 39. Equipment Loss on Defeat

Equipment is **not permanently lost** during ordinary defeat.

Instead, equipment may suffer:

* Durability damage
* Repair costs
* Other recoverable penalties

This creates consequence without making players afraid to experiment.

---

# 40. Lost Resources

Resources lost during defeat may remain recoverable at the defeat location.

This creates an optional:

> **Return and reclaim**

decision.

Returning should itself carry some risk, particularly if the original area remains dangerous.

---

# 41. Hunting & Farming Interaction

Hunting and farming are connected.

Wild creatures may occasionally threaten farms.

Hunters can therefore provide a useful service by:

* Protecting farms
* Dealing with dangerous wildlife
* Responding to creature incursions
* Helping resolve farm-related threats

This creates a natural relationship between two major lifestyles.

---

# 42. Farm Raids

Creature activity can affect farms.

Farm threats may come from:

* Wildlife
* Hostile creatures
* Special events
* NPC-related events

These encounters should remain controlled rather than becoming constant interruptions.

Farming should remain relaxing.

---

# 43. Robin Hood

The previously established **Robin Hood farm-raiding concept** is incorporated into the system.

Robin Hood can function as both:

1. A recurring antagonist/event presence
2. A quest/story character

His appearances can connect:

* Farming
* Hunting
* NPCs
* Story
* World events
* Resource protection

The exact implementation, motivation, event structure, and narrative arc should be defined in the NPC/Story specifications.

The hunting system only establishes that the architecture must support these interactions.

---

# 44. Wildlife Ethics & Non-Lethal Interaction

Underhallow does not require every wildlife encounter to end in death.

The system supports non-lethal interactions.

Possible activities include:

* Tracking
* Observing
* Feeding
* Other wildlife interactions
* Future creature-specific interactions

Not every creature needs to be collectible or capturable.

---

# 45. Wildlife Observation

Observation can provide gameplay value.

Players may learn:

* Where creatures live
* When they appear
* What they do
* What they eat
* How they react
* Where they travel

This reinforces the game's exploration identity.

---

# 46. Creature Collection

The architecture can support special collectible/capturable creatures where appropriate.

This should be selective rather than turning every creature into a collectible.

The exact system is deferred to a future wildlife/collection specification.

---

# 47. Violence & Presentation

Combat remains compatible with Underhallow's cozy tone.

The presentation should be:

* Non-gory
* Stylized
* Pixel-art appropriate
* Readable
* Impactful without excessive realism

Creatures may visibly die as part of the hunting loop.

Death should be presented through stylized game animation rather than graphic imagery.

---

# 48. Moral Framing

Underhallow does **not** use a morality meter or traditional morality system for hunting.

The game can nevertheless allow:

* NPC reactions
* Story consequences
* World reactions
* Dialogue changes
* Contextual consequences

This means the game can acknowledge player behavior without turning hunting into a morality spreadsheet.

---

# 49. Hunter Identity

The hunter fantasy combines:

* Fighter
* Tracker
* Explorer
* Survivalist
* Resource gatherer

A successful hunter should feel like someone who knows the world:

> Where creatures live, how they behave, how to find them, how to defeat them, and what their resources are worth.

---

# 50. Hunter Lifestyle Loop

A mature Hunter gameplay loop may look like:

**Prepare**

↓  
Select equipment and supplies

↓  
**Travel**

↓  
Explore the world

↓  
**Track**

↓  
Identify creature/habitat

↓  
**Approach**

↓  
Choose combat or interaction strategy

↓  
**Hunt**

↓  
Defeat creature

↓  
**Harvest**

↓  
Obtain raw resources

↓  
**Choose**

→ Sell raw immediately

**OR**

→ Process for greater value

**OR**

→ Use in crafting/other systems

↓  
**Return**

↓  
Improve equipment / Hunting Skill / wealth

↓  
Plan next expedition

---

# 51. Progression Integration

HU-001 integrates directly with the Player Progression system.

Hunting can contribute to:

### Character Level

Meaningful hunting activities can award general XP.

### Hunting Skill

Dedicated hunting actions progress the Hunting Skill.

### Specialization

Players may develop specialized hunting capabilities.

### Equipment

Weapons and hunting tools improve over time.

### World Access

Certain hunting opportunities can be tied to exploration and progression.

---

# 52. No Stamina System

Hunting and combat do **not** use a stamina/energy system to restrict ordinary player movement or exploration.

Players are instead constrained through:

* Equipment
* Health
* Risk
* Time
* Inventory capacity
* Resource availability
* Creature difficulty
* World geography

This preserves the player's freedom to explore.

---

# 53. Inventory Relationship

Hunting naturally interacts with the limited inventory system.

A hunter must make decisions about:

* What equipment to carry
* How much space to reserve for resources
* Whether to return home
* Whether to abandon lower-value resources
* Whether to continue an expedition

This makes inventory capacity an important strategic constraint without introducing stamina.

---

# 54. Economic Design Principles

The hunting economy must follow these principles:

1. **Raw resources have value.**
2. **Processed resources have greater potential value.**
3. **Processing is optional.**
4. **Players can make money without processing.**
5. **Processing rewards additional effort/investment.**
6. **Rare discoveries can create exceptional opportunities.**
7. **No profession should be mechanically guaranteed to dominate the economy.**
8. **Hunters can become wealthy.**
9. **Economic participation remains optional.**
10. **Hunting resources should connect to other systems.**

---

# 55. Core System Invariants

The following rules are authoritative for HU-001 V1.0:

### HU-I01

Hunting is a major lifestyle pillar equal in importance to farming.

### HU-I02

Combat remains approachable and moderately deep rather than becoming a hardcore action-RPG system.

### HU-I03

Hunting includes tracking, exploration, combat, harvesting, and resource management.

### HU-I04

Basic hunting equipment must be obtainable using common early-game resources.

### HU-I05

Hunting is a formal progression skill.

### HU-I06

Rare creatures are primarily discovery/exploration opportunities rather than simple level checks.

### HU-I07

Creature behavior must support the world feeling inhabited.

### HU-I08

Raw creature resources can be sold without processing.

### HU-I09

Processing is optional and exists primarily to create higher-value economic opportunities.

### HU-I10

Hunting resources must have uses outside combat.

### HU-I11

Dedicated hunters can make a viable living from hunting.

### HU-I12

Ordinary defeat does not permanently destroy the player's equipment.

### HU-I13

Hunting must not depend on a stamina system.

### HU-I14

Combat should not become a universal requirement for world exploration.

### HU-I15

The system supports both lethal hunting and selected non-lethal wildlife interactions.

### HU-I16

Robin Hood/farm-raiding interactions must be compatible with hunting, farming, NPC, and event systems.

---

# 56. Deferred Decisions

The following are intentionally **not fully locked** by HU-001 V1.0:

* Exact weapon roster
* Exact weapon statistics
* Exact rarity tiers
* Exact durability values
* Exact armor system
* Exact creature roster
* Exact creature AI implementations
* Exact tracking mechanics
* Exact harvesting interactions
* Exact processing recipes
* Exact hunting specialization trees
* Exact boss roster
* Exact world-boss mechanics
* Exact wildlife collection mechanics
* Exact Robin Hood event structure
* Exact raw/processed economic values
* Exact defeat-resource-loss percentages
* Exact healing balance
* Exact combat animations
* Exact combat VFX
* Exact creature spawn algorithms

These should be resolved by subsequent system/implementation specifications rather than improvised during implementation.

---

# 57. Dependencies

HU-001 depends on:

* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)
* [Technical Architecture Specification V1.0 (TA-001)](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md)
* [Core Gameplay Specifications V1.0 (CG-001)](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [World & Map Architecture Specification V1.0 (WM-001)](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)
* [Player Progression Specification V1.0 (PR-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md)

HU-001 will influence:

* Inventory Specification
* Crafting Specification
* Exploration Specification
* NPC Specification
* Economy Specification
* Farming/Farm Event Specification
* Equipment Specification
* Time & Simulation Specification
* UI/UX Specification
* Audio Specification

---

# 58. Implementation Boundary

Agents implementing hunting and combat must not independently alter:

* Core progression philosophy
* Hunting's status as a major lifestyle
* The optional nature of processing
* The no-stamina rule
* The non-lethal defeat model
* The exploration/hunting relationship
* The raw-versus-processed economic principle
* The game's cozy/non-gory presentation
* Authoritative player-control rules

Technical implementation details remain flexible where they do not violate this specification or higher-level specifications.

---

# 59. Definition of Done

HU-001 is considered implemented when:

### Combat

* [ ] Player can perform basic combat.
* [ ] Soft targeting functions correctly.
* [ ] Melee combat functions.
* [ ] Ranged combat functions where implemented.
* [ ] Weapon differences are meaningful.
* [ ] Health and damage work.
* [ ] Dodge/block work where applicable.
* [ ] Healing works.
* [ ] Combat cancellation behaves according to Player Control rules.

### Creatures

* [ ] Creature entities exist.
* [ ] Peaceful and hostile behaviors function.
* [ ] Creature movement functions.
* [ ] Creature combat behavior functions.
* [ ] Creature defeat states function.
* [ ] Appropriate creatures support territories/schedules.
* [ ] Rare/elite behavior can be represented.

### Hunting

* [ ] Tracking can be represented.
* [ ] Hunting encounters function.
* [ ] Creatures can be harvested.
* [ ] Raw resources are generated.
* [ ] Hunting XP/skill progression works.
* [ ] Hunting equipment progression works.

### Economy

* [ ] Raw resources can be sold.
* [ ] Processing can increase value.
* [ ] Processing is optional.
* [ ] Processed resources can be used/sold.

### Defeat

* [ ] Defeat returns the player according to the established system.
* [ ] Resource-loss behavior works.
* [ ] Lost resources can be recovered where applicable.
* [ ] Equipment is not permanently deleted.

### Integration

* [ ] Hunting works with inventory.
* [ ] Hunting contributes to character progression.
* [ ] Hunting can interact with exploration.
* [ ] Hunting resources can feed other systems.
* [ ] Farm-threat interactions can be supported.
* [ ] No stamina dependency exists.

### Quality

* [ ] No major combat softlocks.
* [ ] Creature AI does not create obvious systemic failures.
* [ ] Hunting cannot bypass inventory rules.
* [ ] Economy exploits are tested.
* [ ] Rare creature spawning cannot be trivially exploited.
* [ ] Defeat/recovery exploits are tested.
* [ ] System remains consistent with the authoritative Master Specification.

---

# 60. Design Principle

The central principle of HU-001 is:

> **Hunting should make the world feel alive and worth exploring.**

The player should not feel that they are entering a combat arena.

They should feel that they are entering a living world where creatures have habitats, behaviors, resources, secrets, and value.

The best hunting experience in Underhallow should create moments like:

> *“I wasn't even looking for this creature. I just noticed its tracks, followed them into that area I'd never explored before, and found something incredible.”*

That is the intended identity of the Underhallow hunting system.

---

**HU-001 V1.0 — Draft complete.**
