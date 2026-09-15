# Underhallow — Player Progression Specification V1.0

**Document ID:** PR-001  
**Status:** DRAFT  
**Version:** V1.0  
**System:** Player Progression  
**Parent Specifications:**  
* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)  
* [Core Gameplay Systems Specification V1.0 (CG-001)](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)  
* [World & Map Architecture Specification V1.0 (WM-001)](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)  
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)  
* [Master Specification Index V1.0 (MSI-001)](file:///c:/Users/HP/Documents/Underhallow/docs/MASTER_SPECIFICATION_INDEX.md)  
**Related Systems:** Farming, Hunting/Combat, Building, Exploration, Fishing, Crafting, Inventory, Economy, Personal Island, Story/NPCs, Time & Simulation  
**Authority Level:** Level 2 — Gameplay System Specification  

---

# 1. Purpose

The Player Progression System defines how a player's character, abilities, activities, possessions, personal island, and overall life in **Underhallow** develop over time.

The system exists to give players a meaningful sense of growth without turning Underhallow into a conventional grind-heavy RPG.

Progression should allow a player to:

* become better at activities they enjoy;
* discover and unlock new content;
* improve their tools and equipment;
* expand their personal island;
* accumulate wealth;
* discover rare opportunities;
* develop multiple areas of expertise;
* pursue different lifestyles;
* progress at their own pace;
* eventually become highly developed without needing to master every system.

The progression system must preserve the game's core fantasy:

> **Explore, grow, build, and become whoever you want in Underhallow.**

---

# 2. Design Philosophy

Progression in Underhallow is fundamentally about **development of a life**, not simply accumulation of power.

The player should feel:

> “My character has grown, my island has grown, and I have more possibilities than when I started.”

rather than:

> “I need to grind another 20 levels before I am allowed to have fun.”

Progression therefore combines:

1. **Character development**
2. **Skill development**
3. **Activity specialization**
4. **Equipment progression**
5. **World access**
6. **Personal Island development**
7. **Economic development**
8. **Exploration discoveries**
9. **Story milestones**
10. **Rare and unexpected opportunities**

No single progression path should be mandatory.

---

# 3. Core Progression Model

Underhallow uses a **multi-layer progression model**.

### Primary progression layers

| Layer | Purpose |
| :--- | :--- |
| **Character Level** | Represents broad overall character development |
| **Skills** | Represent expertise in individual activities |
| **Specialization** | Represents deeper development within activities |
| **Equipment** | Provides practical capability and efficiency |
| **World Unlocks** | Expands what the player can access |
| **Personal Island** | Represents long-term physical development |
| **Wealth** | Represents economic development |
| **Exploration** | Represents discovery and knowledge |
| **Story** | Provides narrative and system progression |

These layers interact but should not be completely dependent upon one another.

A player should be able to make meaningful progress through several different combinations of activities.

---

# 4. Character Level

## 4.1 Character Level Exists

Every player has a single overall **Character Level**.

Character Level represents the player's broad development as an adventurer and resident of Underhallow.

It is **not intended to represent combat power alone**.

A highly developed farmer, hunter, builder, explorer, or mixed-role player should all be capable of reaching meaningful character development.

---

## 4.2 Character Level Progression

Character XP is awarded through meaningful gameplay activities.

Examples may include:

* farming;
* harvesting;
* hunting;
* exploration;
* discovering locations;
* completing quests;
* building;
* crafting;
* fishing;
* discovering secrets;
* participating in world activities;
* significant achievements.

The exact XP values belong to individual system specifications rather than this document.

---

## 4.3 Character Level Philosophy

Character Level represents **broad overall development** rather than a direct measurement of combat strength.

Increasing Character Level may provide:

* new abilities;
* new content;
* new opportunities;
* access to progression systems;
* access to areas;
* access to buildings;
* access to equipment;
* other meaningful unlocks.

Character Level should not primarily provide large numerical stat increases.

---

# 5. Skill System

Underhallow uses formal skills.

The initial skill architecture includes:

* **Farming**
* **Hunting**
* **Building**
* **Exploration**

Fishing is also a formal skill.

Crafting does **not** initially receive an independent traditional skill.

Instead, Crafting progression will be connected to other progression systems and its own recipe/unlock structure.

---

# 6. Exploration as a Skill

Exploration is treated as a progression category rather than simply a conventional activity counter.

Exploration progression can reflect:

* discovered locations;
* discovered secrets;
* discovered landmarks;
* rare encounters;
* lore;
* hidden areas;
* exploration milestones;
* unusual discoveries.

Exploration therefore rewards **curiosity and observation**, not simply walking around for a certain amount of time.

A player should never be required to artificially grind exploration XP by repeatedly traversing the same area.

---

# 7. Skill Levels

Skills have their own levels.

Examples:

* Farming Level
* Hunting Level
* Building Level
* Exploration Level
* Fishing Level

The exact number of levels is intentionally **not fixed in PR-001**.

This allows balancing and content design to determine the appropriate scale later.

The progression architecture must support both relatively small and larger level ranges without requiring fundamental restructuring.

---

# 8. Skill Progression

Skill progression primarily unlocks **new capabilities and content**.

It should not primarily consist of:

> +2% farming efficiency  
> +3% hunting damage  
> +4% building speed  

Numerical bonuses may exist where useful, but they are secondary.

The preferred progression pattern is:

> **Learn → unlock → gain new capability → access new possibilities.**

---

# 9. Skill Unlock Examples

### Farming
Potential progression may unlock:
* new crops;
* improved farming techniques;
* advanced tools;
* new farming structures;
* specialized production;
* access to more advanced agricultural systems.

### Hunting
Potential progression may unlock:
* improved hunting capability;
* access to more dangerous creatures;
* specialized equipment;
* new hunting techniques;
* rare creature opportunities.

### Building
Potential progression may unlock:
* new structures;
* advanced construction;
* furniture;
* specialized buildings;
* new building functionality.

### Exploration
Potential progression may unlock:
* access to difficult areas;
* exploration tools;
* special interactions;
* hidden-location opportunities;
* discovery-related systems.

### Fishing
Potential progression may unlock:
* new fishing areas;
* new fish;
* better equipment;
* advanced fishing opportunities;
* rare catches.

---

# 10. Level Rewards

Level rewards use a combination of:

* **Abilities**
* **Unlocks**

The system should favor meaningful qualitative progression over raw numerical power.

A level-up should ideally make the player think:

> “What can I do now that I couldn't do before?”

rather than:

> “My number went from 17 to 18.”

---

# 11. Permanent Character Stats

Underhallow will **not use a traditional RPG attribute system as a core progression layer**.

There will not initially be a required:

* Strength
* Dexterity
* Intelligence
* Vitality
* etc.

system.

Any numerical values needed by individual systems should exist as system-specific mechanics rather than forcing the entire game into a traditional stat framework.

---

# 12. Player Power

Player power growth is **moderate**.

The player should become more capable, but progression should not create a massive divide between:

> New Player → Veteran Player

where older players simply overpower everything.

Progression should increasingly provide:

* options;
* efficiency;
* access;
* versatility;
* knowledge;
* convenience;
* specialization.

The goal is **capability growth**, not unchecked power inflation.

---

# 13. Earlier Content

Earlier content should remain relevant.

Progression should make some activities easier or more efficient, but it should not completely invalidate the early game.

A veteran should still have reasons to:

* farm basic crops;
* explore familiar regions;
* interact with ordinary NPCs;
* collect common resources;
* revisit older areas;
* participate in earlier activities.

This is especially important for the cozy, persistent-world identity of Underhallow.

---

# 14. Tool Progression

Tools have progression tiers.

Examples include:

* farming tools;
* hunting tools;
* building tools;
* fishing equipment;
* exploration equipment.

Tool progression can improve:

* efficiency;
* capability;
* access;
* functionality.

Tool upgrades should provide **both efficiency and new capabilities**.

For example:

> A better tool may work faster while also allowing the player to interact with something previously inaccessible.

---

# 15. Tool Durability

The initial progression model uses **tool durability**.

Durability must not become a tedious maintenance mechanic.

It should exist only if the implementation demonstrates that it contributes meaningfully to gameplay.

The exact:

* durability values;
* repair system;
* replacement system;
* resource costs;

belong to the relevant Tool/Farming/Hunting/Building specifications.

---

# 16. Equipment Rarity

Underhallow supports an equipment rarity system.

However, rarity must not turn the game into a traditional loot-grind RPG.

Rare equipment should feel meaningful because it is:

* interesting;
* useful;
* unusual;
* visually distinct;
* difficult or memorable to obtain;

rather than simply having a larger number attached to it.

Rarity should complement exploration and discovery.

---

# 17. Equipment System

Beyond the tool hotbar, Underhallow uses a **limited equipment system**.

Equipment should provide meaningful choices without creating dozens of mandatory inventory-management slots.

Equipment may include things such as:

* specialized tools;
* accessories;
* exploration equipment;
* hunting equipment;
* utility equipment.

The final equipment-slot architecture belongs to the Equipment/Inventory specifications.

---

# 18. Specialization

Underhallow uses **soft specialization**.

Players may become particularly good at certain activities without being permanently assigned to a class.

There are no mandatory classes such as:

> Farmer  
> Hunter  
> Warrior  
> Builder  

that permanently determine the player's identity.

Instead, the player's identity emerges naturally from what they choose to develop.

---

# 19. Specialization Is Activity-Based

A player may develop deeply into farming.

Later, they may decide:

> “I want to stop focusing on farming and become a hunter.”

The player is not locked out of this.

They can begin developing Hunting and eventually unlock its specialization.

Similarly:

> Farmer → Hunter → Builder → Explorer

is a valid progression journey.

The player can accumulate expertise across multiple activities over the life of the character.

---

# 20. Specialization Persistence

Specialization choices are treated as **persistent development**, rather than a single class selection.

A player does not need to constantly respec their identity.

Instead, the game remembers that the player developed certain areas of expertise.

This creates a sense of character history.

For example:

> “This character started as a farmer, became a skilled hunter, then eventually became an accomplished builder.”

That history is part of the character's identity.

---

# 21. No Permanent Class Lock

The following is prohibited:

> “You chose Farmer at Level 10, therefore you can never become a Hunter.”

Instead:

> “You developed farming expertise first. If you later invest in hunting, you can develop hunting expertise too.”

This is one of the central player-freedom principles of progression.

---

# 22. Future Specialization Depth

The game may eventually introduce deeper specialization systems.

For example:

* advanced farming specializations;
* hunting disciplines;
* builder specializations;
* exploration specialties.

However, these should be introduced only when the underlying activities are sufficiently mature.

Specialization depth is therefore **softly scoped rather than fully prescribed by PR-001**.

---

# 23. World Progression

Progression can unlock access to parts of the world.

However, world access should rarely depend on Character Level alone.

World access may require combinations of:

* story progress;
* skills;
* tools;
* quests;
* NPC relationships;
* discoveries;
* environmental conditions.

This preserves the exploration philosophy established in the World & Map Architecture Specification.

---

# 24. Buildings

Progression can unlock buildings.

Building unlocks may depend upon:

* Character Level;
* Building skill;
* quests;
* NPCs;
* resources;
* discoveries;
* economic requirements.

The exact requirements are determined by the Building and Economy specifications.

---

# 25. Crops

Progression can contribute to crop unlocks.

However, crop access may also depend on:

* discovery;
* story;
* NPCs;
* economy;
* exploration;
* world events.

This prevents Farming Level from becoming the only gate to agricultural content.

---

# 26. Creatures and Resources

Progression can unlock access to some creatures and resources.

This is especially appropriate for:

* rare creatures;
* dangerous creatures;
* unusual resources;
* advanced hunting content;
* rare exploration materials.

Common resources should remain accessible without excessive progression requirements.

---

# 27. Crafting Recipes

Crafting recipes are progression content.

Players can unlock new recipes through:

* skills;
* discovery;
* NPCs;
* quests;
* exploration;
* story;
* resources;
* other systems.

Recipe progression should encourage discovery rather than simply functioning as:

> Craft 50 wooden chairs → unlock better chair.

---

# 28. Story and Progression

Story and progression are **moderately connected**.

Story should unlock certain gameplay systems when doing so makes narrative sense.

However, the player should not need to complete the entire main storyline before being allowed to meaningfully develop their character.

Story is one progression path, not the progression system.

---

# 29. Story Independence

Players may largely ignore the main story after the introductory experience and continue developing their character.

They can:

* farm;
* hunt;
* build;
* explore;
* fish;
* earn wealth;
* expand their island;
* discover secrets;
* develop skills.

The game should remain enjoyable for players who treat the story as optional.

---

# 30. Story-Gated Systems

Story milestones may unlock systems when appropriate.

Examples might include:

* gaining access to a new region;
* meeting an important NPC;
* unlocking a major building;
* discovering a major mechanic;
* opening a new world route.

Story should not be used as an arbitrary lock on unrelated gameplay.

---

# 31. Personal Island Progression

Personal Island development is one of the **major long-term progression paths** in Underhallow.

The island should visibly communicate player development.

As players progress, they may:

* unlock additional grids;
* expand their usable territory;
* build new structures;
* improve their home;
* develop farms;
* create specialized spaces;
* decorate;
* create functional layouts;
* eventually express their individual playstyle.

The Personal Island is therefore both a gameplay system and a visual representation of player history.

---

# 32. Island Expansion

Personal Island expansion uses a combination of:

* Character development;
* wealth;
* quests/story;
* other progression requirements.

No single progression system should completely dominate island expansion.

---

# 33. Island Expansion Limits

The maximum Personal Island size is **not yet fixed**.

The architecture must therefore support future expansion without requiring a fundamental redesign.

Expansion should be compatible with the grid-based Personal Island architecture established in WM-001.

The game may eventually establish a practical maximum, but PR-001 intentionally does not lock that value.

---

# 34. Wealth as Progression

Wealth is a legitimate progression path.

Players can become significantly richer through:

* farming;
* hunting;
* trading;
* crafting;
* exploration;
* rare discoveries;
* other economic activities.

Wealth represents **economic development**, not simply a score.

---

# 35. Wealth Does Not Equal Power

Rich players should **not automatically become mechanically stronger**.

Money should primarily provide:

* access;
* convenience;
* customization;
* expansion;
* investment opportunities;
* economic influence.

A wealthy player should not automatically defeat a poorer player because their wallet is larger.

This is especially important for the game's future real-world-linked economy.

---

# 36. Exploration Progression

Exploration does not require a traditional numeric level as its primary expression.

Instead, exploration progression is demonstrated through:

* milestones;
* discoveries;
* secrets;
* areas;
* resources;
* lore;
* rare encounters;
* hidden interactions.

The player's exploration history should matter.

A player who discovers something unusual should feel that they actually **found something**, rather than merely receiving XP.

---

# 37. Exploration Rewards

Exploration can reward all major reward categories:

* new areas;
* secrets;
* items;
* resources;
* lore;
* special encounters;
* unique opportunities.

This is particularly important to the game's mystery component.

Some of the most valuable discoveries should come from players paying attention rather than following a quest marker.

---

# 38. Mastery

A deeper mastery layer is intentionally **deferred**.

The current system should first establish:

> Character Level → Skills → Specialization

before introducing another major layer above them.

However, the architecture should leave room for future mastery systems.

Possible future direction:

> Skill Level → Specialization → Mastery

This should only be introduced when there is enough content to justify it.

---

# 39. Meaningful Build Choices

A deeper build-choice system is **deferred for now**.

Underhallow should not immediately introduce a complicated talent-tree or permanent-stat system.

Future versions may introduce meaningful choices that influence how a player develops.

These choices should remain consistent with the game's soft-specialization philosophy.

---

# 40. Changing Build Choices

When meaningful build choices eventually exist, they should be changeable through an **in-game cost**.

The exact mechanism is intentionally deferred.

The temporary internal placeholder:

> **Department of Ponzi**

may be used for the future system during design discussions, but this name is **not authoritative** and should be replaced before implementation.

The purpose of a respec cost is to make choices meaningful without making them permanently punishing.

---

# 41. Dominant Progression Experience

The intended progression experience is a combination of:

* **Build a life**
* **Unlock the world**
* Become more capable
* Master activities
* Become wealthier
* Discover more

The two dominant feelings should be:

> **“I'm building my life.”**

and

> **“There's more of the world I can discover.”**

Progression should therefore visibly affect both:

**the player** and **the world around them.**

---

# 42. Anti-Grind Philosophy

Underhallow explicitly rejects progression systems that require repetitive grinding simply to remain viable.

There should be no intentional requirement such as:

> “Farm 10,000 crops before you can continue.”

or:

> “Kill 500 creatures to unlock the next area.”

Progression should primarily come from naturally playing the game.

If a player enjoys repeating an activity, they may do so.

But repetition should be **optional**, not mandatory.

---

# 43. Lucky Discoveries

Lucky discoveries can produce significant progression jumps.

Examples may include:

* discovering a rare resource;
* finding a hidden location;
* encountering a rare creature;
* discovering a valuable item;
* finding a secret route;
* uncovering an unusual NPC interaction;
* finding something connected to the world's mystery.

Luck should create memorable stories.

It must not become a substitute for skill or effort.

---

# 44. Endgame

Underhallow does not have a hard traditional endgame.

There is no requirement for:

> “Reach Level 100 and defeat the final boss.”

Instead, progression gradually transitions from:

**Unlocking → Developing → Expanding → Mastering → Expressing**

Players can continue developing their character and world indefinitely.

The game should remain satisfying after the major story is complete.

---

# 45. Player Pace

Players should **not feel behind other players**.

Underhallow is not fundamentally designed around:

* leaderboards;
* competitive progression races;
* mandatory seasonal resets;
* constant optimization;
* social pressure.

Players should be able to progress according to their own pace.

A player who plays casually for months should still feel that their character and island are meaningful.

---

# 46. Playstyle Independence

Any major playstyle should be capable of reaching satisfying development without requiring mastery of every other system.

For example:

### Farmer
Can become highly developed through farming, island development, economy, exploration and supporting systems.

### Hunter
Can become highly developed through hunting, exploration, equipment, rare creatures and supporting systems.

### Builder
Can become highly developed through construction, island development, resources and economic progression.

### Explorer
Can become highly developed through discovery, secrets, lore, rare resources and world progression.

### Hybrid
Can combine multiple paths.

No player should be told:

> “You cannot meaningfully progress because you don't participate in X.”

---

# 47. Progression Interdependency

Progression systems should have **soft connections**, not hard dependency chains.

For example:

```text
          Character Level
                │
       ┌────────┼────────┐
       │        │        │
    Skills   Story    Discovery
       │        │        │
       ├────────┼────────┤
       │        │        │
   Equipment  World   Recipes
       │        │        │
       └────────┼────────┘
                │
        Personal Island
                │
             Wealth
```

The exact dependency graph belongs to the individual system specifications.

---

# 48. Progression Loop

The intended high-level loop is:

```text
PLAY
  ↓
PARTICIPATE IN ACTIVITIES
  ↓
GAIN EXPERIENCE / DISCOVER CONTENT
  ↓
DEVELOP SKILLS
  ↓
UNLOCK NEW CAPABILITIES
  ↓
ACCESS NEW CONTENT
  ↓
DISCOVER MORE OF THE WORLD
  ↓
IMPROVE HOME / ISLAND / EQUIPMENT
  ↓
GAIN WEALTH AND RESOURCES
  ↓
CHOOSE NEW DIRECTIONS
  ↓
REPEAT
```

The loop should feel organic rather than checklist-driven.

---

# 49. Progression and Player Identity

The progression system should gradually answer:

> **“Who is this character?”**

not merely:

> **“What level are they?”**

Two players with the same Character Level may have completely different characters.

### Example

**Player A**
* Farming 30
* Hunting 8
* Building 22
* Exploration 15
* Wealth-focused
* Large agricultural Personal Island

**Player B**
* Farming 8
* Hunting 28
* Building 12
* Exploration 30
* Rare creature collector
* Exploration-focused Personal Island

Both can be equally developed while having completely different identities.

---

# 50. Progression Invariants

The following rules are authoritative for this specification.

### INV-PR-001
There is one overall Character Level.

### INV-PR-002
Character Level represents broad development, not combat power alone.

### INV-PR-003
Meaningful gameplay activities can contribute to Character XP.

### INV-PR-004
Farming, Hunting, Building, Exploration and Fishing have formal progression.

### INV-PR-005
Crafting does not initially require a conventional independent skill.

### INV-PR-006
Skills primarily unlock capabilities and content.

### INV-PR-007
Traditional RPG attributes are not a core progression system.

### INV-PR-008
Player power growth remains moderate.

### INV-PR-009
Earlier content remains relevant.

### INV-PR-010
Tools have progression tiers.

### INV-PR-011
Tool upgrades may improve both efficiency and capability.

### INV-PR-012
Equipment rarity may exist but must not create a loot-grind RPG.

### INV-PR-013
Players use a limited equipment system.

### INV-PR-014
Underhallow has soft specialization rather than mandatory classes.

### INV-PR-015
Players can develop multiple specializations over the life of a character.

### INV-PR-016
Changing activity focus does not permanently lock players out of other specializations.

### INV-PR-017
World progression may depend on multiple requirements.

### INV-PR-018
Personal Island development is a major progression path.

### INV-PR-019
The maximum Personal Island size is not currently locked.

### INV-PR-020
Wealth is a legitimate progression path.

### INV-PR-021
Wealth does not directly determine mechanical superiority.

### INV-PR-022
Exploration rewards discovery rather than repetitive traversal.

### INV-PR-023
Mastery beyond normal skill progression is deferred.

### INV-PR-024
Deep build-choice systems are deferred.

### INV-PR-025
Future build choices should be changeable through an in-game cost.

### INV-PR-026
The main story is not required for all progression.

### INV-PR-027
Players can continue progressing while largely ignoring the main story.

### INV-PR-028
Progression should not require intentional grinding.

### INV-PR-029
Lucky discoveries can create meaningful progression jumps.

### INV-PR-030
There is no hard traditional endgame requirement.

### INV-PR-031
Players should progress at their own pace.

### INV-PR-032
Multiple playstyles can independently reach satisfying development.

---

# 51. Deferred Decisions

The following remain intentionally open for later system specifications:

* exact Character Level cap, if any;
* exact skill-level ranges;
* XP formulas;
* XP curves;
* individual activity XP values;
* exact level rewards;
* exact tool tiers;
* durability formulas;
* equipment-slot structure;
* rarity tiers;
* specialization trees;
* future mastery system;
* build-choice architecture;
* respec cost;
* exact world unlock requirements;
* exact island expansion requirements;
* maximum Personal Island size;
* economic progression thresholds;
* exact crafting progression;
* detailed progression UI.

These should not be invented during implementation.

---

# 52. Dependencies

PR-001 depends upon:

* **North Star V1.0 (NS-001)**
* **Core Gameplay Specifications V1.0 (CG-001)**
* **World & Map Architecture Specification V1.0 (WM-001)**
* **Player Control, Movement & Interaction Specification V1.0 (PC-001)**
* **Master Specification Index & Build Governance V1.0 (MSI-001)**

PR-001 will later provide requirements to:

* Farming Specification (`FA-001`)
* Hunting/Combat Specification (`HC-001`)
* Building Specification (`BI-001`)
* Exploration Specification (`EX-001`)
* Fishing Specification (`FI-001`)
* Crafting Specification
* Equipment/Inventory Specification (`II-001`)
* Economy Specification (`EC-001`)
* Personal Island Specification
* NPC/Quest Specification (`NQ-001`)
* Story Specification (`ST-001`)
* UI/UX Specification (`UI-001`)

---

# 53. Implementation Boundary

This document defines **what progression must accomplish**.

It does not yet define:

* database schemas;
* exact XP formulas;
* UI layouts;
* exact numerical balancing;
* animation requirements;
* code architecture;
* individual quest implementation;
* specific item statistics.

Those belong to lower-level specifications.

Agents must not invent progression rules during implementation when those rules would contradict this document.

---

# 54. Definition of Done

PR-001 is considered implemented correctly when:

* Character Level exists and functions;
* meaningful activities can contribute to progression;
* formal core skills exist;
* skill progression unlocks meaningful capabilities;
* players can develop different activity identities;
* specialization does not permanently lock players into one profession;
* tools can progress;
* equipment progression exists without becoming mandatory loot grinding;
* progression can unlock appropriate world/building/crop/resource content;
* Personal Island development is integrated into progression;
* wealth can function as a progression path;
* exploration provides meaningful progression through discovery;
* story is connected to progression without becoming a universal gate;
* players can continue developing without completing the main story;
* progression does not require repetitive grinding;
* players can pursue satisfying development through different playstyles;
* no system creates an unintended permanent class lock;
* progression remains compatible with future mastery and deeper build-choice systems.

---

# 55. Final Progression Principle

The Player Progression system should ultimately make the player feel:

> **“When I look back at where I started, I can see how much I've grown.”**

But growth should not mean becoming the strongest character in the world.

It should mean:

**I know more.**  
**I can do more.**  
**I have discovered more.**  
**I have built more.**  
**My island has become mine.**  
**My character has a history.**  
**And I chose what that history became.**

That is the progression identity of **Underhallow**.
