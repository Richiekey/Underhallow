# UNDERHALLOW

# Creature & Wildlife Bible V1.0

**Document ID:** CW-001
**Status:** DRAFT
**Version:** 1.0
**Project:** Underhallow
**Authority Level:** Level 1 — Foundation Specification
**Parent Specifications:**

* `NS-001` — North Star V1.0
* `CD-001` — Creative Direction V1.0
* `AD-001` — Art Direction Bible V1.0
* `WB-001` — World Bible V1.0
* `NB-001` — Narrative Bible V1.0
* `CB-001` — Character Bible V1.0
* `BE-001` — Biome & Environment Bible V1.1
* `WM-001` — World & Map Architecture V1.0
* `MI-001` — Main Island Design Specification V1.0
* `PI-001` — Personal Island Design Specification V1.0

**Related Downstream Specifications:**

* `LA-001` — Livestock & Animal Husbandry
* `HU-001` — Hunting & Combat System
* `FI-001` — Fishing
* `FR-001` — Foraging & Wild Resources
* `EX-001` — Exploration & Secrets
* `ML-001` — Mystery & Lore Architecture
* `NC-001` — Narrative Content Framework
* `RW-001` — Regional World Specifications
* `WE-001` — Weather & Environmental Systems
* `TS-001` — Time, Day/Night & Simulation
* `AU-001` — Audio & Music Direction Bible

---

## 0. Specification Purpose

The Creature & Wildlife Bible defines how animal life, wildlife, livestock, domestic animals, aquatic life, strange creatures, and creature-related world interactions function as part of Underhallow's living world.

CW-001 translates the environmental philosophy established by `BE-001` into a coherent creature philosophy.

It governs:

* wildlife identity;
* creature taxonomy;
* ordinary wildlife;
* wildlife behavior;
* ecological relationships;
* passive wildlife;
* hunting identity;
* animal resources;
* livestock;
* domestic animals;
* pets;
* aquatic life;
* strange wildlife;
* impossible creatures;
* wildlife and environmental relationships;
* wildlife and mystery;
* creature progression;
* population density;
* regeneration;
* wildlife observation;
* bestiary/journal principles;
* creature visual identity;
* creature design constraints.

CW-001 does **not** independently define:

* hunting combat mechanics;
* livestock production mechanics;
* fishing mechanics;
* economy values;
* farming mechanics;
* resource-spawn algorithms;
* quest implementation;
* wildlife AI implementation;
* multiplayer animal ownership;
* detailed creature animation implementation.

Those systems specialize the creature rules established here.

---

# 1. Creature Philosophy

Underhallow's wildlife exists first to make the world feel **alive**.

Wildlife is not primarily a collection of resource containers.

It is not primarily an enemy roster.

It is not primarily collectible content.

It is part of the environment.

The player should be able to walk through Underhallow and feel that animals exist whether or not the player is watching them.

The foundational creature principle is:

> **Wildlife should feel like the island has a life of its own, whether or not the player is there.**

This means wildlife must support several different player experiences:

* peaceful observation;
* environmental immersion;
* exploration;
* gathering;
* hunting;
* fishing;
* farming;
* animal husbandry;
* companionship;
* collecting;
* folklore;
* environmental storytelling;
* mystery.

No single interaction should define the entire creature system.

---

# 2. Relationship to Underhallow's Creative Identity

Wildlife must reinforce the project's central progression:

> **Cozy surface. Mystical middle. Deep mystery underneath.**

Creature life should therefore exist across a spectrum:

**Ordinary → Notable → Strange → Impossible**

This progression mirrors the environmental mystery model established in `BE-001`.

Ordinary wildlife should dominate the world.

Notable wildlife should reward observation.

Strange wildlife should create curiosity.

Impossible wildlife should be rare enough to remain meaningful.

The player should not constantly encounter supernatural creatures.

The strange becomes meaningful because the ordinary exists around it.

---

# 3. Core Wildlife Laws

## Law 1 — Wildlife Is Part of the World

Animals must feel like inhabitants rather than spawned objects.

## Law 2 — Ordinary Wildlife Comes First

The majority of wildlife should be believable and recognizable.

## Law 3 — Wildlife Is Not Primarily Loot

Animals must not exist solely to provide resources.

## Law 4 — Observation Is a Valid Interaction

A player should be able to encounter wildlife without hunting, collecting, taming, or otherwise mechanically interacting with it.

## Law 5 — Wildlife Has Context

Species should make sense within their environment, geography, climate, and available resources.

## Law 6 — Behavior Creates Life

Believable movement, reactions, routines, and environmental responses are more important than simulation complexity.

## Law 7 — Hunting Is an Activity, Not the Default

The presence of an animal does not imply that the player should kill it.

## Law 8 — Strange Wildlife Is Rare

Unusual creatures must retain mystery through scarcity.

## Law 9 — Not Every Strange Creature Is a Mystery Clue

Some creatures are simply strange.

Others may connect to history.

Others may remain unexplained.

## Law 10 — Impossible Creatures Are Significant

An impossible creature encounter should feel memorable.

## Law 11 — Wildlife Reflects Environment

Different regions should produce different creature communities.

## Law 12 — The World Responds

Wildlife populations and behavior can respond to time, weather, player activity, and environmental conditions without becoming a hardcore simulation.

## Law 13 — Wildlife Supports Multiple Player Identities

Farmers, hunters, explorers, collectors, builders, traders, fishers, and casual players should all have reasons to appreciate wildlife.

## Law 14 — Animals Can Matter Emotionally

Long-term relationships with livestock, pets, and certain creatures may become part of the player's personal story.

## Law 15 — Do Not Explain Everything

Some creature mysteries should remain unresolved.

## Law 16 — Creature Design Must Serve the World

No creature should exist merely because it is visually interesting.

---

# 4. Creature Taxonomy

Underhallow uses the following broad creature categories.

### 4.1 Birds

Examples include:

* songbirds;
* waterfowl;
* seabirds;
* birds of prey;
* woodland birds;
* farmland birds.

Birds primarily contribute to:

* atmosphere;
* environmental identity;
* observation;
* ecosystem believability;
* occasional resource or gameplay interactions;
* exploration clues.

---

### 4.2 Mammals

Examples include:

* deer;
* rabbits;
* foxes;
* rodents;
* wild goats;
* woodland mammals;
* coastal mammals;
* other regionally appropriate species.

Mammals may support:

* observation;
* hunting;
* folklore;
* environmental storytelling;
* resources;
* rare mystery encounters.

---

### 4.3 Reptiles

Reptiles should be geographically and environmentally appropriate.

They may appear in:

* wetlands;
* warm coastal environments;
* rocky areas;
* woodland;
* specialized environments.

---

### 4.4 Amphibians

Amphibians are especially important to:

* wetlands;
* ponds;
* streams;
* marshes;
* rainy conditions;
* evening/night atmosphere.

---

### 4.5 Fish

Fish are a major part of Underhallow's aquatic identity.

Different bodies of water should possess distinct fish communities.

---

### 4.6 Insects & Small Creatures

These include:

* butterflies;
* bees;
* moths;
* beetles;
* dragonflies;
* fireflies;
* worms;
* small crustaceans;
* small reptiles;
* other environmental micro-fauna.

They should contribute heavily to environmental life.

Some may have gameplay or collection value.

---

### 4.7 Domestic Animals

Domestic animals include:

* dogs;
* cats;
* horses;
* other non-livestock domestic animals.

---

### 4.8 Livestock

Core livestock may include:

* chickens;
* cows;
* goats;
* sheep;
* pigs;
* ducks;
* geese;
* rabbits;
* horses where appropriate.

The final production roster is owned by `LA-001`.

---

### 4.9 Strange Wildlife

Strange wildlife occupies the boundary between recognizable nature and Underhallow's deeper mysteries.

---

### 4.10 Impossible Wildlife

Impossible wildlife is extremely rare.

Its existence may contradict ordinary assumptions about:

* biology;
* geography;
* time;
* space;
* history;
* natural behavior.

---

# 5. Wildlife Population Philosophy

Underhallow should contain **variable wildlife density**.

Some areas should feel quiet.

Some should feel full of life.

Some should feel temporarily empty.

Some should feel unusually active.

Population density should reflect:

* habitat;
* time;
* weather;
* season if implemented;
* human presence;
* food availability;
* water;
* environmental conditions;
* player activity.

The goal is believable variation rather than numerical simulation.

---

# 6. Wildlife Behavior

Wildlife uses **believable abstraction**.

The game should create convincing behavior without attempting to simulate complete animal biology.

Animals may have:

* movement patterns;
* preferred habitats;
* feeding behaviors;
* resting behaviors;
* social behaviors;
* avoidance behaviors;
* territorial behaviors;
* weather responses;
* time-of-day behaviors;
* reactions to player proximity;
* reactions to other animals.

The complexity of behavior should vary by species.

A small insect does not require the same behavioral model as a deer.

---

# 7. Daily Routines

Wildlife should appear to have routines without requiring hardcore simulation.

Examples:

### Morning

* birds become active;
* grazing animals emerge;
* insects begin activity;
* nocturnal animals retreat.

### Day

* grazing;
* foraging;
* movement;
* resting;
* aquatic activity.

### Evening

* certain animals become more active;
* nocturnal species emerge;
* birds return to roosts;
* predators may become more active.

### Night

* nocturnal wildlife becomes more visible;
* some creatures disappear;
* some environments become significantly different.

The player should discover these patterns naturally.

---

# 8. Wildlife Response to the Player

Wildlife reactions should be species-dependent.

Possible responses include:

* fleeing;
* watching;
* approaching;
* ignoring;
* becoming alert;
* defending territory;
* following briefly;
* hiding;
* returning after the player leaves.

The game should avoid making every animal instantly flee from the player.

Some creatures should tolerate human proximity.

Domesticated animals should behave differently from wild animals.

Strange creatures may violate normal expectations.

---

# 9. Wildlife Interaction

Wildlife should interact with its environment and occasionally with other wildlife.

Examples:

* birds feeding in fields;
* fish schooling;
* deer grazing;
* insects around flowers;
* frogs around ponds;
* predators pursuing prey;
* birds reacting to sudden movement;
* animals gathering around water.

These interactions should be visible often enough to create the impression of an ecosystem.

They do not require full ecological simulation.

---

# 10. Passive Wildlife

Passive wildlife is a major part of Underhallow's identity.

The player should be able to:

* observe animals;
* photograph or document them if such a system is later introduced;
* track them;
* watch their behavior;
* discover habitats;
* identify species;
* learn folklore;
* simply enjoy their presence.

Not every encounter should produce an item.

Not every observation needs a reward.

Sometimes the reward is simply:

> **“I saw something beautiful.”**

---

# 11. Wildlife as Exploration

Wildlife can occasionally reward curiosity.

Examples:

* following a deer leads toward an unusual clearing;
* a flock of birds reveals nearby water;
* unusual fish behavior points toward an environmental anomaly;
* repeated animal sightings suggest a hidden habitat;
* a strange creature appears briefly and disappears into the forest.

These encounters must remain occasional.

Wildlife should not become a GPS system.

---

# 12. Hunting Philosophy

Hunting is a legitimate outdoor activity within Underhallow.

It should feel like:

* observation;
* tracking;
* patience;
* skill;
* knowledge of the environment;
* resource gathering.

Hunting should not feel like:

* arcade shooting;
* constant combat;
* mandatory progression;
* the primary way of interacting with wildlife.

The player should be able to become a successful hunter without the game implying that every animal exists to be hunted.

---

# 13. Tracking

Tracking should exist at a light-to-moderate level.

The player may notice:

* tracks;
* disturbed vegetation;
* sounds;
* movement;
* droppings;
* feeding areas;
* nests;
* dens;
* water activity;
* repeated routes.

Tracking should reward attention without becoming a complicated simulation.

---

# 14. Animal Flight & Defense

Most ordinary wild animals should prefer avoidance.

Different species may:

* flee;
* hide;
* freeze;
* defend territory;
* threaten;
* attack only when cornered.

Dangerous wildlife should be **region-dependent and relatively uncommon**.

The wilderness should contain risk without becoming a constant combat arena.

---

# 15. Hunting Ethics & Emotional Context

Hunting should not be presented as universally good or universally bad.

The emotional meaning of hunting should depend on:

* species;
* rarity;
* context;
* local culture;
* purpose;
* player relationship with the animal;
* environmental circumstances.

Certain animals may be culturally respected.

Some may be considered ordinary game.

Some may be rare enough that NPCs react negatively to their hunting.

Some may be dangerous.

Some may be mysterious.

The game should provide context rather than a universal moral verdict.

---

# 16. Hunting Outputs

Hunted animals may provide:

* meat;
* hide;
* fur;
* feathers;
* bones;
* organs or specialist materials where appropriate;
* crafting materials;
* cooking ingredients;
* quest materials;
* trade goods.

Processing may increase value.

However:

> **Processing is optional.**

A player should be able to sell an animal or its resources in raw form.

A player who enjoys processing can receive additional value for doing so.

This preserves different playstyles.

---

# 17. Resource Quality

Creature resources may vary according to:

* species;
* animal condition;
* resource type;
* hunting outcome;
* rarity.

The system should remain relatively lightweight.

The goal is to create meaningful variation without turning hunting into a min-maxing spreadsheet.

---

# 18. Livestock

Livestock is a major part of Personal Island life.

Livestock should contribute to:

* farm identity;
* routine;
* resource production;
* visual life;
* emotional attachment;
* progression;
* homestead development.

The Personal Island should gradually feel more alive as the player develops it.

---

# 19. Livestock Personalities

Individual animals should be capable of recognizable personalities.

Examples:

* shy;
* curious;
* stubborn;
* affectionate;
* energetic;
* lazy;
* social;
* independent.

Personality should be strongest where the player has invested significant time.

Ordinary livestock does not need complex personality simulation.

---

# 20. Animal Relationships

The player may develop emotional bonds with animals through:

* care;
* time;
* feeding;
* interaction;
* routine;
* keeping the animal healthy;
* simply having it around.

The strongest relationships should emerge naturally rather than through mandatory affection meters.

---

# 21. Pets

Pets are distinct from livestock.

Initial emphasis should be placed on:

* dogs;
* cats.

Pets primarily contribute to:

* companionship;
* home life;
* emotional identity;
* atmosphere;
* Personal Island life.

Pets should not simply be another production system.

---

# 22. Animal Companions

Certain animals may eventually accompany the player outside the Personal Island.

This should depend on the animal.

Examples:

* dogs may accompany exploration;
* horses may support travel;
* certain specialized animals may have contextual utility.

This should remain distinct from a traditional RPG companion-party system.

The animal should remain an animal.

---

# 23. Fish & Aquatic Life

Aquatic environments should possess distinct biological identities.

Fish populations should vary by:

* river;
* lake;
* pond;
* marsh;
* coast;
* cove;
* depth;
* environmental conditions.

The player should gradually learn that different bodies of water have different life.

---

# 24. Aquatic Creatures Beyond Fish

Underhallow may include:

* frogs;
* turtles;
* crabs;
* shellfish;
* insects;
* amphibians;
* other aquatic or semi-aquatic animals.

Rare strange aquatic creatures may exist.

Aquatic wildlife should reinforce the importance of Underhallow's waterways.

---

# 25. Wildlife and Environment

Creature populations must respect `BE-001`.

Examples:

### Farmland

* chickens;
* insects;
* field birds;
* rabbits;
* small mammals;
* livestock.

### Meadows

* butterflies;
* bees;
* birds;
* rabbits;
* grazing animals.

### Woodland

* deer;
* foxes;
* birds;
* small mammals;
* insects.

### Ancient Forest

* unusual flora/fauna;
* older species;
* rare wildlife;
* strange behavior;
* mystery-linked creatures.

### Highlands

* birds;
* mountain-adapted animals;
* grazing wildlife;
* species suited to exposed terrain.

### Rivers & Valleys

* fish;
* amphibians;
* water birds;
* insects;
* animals gathering around water.

### Lakes & Ponds

* fish;
* frogs;
* insects;
* water birds;
* aquatic creatures.

### Coast

* seabirds;
* fish;
* shellfish;
* coastal mammals;
* tide-related wildlife.

### Wetlands

* amphibians;
* insects;
* birds;
* fish;
* reptiles;
* unusual species.

### Caves

* bats;
* insects;
* subterranean organisms;
* rare strange life.

### Ruins

Wildlife should often reclaim abandoned civilization.

Examples:

* birds nesting in towers;
* foxes occupying old structures;
* vegetation growing through masonry;
* insects living in forgotten rooms.

---

# 26. Strange Wildlife

Strange wildlife represents the first meaningful break from ordinary nature.

Strangeness may manifest through:

### Appearance

An animal may have an unusual physical characteristic.

### Behavior

An animal may behave in a way that cannot be easily explained.

### Habitat

A creature may appear somewhere it should not naturally exist.

### Intelligence

A creature may display unusual awareness.

### History

A creature may be connected to ancient records or folklore.

### Environment

Its presence may affect nearby vegetation, weather, water, or other wildlife.

### Biology

Its physical existence may appear inconsistent with ordinary biology.

### Space or Time

A creature may appear connected to an anomalous location.

Not every strange creature needs every category.

---

# 27. Strange Wildlife Progression

Creature strangeness follows the environmental progression:

**Ordinary → Notable → Strange → Impossible**

### Ordinary

Normal recognizable wildlife.

### Notable

Rare, beautiful, unusually old, unusually patterned, or otherwise memorable but explainable creatures.

### Strange

Creatures or behaviors that challenge expectations.

### Impossible

Creatures that appear to violate established rules of the world.

The progression should remain uneven.

The player should encounter large amounts of ordinary wildlife between unusual discoveries.

---

# 28. Strange Wildlife Distribution

Strange wildlife should be concentrated in environments with high mystery potential.

Strong environments include:

1. Ancient Forest
2. Deep Caves
3. Wetlands
4. Rocky Coves & Cliffs
5. Ruin Environments

Secondary environments include:

* Highlands;
* Rivers;
* Lakes;
* Coast;
* specialized micro-environments.

However:

> **Anomalies may appear anywhere.**

An ordinary meadow can contain something strange.

That possibility helps preserve uncertainty.

---

# 29. Impossible Wildlife

Impossible creatures are extremely rare.

Their appearance should represent a significant moment.

Examples could include:

* an animal appearing in impossible geography;
* a creature behaving as though it remembers another time;
* a species believed extinct;
* an animal existing in two places under unusual circumstances;
* an organism whose biology cannot be reconciled with known nature;
* a creature associated with impossible spaces.

These encounters should not become routine.

---

# 30. Wildlife and the Ancient History

Wildlife may contain evidence of Underhallow's ancient past.

Possible connections include:

* ancient species;
* unusual migration patterns;
* old names preserved in folklore;
* animals depicted in ruins;
* creatures associated with ancient traditions;
* animals behaving differently near ancient sites;
* species mentioned in old journals;
* biological anomalies around ancient structures.

However:

> **Not every creature is connected to the ancient civilization.**

Some animals are simply animals.

---

# 31. Wildlife and Local Folklore

NPCs should be an important source of wildlife knowledge.

Different communities may have:

* local names;
* stories;
* warnings;
* hunting traditions;
* superstitions;
* songs;
* children's stories;
* old observations;
* conflicting explanations.

The player should sometimes encounter conflicting interpretations.

One villager may say:

> “It's just an old forest deer.”

Another may insist:

> “My grandmother said you should never follow one after sunset.”

Neither statement necessarily provides the complete truth.

---

# 32. Wildlife Known to Locals

Some animals should be familiar to Underhallow residents while being unknown to the player.

This reinforces the player's outsider status.

A creature may be:

* ordinary to one region;
* rare to another;
* completely unknown to the player;
* known under a local name;
* surrounded by local traditions.

This allows wildlife to reinforce regional identity.

---

# 33. Bestiary / Wildlife Journal

Underhallow should include a wildlife journal/bestiary.

It should function primarily as a **field journal**, not a completion checklist.

Entries may record:

* species;
* habitat;
* behavior;
* sightings;
* variants;
* local names;
* folklore;
* unusual observations;
* known resources;
* environmental relationships;
* mystery clues.

Some information should be discovered rather than automatically revealed.

The journal should be capable of recording uncertainty.

For example:

**Species:** Unknown
**Location:** Ancient Forest
**Observation:** Appeared briefly near the old stone marker
**Local explanation:** None recorded
**Player note:** “It looked at me before disappearing.”

This supports the game's mystery philosophy.

---

# 34. Wildlife & Exploration

Wildlife should support the Explorer role strongly.

Explorers may seek:

* rare species;
* unusual habitats;
* nesting areas;
* migration patterns;
* strange creatures;
* hidden wildlife locations;
* environmental anomalies.

Exploration rewards may be:

* journal entries;
* knowledge;
* visual encounters;
* folklore;
* resources;
* access to hidden locations;
* mystery clues.

Not every exploration reward needs economic value.

---

# 35. Wildlife & Collection

Collection is supported but should not become mandatory completion content.

Players may enjoy:

* identifying species;
* documenting variants;
* discovering rare creatures;
* completing portions of the journal.

However:

> **The player should never need to collect every animal to experience Underhallow properly.**

---

# 36. Wildlife Population Recovery

Wildlife populations use a mixed recovery model.

Some wildlife should regenerate normally.

Some species should have local population limits.

Heavy player activity may temporarily reduce local sightings.

Populations should recover through:

* time;
* migration;
* breeding;
* environmental recovery;
* player absence.

The player should not normally be able to permanently destroy an ordinary wildlife population through ordinary gameplay.

---

# 37. Player Impact on Wildlife

The player may influence local wildlife.

Examples:

* hunting reduces sightings temporarily;
* development changes habitats;
* farming attracts some species;
* clearing land removes habitat;
* preserving natural areas attracts wildlife;
* water conditions affect aquatic life;
* building may create or destroy nesting opportunities.

This makes Personal Island development part of the ecological world.

---

# 38. Personal Island Wildlife

Personal Island should become increasingly alive as it develops.

Wildlife may respond to:

* preserved vegetation;
* ponds;
* gardens;
* trees;
* flowers;
* buildings;
* livestock;
* player activity;
* environmental conditions.

A player who preserves natural areas should gradually notice more wildlife.

This creates a meaningful relationship between:

**Building → Nature → Wildlife → Home**

---

# 39. Wildlife & Mystery

Wildlife is one of several channels through which Underhallow's deeper mystery can surface.

Mystery-related wildlife may:

* appear where it should not;
* behave strangely;
* disappear unexpectedly;
* interact with ancient locations;
* appear in old records;
* be known to secretive families;
* respond to unusual environmental conditions;
* connect otherwise unrelated locations.

But the system must preserve ambiguity.

The player should never be able to assume:

> “Strange animal = main story clue.”

Sometimes it is.

Sometimes it is not.

---

# 40. Wildlife Should Not Explain the Mystery

Wildlife can provide evidence.

It should rarely provide definitive explanations.

A strange creature might tell the player:

> Something is wrong here.

It should not necessarily tell the player:

> Here is exactly what happened 800 years ago.

Wildlife supports discovery rather than replacing narrative investigation.

---

# 41. Creature Encounters

Creature encounters should exist on a spectrum.

### Ordinary Encounter

The player sees an animal in its natural environment.

### Memorable Encounter

The player witnesses unusual behavior or a rare species.

### Strange Encounter

The player sees something that does not quite make sense.

### Impossible Encounter

The player witnesses something that fundamentally challenges their understanding of Underhallow.

The emotional progression should generally be:

**“There are animals here.”**

→ **“I've never seen that before.”**

→ **“That's strange.”**

→ **“What did I just see?”**

---

# 42. The Ideal Strange Encounter

The most memorable creature encounters should create multiple simultaneous feelings:

* beauty;
* surprise;
* curiosity;
* uncertainty;
* recognition;
* mystery;
* restraint.

A particularly strong encounter may make the player think:

> **“That's beautiful.”**

followed by:

> **“What the hell is that?”**

followed by:

> **“I've never seen anything like this.”**

followed by:

> **“That probably means something.”**

and finally:

> **“…maybe I should leave it alone.”**

This is a core emotional target for high-level wildlife encounters.

---

# 43. Creature Art Direction

Creature visuals follow `AD-001`.

The baseline is:

> **Stylized-realistic pixel art with stronger stylization as creatures become increasingly strange.**

Ordinary animals should be:

* recognizable;
* believable;
* expressive enough to feel alive;
* visually cohesive;
* appropriately detailed.

Strange creatures may progressively violate familiar visual expectations.

Impossible creatures may become visually difficult to classify while retaining enough recognizable structure for the player to understand that they are living creatures.

---

# 44. Creature Expressiveness

Ordinary animals should use moderate expressiveness.

Expression should primarily come through:

* posture;
* movement;
* ears;
* eyes;
* head movement;
* body language;
* proximity;
* retreat;
* curiosity.

Animals should not normally have cartoon facial expressions.

Strange creatures may communicate unusual awareness through behavior rather than exaggerated faces.

---

# 45. Creature Silhouettes

Creature silhouettes should be readable.

Players should be able to distinguish major species at practical viewing distance.

Rare creatures may intentionally have unusual silhouettes.

However:

> Readability must remain stronger than decorative detail.

---

# 46. Wildlife Sound

Audio will be governed by `AU-001`, but creature design must support:

* birdsong;
* insects;
* frogs;
* animal calls;
* footsteps;
* rustling;
* splashing;
* distant wildlife;
* environmental silence.

Wildlife should contribute to the sense that the world continues beyond the visible screen.

---

# 47. Wildlife and Weather

Weather may influence:

* animal activity;
* visibility;
* sheltering;
* feeding;
* movement;
* aquatic activity;
* insect presence;
* bird behavior.

Strong storms may temporarily change the sound and visual population of an area.

Fog may make wildlife encounters feel more mysterious.

Rain may increase amphibian and insect activity.

These relationships should remain believable rather than simulated exhaustively.

---

# 48. Wildlife and Time

Time of day should influence creature presence.

Some species should be:

* diurnal;
* nocturnal;
* crepuscular;
* context-dependent.

This gives exploration different character at different times.

A location visited at noon should not necessarily feel identical at midnight.

---

# 49. Wildlife and Human Civilization

Human settlements affect wildlife.

Near town:

* domesticated animals are common;
* wild animals are more cautious;
* birds and small creatures remain abundant;
* human food and structures influence behavior.

Further from civilization:

* wildlife becomes more varied;
* populations may increase;
* dangerous animals become more plausible;
* unusual creatures become more possible.

Deep wilderness should feel increasingly independent from civilization.

---

# 50. Wildlife and Regional Identity

Regional wildlife should help distinguish Underhallow's regions.

A region should not merely have a different visual palette.

Its wildlife community should contribute to:

* sound;
* movement;
* ecological identity;
* activities;
* folklore;
* exploration;
* local culture.

Regional differences should be recognizable through wildlife as well as geography.

---

# 51. Wildlife and the Player's Identity

Wildlife supports multiple ways of living.

### Farmer

* livestock;
* farm wildlife;
* beneficial insects;
* domestic animals;
* preserving habitat.

### Hunter

* tracking;
* animal knowledge;
* hunting;
* processing;
* wilderness exploration.

### Explorer

* rare species;
* unusual habitats;
* field journal;
* strange encounters.

### Builder

* designing habitats;
* preserving nature;
* creating spaces that attract wildlife.

### Collector

* documenting species;
* finding variants;
* completing portions of the journal.

### Fisher

* discovering distinct aquatic communities;
* understanding water bodies;
* rare fish.

### Trader

* animal products;
* livestock;
* processed goods;
* specialist markets.

### Mixed Player

No system should require the player to specialize permanently.

---

# 52. Wildlife and Home

Personal Island wildlife should reinforce the emotional progression of the player's home.

Early:

> Quiet, sparse, undeveloped.

Middle:

> Growing farm, domestic animals, gardens, natural habitats, more life.

Late:

> A recognizable personal ecosystem reflecting the player's choices.

The player should eventually look across their island and recognize that:

> **This place tells my story.**

---

# 53. What Wildlife Must Never Become

Underhallow must never:

* treat every animal as a disposable resource container;
* make hunting the default interaction;
* turn every animal into an enemy;
* require players to hunt to progress;
* make every strange creature a quest;
* explain every strange creature;
* turn the bestiary into mandatory checklist content;
* fill every environment with excessive wildlife;
* make wildlife visually noisy;
* make every unusual animal secretly part of the main mystery;
* make cute animals mechanically meaningless;
* reduce ecosystems to resource-spawn tables;
* use supernatural creatures so frequently that they become ordinary.

The central prohibition is:

> **Wildlife must never exist solely as disposable resource containers.**

---

# 54. Design Boundary: Cute vs Meaningful

Underhallow may contain cute animals.

But cuteness should not be the entire purpose of animal design.

A creature can be:

* cute;
* useful;
* atmospheric;
* funny;
* strange;
* emotionally meaningful;
* ecologically appropriate.

These qualities should coexist.

---

# 55. Design Boundary: Realism vs Fantasy

Underhallow uses a grounded-to-mysterious progression.

### Ordinary

Biologically believable.

### Notable

Unusually beautiful, rare, old, or distinctive.

### Strange

Difficult to reconcile with ordinary expectations.

### Impossible

Potentially incompatible with known reality.

The game should not jump directly from ordinary rabbit to cosmic monster.

---

# 56. Design Boundary: Mystery vs Explanation

The creature system should preserve uncertainty.

Some questions should have answers.

Some should have incomplete answers.

Some should have competing answers.

Some should remain unanswered.

The player should sometimes finish a creature entry knowing **less than they expected**.

That is intentional.

---

# 57. Long-Term Wildlife Experience

After approximately 20 hours, the player should:

* recognize common wildlife;
* understand several habitats;
* have encountered ordinary and notable species;
* begin recognizing local patterns;
* have begun filling their journal.

After approximately 100 hours, the player should:

* know the major wildlife communities;
* understand regional differences;
* have developed preferences and relationships with animals;
* have discovered rare creatures;
* still encounter things they have never seen;
* still encounter wildlife they cannot fully explain.

The world should retain ecological discovery.

---

# 58. Canonical Creature Encounter

The ideal late-game encounter is:

> The player enters a deep Ancient Forest area they have visited before.

They recognize the environment.

They know the ordinary wildlife.

Then something unfamiliar appears.

It is beautiful.

It does not behave like any known animal.

It does not attack.

It watches the player.

It disappears into a place the player knows should not be accessible.

The player is left with a journal entry, a memory, and a question.

No quest marker appears.

No achievement announces it.

The game simply trusts the player to remember.

---

# 59. Downstream Contracts

CW-001 establishes requirements for downstream specifications.

### `LA-001` — Livestock & Animal Husbandry

Must specialize:

* livestock identity;
* animal care;
* production;
* personality;
* bonding;
* breeding where appropriate;
* farm integration.

### `HU-001` — Hunting & Combat

Must specialize:

* hunting mechanics;
* weapons/tools;
* tracking;
* animal encounters;
* damage;
* resource acquisition.

It must preserve the hunting philosophy defined here.

### `FI-001` — Fishing

Must specialize aquatic capture mechanics and fish progression while respecting regional aquatic identity.

### `FR-001` — Foraging & Wild Resources

Must account for creature/environment relationships where relevant.

### `EX-001` — Exploration & Secrets

Must incorporate rare creature encounters as possible exploration rewards.

### `ML-001` — Mystery & Lore Architecture

Must define how wildlife-related mysteries connect to the larger mystery structure.

### `NC-001` — Narrative Content Framework

Must support wildlife-related NPC dialogue, folklore, quests, rumors, and environmental storytelling.

### `RW-001` — Regional World

Must assign regionally appropriate wildlife communities.

### `WE-001` — Weather & Environmental Systems

Must define weather effects on wildlife behavior where mechanically appropriate.

### `TS-001` — Time, Day/Night & Simulation

Must define time-based creature activity.

### `AU-001` — Audio & Music Direction

Must incorporate wildlife soundscapes.

---

# 60. Implementation Philosophy

Wildlife implementation should prioritize **perceived life over simulation complexity**.

If a simple system creates the impression of believable behavior, it is preferable to a complex simulation that provides little visible benefit.

Priority order:

1. Correct environmental placement
2. Believable movement
3. Appropriate reactions
4. Time/weather variation
5. Visible ecological relationships
6. Population variation
7. Rare behavioral complexity
8. Strange/impossible behaviors

The player should experience the result, not the simulation.

---

# 61. Acceptance Criteria

CW-001 should be considered successfully implemented at the design level when:

* ordinary wildlife feels believable;
* wildlife varies meaningfully by environment;
* passive wildlife is valuable;
* hunting is a valid but non-mandatory activity;
* livestock contributes meaningfully to Personal Island identity;
* pets feel distinct from livestock;
* aquatic life differentiates water environments;
* wildlife supports exploration;
* the field journal provides discovery value;
* populations feel dynamic without requiring hardcore simulation;
* strange wildlife is rare;
* impossible wildlife is extremely rare;
* wildlife can contribute to mystery without becoming the mystery itself;
* creature visuals remain consistent with AD-001;
* wildlife supports multiple player identities;
* the player can encounter animals without needing to interact mechanically;
* the world feels alive even when the player is doing nothing.

---

# 62. Canonical Wildlife Statements

### Core Statement

> **Wildlife should feel like the island has a life of its own, whether or not the player is there.**

### Hunting Statement

> **Hunting is an activity within nature, not the reason nature exists.**

### Mystery Statement

> **Some creatures are ordinary, some are strange, and a very small number should make the player question what they thought they understood about the island.**

### Exploration Statement

> **Wildlife should reward attention without becoming a navigation system or checklist.**

### Home Statement

> **The player's choices should gradually shape not only the land they live on, but the life that lives there.**

### Final Creature Philosophy

> **Underhallow's wildlife should make the island feel alive before it makes the island feel mysterious. The ordinary creates the foundation for the strange; the strange creates the possibility of the impossible.**

---

# 63. Final Specification Principle

Underhallow's wildlife should ultimately create a simple feeling:

> **“These animals were here before me, they will continue living when I leave, and sometimes I may see something I cannot explain.”**

That is the creature philosophy of Underhallow.

**Ordinary life first.
Mystery second.
Wonder always.**
