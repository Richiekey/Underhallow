# Underhallow — Farming System Specification V1.0

**Document ID:** FB-001  
**Version:** V1.0  
**Status:** DRAFT  
**System:** Farming  
**Authority Level:** Level 2 — Gameplay System Specification  

**Parent Specifications**

* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)
* [Core Gameplay Specifications V1.0 (CG-001)](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [World & Map Architecture Specification V1.0 (WM-001)](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)
* [Player Progression Specification V1.0 (PR-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md)
* [Master Specification Index & Build Governance V1.0 (MSI-001)](file:///c:/Users/HP/Documents/Underhallow/docs/MASTER_SPECIFICATION_INDEX.md)

**Related Systems**

* Personal Island
* Inventory
* Economy
* Crafting
* Tools & Equipment
* NPCs
* Events
* Exploration
* Time & Weather
* Livestock
* Building

---

# 1. Purpose

The Farming System defines how players cultivate land, grow crops, harvest resources, develop farming expertise, process agricultural products, and eventually build farming operations ranging from a small personal garden to a highly developed agricultural enterprise.

Farming is one of Underhallow's **primary lifestyle pillars**.

The system is designed around a simple principle:

> **Easy to start. Deep to master.**

A new player should be able to understand farming almost immediately.

A player who decides to seriously pursue farming, however, should have enough depth to spend a substantial portion of their time developing their agricultural operation.

---

# 2. Farming Identity

Farming should feel like a combination of:

* cozy routine;
* creative expression;
* economic strategy;
* progression;
* discovery;
* long-term development.

It should not feel like a spreadsheet simulator.

The player should be able to begin with:

> hoe → plant → water → wait → harvest

and gradually discover deeper systems such as:

> crop optimization → better tools → specialized crops → processing → infrastructure → automation → economic expansion.

---

# 3. Role in the Game

Farming is deliberately capable of supporting a player almost entirely on its own.

A dedicated farmer should be able to:

* produce valuable goods;
* sell crops;
* process agricultural products;
* improve their farm;
* unlock farming technology;
* specialize;
* become wealthy;
* expand their Personal Island;
* eventually operate a sophisticated agricultural business.

However, players are never required to become farmers.

A Hunter, Explorer, Builder, or hybrid character should remain capable of achieving satisfying progression without maintaining a farm.

---

# 4. Accessibility

Every player can farm.

The player does **not** select Farmer as a permanent class at character creation.

Farming is available to everyone from the beginning.

The opening game introduces farming naturally as part of the player's transition into their new life and Personal Island.

This reinforces the game's broader philosophy:

> Players discover their preferred identity through play rather than selecting a permanent profession at the start.

---

# 5. Complexity Model

Farming uses **progressive complexity**.

### Early game

The player learns:

1. prepare soil;
2. plant seeds;
3. water crops;
4. wait for growth;
5. harvest.

### Mid-game

Players can discover:

* better tools;
* better crops;
* fertilizer;
* crop quality;
* processing;
* improved farming infrastructure;
* specialization.

### Advanced farming

Dedicated farmers may eventually access:

* advanced equipment;
* automation;
* large-scale production;
* specialized crops;
* advanced processing;
* sophisticated economic strategies;
* rare agricultural discoveries.

The advanced layers must remain optional.

---

# 6. Farmland Architecture

Farming uses a hybrid land model.

Players can create farmland within permitted areas of their Personal Island, while some environments may contain predefined or specially designated farming areas.

This gives players:

* freedom;
* creativity;
* meaningful spatial planning;

without allowing farming to override the fundamental world architecture.

Major terrain remains governed by the World & Map Architecture Specification.

---

# 7. Soil Preparation

Basic farming requires **soil preparation**.

The primary interaction is:

> **Till → Plant**

The player uses a farming tool to prepare suitable land before planting.

Soil preparation should provide a small amount of physical interaction without becoming unnecessarily tedious.

---

# 8. Soil Types

A basic soil-quality concept exists, but detailed soil types are **deferred**.

Future versions may introduce:

* fertile soil;
* poor soil;
* special soil;
* unusual underground conditions;
* rare/mystical soil.

The architecture should therefore avoid assuming that every farm tile is permanently identical.

Soil types are not required for the initial farming implementation.

---

# 9. Tilled Soil Persistence

Tilled farmland normally returns toward its natural state over time.

However, the exact persistence behavior may vary based on:

* tools;
* soil;
* environmental conditions;
* special equipment.

Rare tools or special soil may eventually allow unusual persistence.

This gives future progression room to introduce better agricultural infrastructure without requiring it for basic farming.

---

# 10. Removing Farmland

Players can remove farmland using an appropriate tool or interaction.

This prevents accidental permanent modification of the Personal Island.

Players should be able to redesign their farms as their plans change.

---

# 11. Seeds

Seeds can come from multiple sources.

Potential sources include:

* merchants;
* NPCs;
* exploration;
* quests;
* harvesting;
* discoveries;
* rewards;
* special events;
* the economy.

No single acquisition method should control the entire seed economy.

---

# 12. Seed Reproduction

Some crops may provide seeds when harvested.

This system should be **crop-specific rather than universal**.

Certain crops may:

* produce seeds;
* produce multiple seeds;
* require purchased seeds;
* provide rare seed opportunities.

This creates different economic models for different crops.

---

# 13. Crop Variety

Launch farming should contain a **moderate variety of crops**.

The exact number is deliberately not locked in this specification.

The final crop roster should be determined by:

* world design;
* art production capacity;
* economy;
* farming balance;
* progression;
* content quality.

Quality of individual crops is more important than reaching an arbitrary launch count.

---

# 14. Crop Growth

Crops have different growth times.

Growth duration should create meaningful agricultural decisions.

For example:

* fast crops;
* medium crops;
* slow/high-value crops;
* rare crops;
* special crops.

Growth time should influence both:

* farming strategy;
* economic opportunity.

---

# 15. Growth Stages

Crops have visible growth stages.

Players should be able to look at a farm and understand:

> planted → growing → mature → ready to harvest

without needing to inspect a menu.

Visual growth is an important part of the cozy farming experience.

---

# 16. Crop Quality

A crop-quality system exists, but the exact implementation remains subject to detailed crop/economy balancing.

Quality may eventually influence:

* selling value;
* processing value;
* special recipes;
* NPC demand;
* achievements;
* rarity.

Quality should not make ordinary crops feel worthless.

---

# 17. Rare Crop Variants

Rare crop variants exist.

These may emerge through:

* luck;
* special conditions;
* exploration;
* rare seeds;
* unusual soil;
* world events;
* hidden mechanics.

Rare agricultural discoveries should be capable of producing meaningful excitement and economic opportunity.

---

# 18. Watering

Crops require watering.

Watering is a fundamental farming interaction.

However, watering should not become an exhausting chore.

The system therefore supports progression toward:

* better watering tools;
* larger-area watering;
* infrastructure;
* eventually automation.

---

# 19. Watering Tools

Watering can be performed using farming tools.

Higher-tier tools may improve:

* watering area;
* efficiency;
* speed;
* resource consumption;
* specialized functionality.

The exact tool progression belongs to the Tool/Farming implementation specifications.

---

# 20. Rain

Rain affects crop watering.

However, not every environmental condition necessarily behaves identically.

Some rain/weather states may provide normal watering while special weather can potentially have unique agricultural effects.

The exact weather interactions belong to the Time & Weather system.

---

# 21. Failure to Water

Failure to maintain crops uses a combination of consequences rather than immediate destruction.

Depending on the crop/system state, lack of watering may:

* pause growth;
* slow growth;
* reduce quality;
* eventually contribute to crop failure under appropriate conditions.

The system should avoid making one missed day devastating.

Farming should reward consistency without punishing experimentation.

---

# 22. Fertilizer

Fertilizer is optional.

It is not required for basic farming.

Players who want greater agricultural depth may use fertilizer to influence things such as:

* growth;
* quality;
* yield;
* special properties.

This creates an optimization layer for dedicated farmers without burdening casual players.

---

# 23. Weeds

Weeds exist as a **light farming maintenance system**.

They should:

* visually communicate neglected farmland;
* provide occasional maintenance;
* potentially interact with crop health;

without becoming an overwhelming daily chore.

The exact weed behavior belongs to the Farming implementation specification.

---

# 24. Pests & Diseases

Pests and diseases exist as **light systems**.

They are not intended to become a complex agricultural simulation.

Their purpose is to:

* occasionally create farm problems;
* encourage observation;
* create opportunities for tools/items;
* add variety.

They must not constantly destroy player progress.

---

# 25. Farming Tools

The farming toolset includes multiple specialized tools.

The exact final roster remains open, but the architecture supports tools for:

* soil preparation;
* watering;
* harvesting;
* crop maintenance;
* future advanced farming functions.

Tools are separate from stamina.

---

# 26. No Stamina Requirement

Farming actions do **not consume stamina**.

This is an authoritative consequence of the Core Gameplay Specification.

The player is never prevented from farming because an energy meter reached zero.

Difficulty and pacing come from:

* time;
* resources;
* tool capability;
* farm organization;
* economic decisions;
* world events.

Not stamina.

---

# 27. Tool Progression

Farming tools have progression tiers.

Higher-level tools may provide:

* greater efficiency;
* larger interaction areas;
* faster actions;
* new capabilities;
* improved resource management.

Tool progression should eventually make large farms more practical without making early tools useless.

---

# 28. Advanced Tool Capabilities

Some advanced tools may fundamentally change how a farm is operated.

For example:

> Hoe → improved hoe → area hoe → specialized farming equipment

or:

> Watering Can → improved can → area watering → irrigation equipment.

The exact tiers should be determined during balancing.

---

# 29. Game-Day Farming

Crop growth uses the game's normal time/day system.

Farming is therefore integrated into the broader simulation rather than using a separate real-world clock.

Players can understand farming through the same:

* days;
* nights;
* weather;
* world time;

used by the rest of Underhallow.

---

# 30. Overnight Growth

Crops can progress through growth while the player is away from the farm overnight.

The passing of a game day is a meaningful farming progression event.

This creates the familiar rhythm:

> Prepare today → wait → return tomorrow → harvest.

---

# 31. Offline/Absent Island Progression

Crops continue progressing even if the player is temporarily away from their Personal Island.

This allows players to:

* go hunting;
* explore;
* complete quests;
* fish;
* visit other locations;

without freezing their farm.

A player should not feel forced to remain on their island simply because crops are growing.

---

# 32. Seasons

Seasons are **deferred rather than required at launch**.

The farming architecture must remain compatible with a future seasonal system.

If seasons are introduced later, they may affect:

* crop availability;
* crop growth;
* weather;
* special crops;
* farming events;
* economy.

However, seasons are not required for the first Farming implementation.

---

# 33. Harvesting

Harvesting supports both:

* direct interaction with crops;
* contextual interaction through the universal interaction system.

The player may use the appropriate harvesting tool where required, while contextual interaction can simplify appropriate crop harvesting.

---

# 34. Harvest Quantity

Harvest yield can vary.

Yield may depend on a combination of:

* crop type;
* crop quality;
* farming skill;
* tool;
* fertilizer;
* environmental conditions;
* rare effects;
* luck.

The exact mathematical model belongs to balancing.

---

# 35. Regrowing Crops

Some crops can regrow after harvesting.

Others require replanting.

This creates multiple agricultural strategies.

For example:

**Fast/replant crops**

> Plant → grow → harvest → replant

**Regrowing crops**

> Plant → grow → harvest → maintain → harvest again

The exact crop classification is defined by the crop database.

---

# 36. Post-Harvest Appearance

Harvested crops visibly change state.

Players should be able to understand the condition of their farm without opening menus.

This includes appropriate visual states for:

* growing crops;
* mature crops;
* harvested crops;
* neglected crops;
* damaged crops.

---

# 37. Farm Buildings

Farming supports dedicated structures.

Potential examples include:

* storage;
* barns;
* greenhouses;
* silos;
* processing buildings;
* irrigation infrastructure;
* specialized agricultural structures.

Buildings integrate with the Building System.

---

# 38. Livestock

Livestock is supported in the broader Underhallow architecture, but it is **not defined as exclusively a farming mechanic**.

Livestock will receive a separate specification.

This is intentional because:

* farmers may raise animals;
* hunters may interact with animals;
* builders may construct animal facilities;
* traders may participate in livestock economics;
* other roles may interact with the system.

The livestock system should therefore be a shared world/economic system.

---

# 39. Crop Processing

Players can process agricultural products into higher-value goods.

Examples may include:

> Wheat → Flour

> Fruit → Jam

> Milk → Cheese

The exact recipes are part of the Crafting/Processing specifications.

Processing creates a second economic layer beyond simply selling raw crops.

---

# 40. Automation

Automation exists.

However, automation is **earned**.

A player who wants advanced agricultural automation must invest significant:

* time;
* resources;
* wealth;
* progression;
* infrastructure.

Potential automation includes:

* irrigation;
* watering;
* harvesting assistance;
* processing;
* storage;
* transportation.

---

# 41. Automation Philosophy

Automation does not exist to remove farming from the game.

It exists to let highly developed players manage larger and more sophisticated operations.

The desired progression is:

> **Small farm → efficient farm → advanced farm → agricultural enterprise**

rather than:

> **Plant → immediately automate everything.**

---

# 42. Automation Limits

Automation is intentionally limited.

The player should still retain meaningful interaction with their farm.

Automation should reduce repetitive labor without turning the Personal Island into an entirely passive money-generating machine.

---

# 43. Farming Progression

Farming progression unlocks a combination of:

* crops;
* tools;
* farming structures;
* techniques;
* processing;
* equipment;
* automation;
* specialized opportunities.

The Farming skill should therefore feel useful at every stage.

---

# 44. Farming Level Unlocks

Farming levels can unlock content.

However, Farming Level is not the only gate.

Unlocks may also depend on:

* exploration;
* story;
* NPCs;
* discoveries;
* resources;
* economy;
* world events.

This prevents farming from becoming an isolated progression tunnel.

---

# 45. Rare Farming Content

Some of the most unusual crops and agricultural opportunities should require discovery.

For example:

> A player finds a strange plant in a hidden region.

That discovery may eventually allow:

* rare seeds;
* unique crops;
* unusual products;
* valuable trade goods;
* lore.

This connects farming directly to Underhallow's exploration identity.

---

# 46. Farming Specialization

Farming has specialization.

Specialization represents deeper investment in the farming lifestyle.

Possible future branches include:

* crop production;
* quality farming;
* rare crops;
* high-efficiency agriculture;
* processing;
* commercial farming.

These are **examples**, not locked specialization trees.

---

# 47. Specialization Philosophy

Specialization should provide meaningful advantages without preventing players from pursuing other activities.

A player can specialize in farming and later decide:

> “I'm going hunting now.”

They retain their farming development and can subsequently develop Hunting specialization.

This reinforces the Player Progression Specification's multi-specialization model.

---

# 48. Farming Economy

Agriculture supports multiple economic uses.

Crops can function as:

* food;
* trade goods;
* crafting materials;
* processed goods;
* quest resources;
* commodities.

No single economic use should dominate every crop.

Different crops should create different opportunities.

---

# 49. Crop Market

The economy may support fluctuating crop prices.

Price variation should create opportunities for:

* planning;
* specialization;
* stockpiling;
* timing;
* trade.

However, price volatility must not make farming feel like gambling.

Players should still be able to build a reliable livelihood.

---

# 50. Farming as a Business

Dedicated farmers can specialize economically.

A player might build:

> Farm → Processing → Storage → Trade → Wealth

rather than simply selling every raw crop.

This supports Underhallow's broader capitalist economy.

The goal is to create opportunities for players who want to become wealthy through effort, planning and risk.

---

# 51. Exploration and Farming

Exploration directly feeds the Farming system.

Players may discover:

* rare seeds;
* unusual crops;
* special soil;
* hidden farming locations;
* ancient agricultural knowledge;
* mysterious plants;
* unique farming resources.

This prevents farming from becoming entirely menu-driven.

---

# 52. Mystery Crops

Some crops may be tied directly to Underhallow's deeper mystery.

A player could encounter something that initially appears to be:

> “just a strange plant.”

Later, they may discover that it has a connection to:

* an old civilization;
* an NPC;
* a hidden location;
* a world event;
* the darker mystery beneath Underhallow.

This is an intentional bridge between the cozy farming surface and the game's darker underlying narrative.

---

# 53. Crop Loss

Crop loss exists, but the system should avoid harsh permanent punishment.

Potential loss may occur through:

* environmental conditions;
* neglect;
* pests;
* special events;
* NPC/event interference.

The player should understand why a loss happened.

Random destruction without meaningful counterplay should be avoided.

---

# 54. Farm Risk

Farming can have real risks.

The farm is not necessarily a completely isolated economic bubble.

Possible threats include:

* environmental events;
* pests;
* creatures;
* NPC events;
* thieves/raiders;
* special story events.

These risks create opportunities for:

* preparation;
* defense;
* infrastructure;
* tools;
* NPC relationships;
* economic planning.

---

# 55. Robin Hood / Farm Raider Event

Underhallow's farming architecture supports a recurring or event-driven **farm-raider character** inspired by the Robin Hood character concept from the earlier Carrot Game design.

The character should not simply exist as an arbitrary enemy.

The concept should be developed as an **NPC/event system**.

Possible behavior could include:

* observing prosperous farms;
* targeting valuable crops;
* appearing during specific conditions;
* stealing a limited amount of produce;
* creating a defensive response;
* potentially becoming part of a larger narrative.

The exact character, motivation, frequency, rewards, counterplay and story are deferred to the NPC/Event specifications.

The important Farming rule is:

> **Farm prosperity can create interesting risk.**

---

# 56. Farm Protection

Because farming can become economically valuable, players may eventually have ways to protect their operations.

Potential systems include:

* fencing;
* lighting;
* storage;
* farm buildings;
* NPC assistance;
* security structures;
* defensive events;
* player presence;
* specialized equipment.

Protection should be an **investment choice**, not a mandatory tax.

---

# 57. Abandoning Farming

Players are explicitly allowed to stop farming.

If a player decides:

> “I'm going hunting for the next few weeks.”

the game should support that decision.

The farm should not become permanently ruined simply because the player changed interests.

This is essential to the game's soft-specialization philosophy.

---

# 58. Neglected Farms

Neglect may have consequences, but those consequences should be recoverable.

Potential outcomes include:

* weeds;
* slower development;
* crop loss;
* temporary disorder;
* missed opportunities.

The player should be able to return and rebuild.

The system should never communicate:

> “You stopped farming, therefore you ruined your character.”

---

# 59. Farming Identity

The intended farming identity is:

> **A cozy but surprisingly deep agricultural lifestyle.**

At the surface:

> Plant. Water. Harvest.

Underneath:

> Optimize. Discover. Specialize. Process. Invest. Automate. Trade. Expand.

This dual-layer structure allows farming to appeal to both casual and highly engaged players.

---

# 60. Farming Progression Loop

The intended progression is:

```text
START SMALL
    ↓
PREPARE SOIL
    ↓
PLANT
    ↓
WATER
    ↓
GROW
    ↓
HARVEST
    ↓
SELL / USE / PROCESS
    ↓
EARN RESOURCES & XP
    ↓
IMPROVE TOOLS
    ↓
UNLOCK BETTER CROPS & TECHNIQUES
    ↓
EXPAND FARM
    ↓
SPECIALIZE
    ↓
PROCESS & TRADE
    ↓
INVEST IN INFRASTRUCTURE
    ↓
AUTOMATE SELECTED TASKS
    ↓
BUILD AGRICULTURAL WEALTH
    ↓
DISCOVER NEW OPPORTUNITIES
```

The player can exit this loop at any point and pursue another lifestyle.

---

# 61. Farming and Personal Island

The Personal Island is the primary physical home of farming.

Players can use available grids to create:

* compact gardens;
* large farms;
* mixed-use homesteads;
* agricultural businesses;
* decorative farms;
* experimental farms.

The farm should visibly communicate the player's progression.

---

# 62. Farm Layout as Player Expression

Farm layout is a form of creative expression.

Players should have meaningful freedom over:

* crop arrangement;
* buildings;
* pathways;
* irrigation;
* storage;
* production;
* decoration.

Efficient farms and beautiful farms should both be valid.

Ideally, players can create something that is:

> efficient **and** beautiful,

but the game should not require optimization.

---

# 63. Farming and Other Roles

Farming is designed to interact with other lifestyles.

### Farmer + Hunter

Hunter supplies:

* materials;
* rare resources;
* animal products.

Farmer supplies:

* food;
* crops;
* trade goods.

### Farmer + Builder

Builder develops:

* barns;
* greenhouses;
* processing facilities;
* storage;
* farm infrastructure.

### Farmer + Explorer

Explorer discovers:

* rare seeds;
* unique crops;
* unusual resources;
* agricultural secrets.

This interconnectedness is important to the broader Underhallow economy.

---

# 64. Farming Invariants

The following rules are authoritative.

### INV-FB-001

Farming is one of Underhallow's major lifestyle pillars.

### INV-FB-002

Every player can farm.

### INV-FB-003

Farming is not a permanent character class.

### INV-FB-004

Farming is easy to begin but capable of substantial depth.

### INV-FB-005

Basic farming requires soil preparation.

### INV-FB-006

Detailed soil types are deferred.

### INV-FB-007

Tilled soil normally does not remain permanently altered.

### INV-FB-008

Players can redesign their farmland.

### INV-FB-009

Seeds can come from multiple sources.

### INV-FB-010

Different crops have different growth times.

### INV-FB-011

Crops have visible growth stages.

### INV-FB-012

Rare crop variants can exist.

### INV-FB-013

Crops require watering.

### INV-FB-014

Rain interacts with crop watering.

### INV-FB-015

Missing watering does not immediately destroy a crop.

### INV-FB-016

Fertilizer is optional.

### INV-FB-017

Weeds are a light maintenance system.

### INV-FB-018

Pests/diseases are light systems rather than deep simulation.

### INV-FB-019

Farming does not use stamina.

### INV-FB-020

Farming tools have progression.

### INV-FB-021

Advanced tools can increase both efficiency and capability.

### INV-FB-022

Crop growth follows the game's normal time system.

### INV-FB-023

Crops progress while the player is away.

### INV-FB-024

Seasons are deferred.

### INV-FB-025

Harvest yields can vary.

### INV-FB-026

Some crops can regrow.

### INV-FB-027

Farming supports dedicated buildings.

### INV-FB-028

Livestock is a separate shared system.

### INV-FB-029

Agricultural processing is supported.

### INV-FB-030

Automation exists but must be earned.

### INV-FB-031

Automation does not completely remove manual farming.

### INV-FB-032

Farming progression unlocks crops, tools, structures and techniques.

### INV-FB-033

Farming progression is not the sole requirement for agricultural content.

### INV-FB-034

Exploration can reveal rare farming content.

### INV-FB-035

Farming has specialization.

### INV-FB-036

Specialization does not permanently prevent other lifestyles.

### INV-FB-037

Crops can function as food, commodities and crafting resources.

### INV-FB-038

Crop prices may fluctuate.

### INV-FB-039

Farming can support a player's primary livelihood.

### INV-FB-040

Farm prosperity can introduce meaningful risk.

### INV-FB-041

Farm-raiding events are supported.

### INV-FB-042

Farm risk must have counterplay.

### INV-FB-043

Players can temporarily abandon farming without permanently destroying their progression.

### INV-FB-044

Neglected farms remain recoverable.

### INV-FB-045

Farm layout supports player expression.

### INV-FB-046

Farming can be pursued independently of other major lifestyles.

---

# 65. Deferred Decisions

The following are deliberately **not locked** by FB-001:

* exact crop roster;
* exact crop count;
* exact growth durations;
* exact crop quality tiers;
* soil types;
* exact fertilizer system;
* exact weed mechanics;
* pest/disease mechanics;
* final farming tool roster;
* tool upgrade numbers;
* exact crop yields;
* exact harvest mechanics;
* exact seasonal system;
* exact livestock mechanics;
* processing recipes;
* automation technology tree;
* exact farming specializations;
* crop market formulas;
* farm-raiding frequency;
* Robin Hood character design;
* farm-defense architecture;
* exact farm building roster.

These require their respective system specifications and balancing passes.

---

# 66. Dependencies

### Farming depends upon

* Core Gameplay
* Player Progression
* Player Control
* World & Map Architecture
* Personal Island
* Time & Simulation
* Inventory
* Tools/Equipment

### Farming feeds into

* Economy
* Crafting
* Building
* NPCs
* Quests
* Exploration
* Livestock
* Events
* Personal Island progression

---

# 67. Definition of Done

The Farming System is considered production-ready when:

* players can prepare farmland;
* players can acquire and plant seeds;
* crops grow over game time;
* crops have visible growth states;
* players can water crops;
* weather interacts appropriately with crops;
* players can harvest crops;
* crop yield can vary appropriately;
* some crops can regrow;
* crops can be sold/used/processed;
* Farming skill progression works;
* farming tools have progression;
* farming unlocks work;
* farming specialization works;
* farming can support an independent playstyle;
* optional fertilizer/maintenance systems do not become mandatory chores;
* advanced automation is achievable;
* automation does not eliminate meaningful farming;
* Personal Island farm layouts work correctly;
* farm risk has understandable counterplay;
* players can leave farming and return without catastrophic permanent loss;
* exploration can provide rare agricultural discoveries;
* the farming economy integrates correctly with the wider economy.

---

# 68. Final Farming Principle

Underhallow's farming system should make the player feel that they are **building something that belongs to them**.

A player might begin with:

> **a tiny patch of soil and a handful of seeds.**

Eventually they might have:

> **a beautiful farm, rare crops, specialized tools, processing buildings, automated systems, valuable trade goods and enough wealth to fund whatever life they want next.**

And another player might look at all of that and say:

> **“That's cool. I'm going hunting.”**

Both players are playing Underhallow correctly.
