# UNDERHALLOW

# Biome & Environment Bible V1.1 — Specification Pass

**Document ID:** BE-001
**Status:** DRAFT — SPECIFICATION PASS
**Version:** 1.1
**Project:** Underhallow
**Authority Level:** Level 1 — Foundation Specification
**Parent Specifications:**

* `NS-001` — North Star V1.0
* `CD-001` — Creative Direction V1.0
* `AD-001` — Art Direction Bible V1.0
* `WB-001` — World Bible V1.0
* `NB-001` — Narrative Bible V1.0
* `CB-001` — Character Bible V1.0
* `WM-001` — World & Map Architecture V1.0
* `MI-001` — Main Island Design Specification V1.0
* `PI-001` — Personal Island Design Specification V1.0

**Related Downstream Specifications:**

* `CW-001` — Creature & Wildlife Bible
* `ML-001` — Mystery & Lore Architecture
* `NC-001` — Narrative Content Framework
* `RW-001` — Regional World Specifications
* `EX-001` — Exploration & Secrets
* `FR-001` — Foraging & Wild Resources
* `RG-001` — Resource Gathering, Forestry & Mining
* `FI-001` — Fishing
* `TS-001` — Time, Day/Night & Simulation
* `WE-001` — Weather & Environmental Systems
* `AU-001` — Audio & Music Direction Bible

---

## 0. Specification Pass Purpose

This pass reconciles and strengthens the existing `BE-001 — Biome & Environment Bible V1.0`.

It does **not** replace the approved environmental creative direction.

It converts the existing environmental philosophy into a stronger governing specification capable of guiding downstream implementation and creative documents.

The following principles remain canonical:

> **Underhallow's environments should feel like places, not levels.**

and:

> **Cozy surface. Mystical middle. Deep mystery underneath.**

The environment system must remain:

**Geographically coherent → Ecologically believable → Visually distinct → Mechanically meaningful → Atmospherically memorable → Historically layered → Occasionally mysterious.**

This pass establishes the additional structure required to maintain that philosophy as the world expands.

---

# 1. Environmental Authority

BE-001 governs:

* environmental identity;
* biome classification;
* environmental hierarchy;
* geographic relationships between environments;
* ecological identity;
* visual environmental differentiation;
* environmental gameplay affordances at the design level;
* environmental atmosphere;
* environmental history;
* environmental mystery language;
* environmental transitions;
* environmental landmark principles;
* environmental density;
* environmental progression;
* regional environmental composition.

BE-001 does **not** own the implementation details of:

* wildlife AI;
* fishing mechanics;
* weather simulation;
* time simulation;
* resource spawning algorithms;
* foraging mechanics;
* mining/forestry systems;
* exploration progression;
* narrative quest implementation;
* audio implementation;
* building placement;
* regional social structures.

Those systems must specialize the environmental rules established here rather than independently redefining them.

---

# 2. Environmental Hierarchy

Underhallow uses a layered environmental hierarchy.

## 2.1 Hierarchy

The canonical structure is:

**Environmental Family → Biome → Sub-Biome → Ecotone → Micro-Environment → Landmark**

### Environmental Family

A broad environmental category sharing a major geographic/ecological identity.

Examples:

* Woodland
* Wetland
* Coast
* Highlands
* Underground

### Biome

A recognizable environmental identity within that family.

Example:

**Coast → Beach**

### Sub-Biome

A meaningful ecological or geographic variation within a biome.

Example:

**Coast → Beach → Sheltered Beach**

Sub-biomes should only exist when they create meaningful environmental differentiation.

### Ecotone

A transition between environmental identities.

Examples:

* woodland edge;
* river meadow;
* coastal marsh;
* highland woodland;
* wet woodland;
* forest/farmland boundary.

Ecotones are first-class world-building elements rather than empty borders.

### Micro-Environment

A small environmental pocket with a distinct local identity.

Examples:

* flower clearing;
* hidden pond;
* abandoned orchard;
* moss-covered ruin;
* secluded cove;
* spring-fed pool.

### Landmark

A visually or narratively significant environmental feature used for navigation, identity, history, or discovery.

---

# 3. Canonical Environmental Families

The following environmental families are canonical.

1. Farmland
2. Meadows
3. Woodland
4. Ancient Forest
5. Hills & Highlands
6. Rivers & Valleys
7. Lakes & Ponds
8. Coast & Beaches
9. Rocky Coves & Cliffs
10. Wetlands & Marsh
11. Caves & Underground
12. Ruin Environments
13. Specialized Micro-Environments

These are **environmental vocabularies**, not mandatory map zones.

A region may contain multiple families.

A single family may appear differently across several regions.

No region should feel like it exists solely to justify the presence of another biome.

---

# 4. Canonical Biome Identity Matrix

Every major environment must possess a distinct identity across multiple dimensions.

| Environment                    | Primary Feeling        | Typical Ecology                              | Core Activities                            | Traversal Character     | Historical Potential | Mystery Potential |
| ------------------------------ | ---------------------- | -------------------------------------------- | ------------------------------------------ | ----------------------- | -------------------- | ----------------- |
| Farmland                       | Warmth, belonging      | Crops, domestic animals, field wildlife      | Farming, gathering, trading                | Open, accessible        | High                 | Low–Medium        |
| Meadows                        | Freedom, openness      | Grass, flowers, insects, small wildlife      | Exploration, gathering, movement           | Open, easy              | Low–Medium           | Low–Medium        |
| Woodland                       | Shelter, familiarity   | Trees, understory, forest wildlife           | Gathering, hunting, exploration            | Moderately dense        | Medium               | Medium            |
| Ancient Forest                 | Beauty, age, curiosity | Ancient trees, rich flora, unusual wildlife  | Exploration, gathering, hunting, discovery | Dense, layered          | High                 | High              |
| Hills/Highlands                | Perspective, exposure  | Highland flora, birds, grazing wildlife      | Exploration, hunting, gathering            | Elevation-dependent     | Medium–High          | Medium–High       |
| Rivers/Valleys                 | Connection, movement   | River ecology, wet vegetation                | Fishing, farming, travel, exploration      | Linear/branching        | High                 | Medium            |
| Lakes/Ponds                    | Quiet, reflection      | Aquatic life, wetland vegetation             | Fishing, gathering, exploration            | Open around water       | Medium               | Medium            |
| Coast/Beaches                  | Distance, openness     | Marine/coastal ecology                       | Fishing, travel, gathering, exploration    | Open + shoreline        | High                 | Medium–High       |
| Rocky Coves/Cliffs             | Isolation, discovery   | Coastal rock ecology                         | Exploration, fishing, traversal            | Constrained/vertical    | High                 | High              |
| Wetlands/Marsh                 | Lushness, isolation    | Reeds, amphibians, insects, wetland wildlife | Fishing, gathering, exploration            | Slow/irregular          | Medium–High          | High              |
| Caves/Underground              | Depth, uncertainty     | Cave ecology, minerals, subterranean life    | Mining, exploration, gathering, discovery  | Constrained/depth-based | Very High            | Very High         |
| Ruin Environments              | Absence, history       | Environment reclaiming civilization          | Exploration, lore, discovery               | Variable                | Very High            | Very High         |
| Specialized Micro-Environments | Local identity         | Context-dependent                            | Context-dependent                          | Context-dependent       | Variable             | Variable          |

This matrix is a **design constraint**, not a rigid implementation table.

A location may break expectations when there is a deliberate reason.

---

# 5. Environmental Identity Requirements

A major environment should differ from another through a meaningful combination of:

1. Visual identity
2. Flora
3. Wildlife
4. Resources
5. Traversal
6. Atmosphere
7. Environmental interactions
8. Human presence
9. Historical context
10. Mystery potential

No biome should be differentiated only by color palette.

No biome should be differentiated only by resource drops.

No biome should exist solely because the game requires another environment type.

---

# 6. Gameplay Affordance Matrix

Environmental identity must translate into gameplay opportunities.

| Environment        |    Farming |     Hunting |    Fishing |  Gathering |   Building | Exploration | Social/Human Presence |
| ------------------ | ---------: | ----------: | ---------: | ---------: | ---------: | ----------: | --------------------: |
| Farmland           |       High |  Low–Medium | Low–Medium |     Medium |       High |      Medium |                  High |
| Meadows            |     Medium |      Medium |        Low |       High |     Medium |        High |                Medium |
| Woodland           | Low–Medium |        High |     Medium |       High | Low–Medium |        High |            Low–Medium |
| Ancient Forest     |        Low |        High | Low–Medium |       High |        Low |   Very High |                   Low |
| Highlands          |        Low |        High | Low–Medium |     Medium |        Low |   Very High |                   Low |
| Rivers/Valleys     |     Medium |      Medium |       High |       High |     Medium |        High |           Medium–High |
| Lakes/Ponds        | Low–Medium |      Medium |       High |     Medium | Low–Medium | Medium–High |            Low–Medium |
| Coast              | Low–Medium |      Medium |  Very High |     Medium |     Medium |        High | High in settled areas |
| Coves/Cliffs       |        Low |      Medium |       High |     Medium |        Low |   Very High |                   Low |
| Wetlands           | Low–Medium | Medium–High |       High |  Very High |        Low |        High |                   Low |
| Underground        |   None/Low |      Medium | Contextual |       High |        Low |   Very High |              Very Low |
| Ruins              |   None/Low |  Contextual | Contextual | Contextual |        Low |   Very High |              Variable |
| Micro-Environments | Contextual |  Contextual | Contextual | Contextual | Contextual |        High |            Contextual |

These values indicate **design emphasis**, not mandatory availability.

For example, fishing may technically be possible in several environments while remaining most strongly associated with rivers, lakes, and coastlines.

---

# 7. Biome Identity Profiles

Every major biome added to Underhallow must be capable of answering the following questions:

### Identity

* What does this place feel like?
* What makes it immediately recognizable?

### Geography

* Why does this environment exist here?
* What terrain produces it?

### Ecology

* What naturally grows here?
* What lives here?
* What ecological relationships are visible?

### Human Relationship

* How have people interacted with this environment?
* Is it cultivated, settled, avoided, exploited, protected, or forgotten?

### Gameplay

* What activities naturally belong here?
* What traversal characteristics distinguish it?

### History

* What traces of the past can exist here?

### Mystery

* What level of strange or unexplained content is appropriate?

### Navigation

* What landmarks or environmental structures help players understand where they are?

### Atmosphere

* What should the player feel without requiring explicit narrative?

If a proposed biome cannot answer these questions, it should probably remain a sub-biome, micro-environment, or visual variation rather than becoming a new major biome.

---

# 8. Environmental Differentiation Rule

Two environments are not sufficiently different merely because they use different art assets.

Two environments should have different combinations of:

**Look + Feel + Ecology + Activity + Traversal + Context.**

For example:

A woodland and Ancient Forest may both contain trees.

They remain distinct because the Ancient Forest has:

* substantially older vegetation;
* different canopy structure;
* deeper ecological density;
* stronger environmental history;
* rarer flora;
* different wildlife patterns;
* stronger mystery potential;
* increasingly unusual spatial characteristics.

This prevents biome proliferation without meaningful differentiation.

---

# 9. Ecological Relationship Rules

Underhallow uses **believable abstraction**, not hardcore simulation.

Environmental systems should create the impression of ecological relationships without simulating every biological process.

Examples:

* wetlands support amphibians and insects;
* forests support woodland wildlife;
* coastlines support marine/coastal wildlife;
* highlands support elevation-appropriate flora and fauna;
* rivers support aquatic ecosystems;
* human settlements alter nearby ecology;
* farmland attracts certain wildlife while discouraging others;
* weather changes environmental activity;
* time changes environmental activity.

The player should learn these relationships through observation rather than tutorials whenever practical.

---

# 10. Transition & Ecotone Rules

Transitions must obey physical and ecological logic.

## 10.1 Default

The default transition is gradual.

Examples:

**Farmland → Meadow → Woodland**

**Beach → Coastal Vegetation → Wetland**

**Lowland Woodland → Highland Woodland → Highland Meadow**

## 10.2 Strong Boundaries

Strong environmental boundaries are appropriate when geography naturally creates them.

Examples:

* cliff;
* river;
* coastline;
* cave entrance;
* deep ravine;
* ancient forest threshold.

## 10.3 Unusual Boundaries

A strange environmental boundary may deliberately violate ordinary geography.

These should be:

* rare;
* memorable;
* narratively/environmentally meaningful;
* visually readable.

An impossible boundary should feel like an event in the world, not poor level design.

---

# 11. Regional Composition Rules

A major region should contain an environmental composition rather than one isolated biome.

A typical region may contain:

* a primary environment;
* one or more supporting environments;
* transition zones;
* micro-environments;
* landmarks;
* human influence where appropriate;
* resource patterns;
* wildlife patterns;
* historical traces.

Regional identity emerges from the **relationship between environments**.

For example, a farming region may contain:

**Farmland + Meadows + River + Woodland Edge + Old Farm Ruins**

rather than simply being labeled "Farm Biome."

---

# 12. Environmental Density

Underhallow uses **moderate environmental density**.

The world should generally feel alive without becoming visually noisy.

Density should vary intentionally.

### High-density environments

* Ancient Forest
* Wetlands
* dense Woodland
* some Ruins

### Medium-density environments

* farmland
* river valleys
* coastal settlements
* woodland edges

### Lower-density environments

* meadows
* highland ridges
* beaches
* exposed cliffs

Lower density is not empty design.

Open space can provide:

* readability;
* scale;
* navigation;
* scenic views;
* breathing room;
* emotional contrast.

---

# 13. Environmental Layering

Every major environment should be considered through seven layers:

### Layer 1 — Geography

The physical shape of the place.

### Layer 2 — Ecology

Plants, wildlife, water, and environmental relationships.

### Layer 3 — Visual Identity

Color, materials, vegetation structure, silhouettes, terrain, lighting.

### Layer 4 — Gameplay Identity

Activities and traversal naturally supported by the environment.

### Layer 5 — Atmosphere

Emotional and sensory character.

### Layer 6 — History

Evidence of previous human or natural events.

### Layer 7 — Mystery

Unusual details, anomalies, contradictions, or deeper questions.

The layers should not all have equal weight.

---

# 14. Mystery Density Model

Environmental mystery must be controlled.

The canonical environmental mystery scale is:

## Level 0 — Ordinary

Nothing unusual is required.

Examples:

* normal meadow;
* ordinary farm field;
* familiar woodland path.

## Level 1 — Notable

Something is interesting but entirely explainable.

Examples:

* unusually old tree;
* abandoned structure;
* rare plant;
* unusual rock formation.

## Level 2 — Strange

Something does not fully fit expectations.

Examples:

* animal behavior that seems wrong;
* plant growing in an unlikely location;
* structure whose history does not make sense;
* path appearing to connect places strangely.

## Level 3 — Impossible

The environment appears to violate established physical expectations.

Examples:

* impossible geography;
* altered space;
* impossible depth;
* temporal/environmental echoes;
* places that should not physically connect.

Level 3 environments must remain extremely rare.

---

# 15. Mystery Distribution

Mystery should be:

**Broadly distributed but unevenly concentrated.**

Ordinary environments can contain small anomalies.

Certain places should carry substantially greater mystery density.

Higher mystery density may correlate with:

* Ancient Forest depth;
* underground depth;
* ancient structures;
* abandoned settlements;
* unusual geography;
* isolated areas;
* specific historical locations;
* particular environmental conditions.

Mystery should **not** simply increase with distance from Town.

A nearby strange place may be more important than a distant ordinary one.

---

# 16. Environmental Strangeness Progression

Environmental strangeness should emerge through multiple factors:

* geography;
* depth;
* remoteness;
* history;
* proximity to ancient structures;
* environmental conditions;
* specific locations;
* interaction with other systems.

The canonical progression is:

**Ordinary → Unusual → Strange → Impossible**

This progression may occur:

* across a single location;
* across a connected environment;
* across multiple regions;
* across the player's relationship with the world.

It must never become a simple difficulty ladder.

Strangeness is about **meaning and discovery**, not enemy level.

---

# 17. Ancient Forest Progression

The Ancient Forest receives special environmental treatment.

The intended emotional progression is:

**Beautiful → Old → Curious → Unusual → Strange → Impossible**

The forest should become more distinctive through combinations of:

* older/larger trees;
* increasing canopy density;
* unusual light;
* richer vegetation;
* increasingly unusual wildlife;
* ancient structures;
* strange flora;
* environmental anomalies.

The player should remain attracted to deeper areas rather than feeling that the forest is merely becoming more hostile.

The intended long-term feeling is:

> **“I've been here before, but I still don't understand this place.”**

---

# 18. Underground Progression

The underground follows a separate but related progression:

**Natural Cave → Deeper Cave → Ancient Excavation → Forgotten Structure → Strange Space → Impossible Space**

Early underground spaces should establish believable geology.

Later spaces may reveal that the island's ancient history was more sophisticated than modern inhabitants understand.

Impossible underground spaces should remain rare and significant.

The underground must not become a generic dungeon layer.

---

# 19. Landmark Hierarchy

Environmental landmarks are essential to navigation and world identity.

The canonical hierarchy is:

### Tier 1 — Primary Landmarks

Visible from significant distances.

Examples:

* major tower;
* distinctive natural formation;
* large bridge;
* major cliff;
* enormous tree;
* major harbor structure.

### Tier 2 — Regional Landmarks

Help identify a particular region.

Examples:

* old mill;
* prominent hill;
* distinctive ruin;
* waterfall;
* unusual tree cluster.

### Tier 3 — Local Landmarks

Useful for short-range navigation.

Examples:

* abandoned cabin;
* pond;
* small bridge;
* boulder formation;
* shrine-like structure.

### Tier 4 — Environmental Markers

Small details that help players orient themselves.

Examples:

* fence;
* path intersection;
* tree cluster;
* stream;
* distinctive rock.

### Tier 5 — Secret Landmarks

Discovered through exploration.

Examples:

* hidden ruin;
* secret cave;
* strange tree;
* impossible formation;
* concealed structure.

---

# 20. Landmark Design Rule

Major landmarks should be recognizable without requiring the player to memorize a map.

Where geography permits, major landmarks should be visible from a distance.

Landmarks should also have:

* distinct silhouettes;
* consistent environmental placement;
* meaningful relationship to surrounding terrain;
* navigational value;
* potential historical or narrative value.

A landmark does not need to be important to the story to be important to navigation.

---

# 21. Environmental Storytelling

Environmental storytelling should communicate:

* previous settlement;
* abandoned activity;
* agriculture;
* trade;
* environmental change;
* historical events;
* cultural traditions;
* unexplained phenomena.

Environmental storytelling should frequently remain subtle.

Examples:

* old field boundaries in woodland;
* a road disappearing beneath vegetation;
* foundations beneath modern buildings;
* a tree growing through old masonry;
* fishing structures no longer in use;
* old agricultural patterns;
* objects left where people once lived.

Not every environmental detail should connect to the central mystery.

Some places simply have history.

---

# 22. Nature and Civilization

Underhallow should present civilization and nature as overlapping rather than opposing systems.

The island contains:

* cultivated land;
* managed woodland;
* fishing areas;
* roads;
* bridges;
* settlements;
* abandoned spaces;
* wilderness;
* reclaimed ruins.

Nature can reclaim human spaces.

Humans can shape nature.

Neither should completely dominate the island.

This relationship is part of the world's identity.

---

# 23. Water as Environmental Structure

Water environments must possess distinct identities.

Water may function as:

* ecological habitat;
* navigation structure;
* farming support;
* fishing environment;
* settlement foundation;
* visual landmark;
* traversal obstacle;
* traversal route;
* historical boundary;
* mystery location.

Different water environments should produce meaningful differences in:

* fish;
* vegetation;
* wildlife;
* traversal;
* resources;
* appearance;
* atmosphere;
* storytelling potential.

Water must not be treated as a single generic environmental category.

---

# 24. Weather and Time Relationship

Weather and time are environmental amplifiers.

They may change:

* lighting;
* sound;
* wildlife activity;
* NPC activity;
* water appearance;
* vegetation presentation;
* exploration atmosphere;
* farming presentation.

BE-001 establishes the **creative relationship**.

`TS-001` and `WE-001` own the actual rules and implementation.

Environmental design must remain readable under different lighting and weather conditions.

---

# 25. Seasonal Principles

Seasons are governed by the relevant time/simulation specifications.

BE-001 establishes that seasonal presentation may affect:

* vegetation;
* color;
* weather;
* wildlife;
* farming presentation;
* water;
* environmental atmosphere.

Seasonal changes should reinforce environmental identity rather than repainting the world uniformly.

---

# 26. Personal Island Environmental Rules

The Personal Island is environmentally distinct from the Main Island.

Its environment should initially feel:

* safe;
* familiar;
* peaceful;
* personal;
* manageable;
* naturally beautiful.

It should contain enough wilderness to make development meaningful.

Player development should create a visible dialogue between:

**Nature ↔ Home ↔ Agriculture ↔ Building ↔ Personal Expression**

The Personal Island may eventually connect to the larger mystery.

However:

> **The Personal Island must remain a home before it becomes a mystery location.**

Strangeness should be occasional and meaningful.

---

# 27. Biome and Player Role Relationship

Environmental design must support multiple player identities.

A player may approach the world primarily as:

* farmer;
* hunter;
* fisher;
* builder;
* explorer;
* collector;
* decorator;
* trader;
* mixed-role player.

No biome should require one player identity to be valid.

Instead, different environments should provide different reasons to visit.

For example:

The Ancient Forest may attract:

* hunters through wildlife;
* gatherers through flora;
* explorers through hidden paths;
* historians through ruins;
* curious players through mystery.

This supports Underhallow's open-ended identity.

---

# 28. Environmental Reward Philosophy

Environmental rewards should include more than resources.

Possible rewards include:

* materials;
* rare flora/fauna;
* fishing opportunities;
* scenic discoveries;
* shortcuts;
* landmarks;
* lore;
* NPC knowledge;
* hidden locations;
* objects;
* personal memories;
* environmental revelations;
* experiential discoveries.

Some places should reward the player simply by being beautiful.

Not every discovery needs a monetary or progression reward.

---

# 29. Biome Anti-Repetition Rules

A new environmental area should be rejected or revised if it primarily creates:

* another version of an existing biome;
* another resource spreadsheet;
* another color palette;
* another enemy/resource farm;
* artificial environmental boundaries;
* decorative emptiness;
* unnecessary biome count.

Before creating a new major biome, designers must establish:

1. Why does it exist geographically?
2. What makes its ecology distinct?
3. What does it feel like?
4. What activities belong there?
5. How does traversal differ?
6. What historical relationship does it have to the island?
7. What makes it visually recognizable?
8. Why can't an existing biome/sub-biome fulfill the role?

If the answers are weak, the location should probably remain a variation of an existing environment.

---

# 30. Environmental Composition Rule

Underhallow should favor **combinations of familiar environments** over constant introduction of new ones.

For example:

> Farmland beside a river, transitioning into meadow, then woodland, with an old ruin hidden near the forest edge.

is preferable to:

> Farm biome → River biome → Meadow biome → Forest biome → Ruin biome.

The former feels like a place.

The latter feels like a level sequence.

---

# 31. Environmental Readability

Environmental detail must never destroy gameplay readability.

The player should be able to distinguish:

* walkable terrain;
* obstacles;
* water;
* elevation;
* paths;
* interactables;
* resources;
* buildings;
* NPCs;
* wildlife;
* entrances;
* landmarks;
* hidden routes where appropriate.

Visual richness is subordinate to clarity when the two conflict.

This follows the Art Direction principle:

> **Readability and beauty have equal priority.**

---

# 32. Environmental Beauty Rule

Underhallow should frequently reward the player for simply looking.

Beauty may come from:

* lighting;
* water;
* terrain;
* vegetation;
* weather;
* architecture;
* wildlife;
* distance views;
* seasonal presentation;
* environmental composition.

A scenic location does not need a quest marker.

A player may stop because the world is worth looking at.

This is a valid environmental reward.

---

# 33. Environmental Mystery Rule

Mystery must emerge from a world that already works without it.

Therefore:

> **The strange should be layered onto the believable, not used to replace believability.**

The player should be able to enjoy Underhallow without investigating its mystery.

But attentive players should repeatedly encounter details that suggest:

> Something is not quite right.

Some mysteries may eventually connect.

Others may remain local.

Some may never be explained.

---

# 34. Environmental “Wrong Thing” Principle

Ordinary environments should occasionally contain a detail that feels subtly wrong.

Examples:

* an object in an unlikely location;
* a path that does not appear on local maps;
* an old structure whose architecture does not match its surroundings;
* an animal behaving unusually;
* vegetation growing under impossible conditions;
* an object associated with an event that supposedly happened elsewhere;
* a familiar landmark that seems slightly different.

These details should be:

* uncommon;
* discoverable;
* subtle;
* memorable;
* internally consistent where possible.

The goal is curiosity, not constant fear.

---

# 35. Environmental Mystery Restraint

Mystery loses meaning if everything is mysterious.

Therefore:

* most meadows should simply be meadows;
* most farms should simply be farms;
* most forests should simply be forests;
* most caves should initially behave like caves;
* most wildlife should behave naturally.

The world must establish a strong baseline of normality.

That baseline is what gives anomalies weight.

---

# 36. Environmental Memory

The world should feel as though it existed before the player arrived.

Environmental evidence may survive through:

* abandoned roads;
* old fields;
* ruins;
* altered waterways;
* ancient trees;
* old structures;
* rebuilt settlements;
* inherited objects;
* forgotten paths;
* environmental scars;
* traditions reflected in the landscape.

The player is entering an existing world rather than activating it.

---

# 37. Environmental Change and Player History

Player actions should gradually become part of the landscape.

Examples:

* a developed farm becomes recognizable;
* paths emerge through repeated use where supported;
* buildings alter local composition;
* cleared areas become cultivated;
* restored areas regain ecological identity;
* decorations create a personal visual language;
* old spaces may become associated with player memories.

This supports the Personal Island principle:

> **Personal Island is where the player turns progress into place.**

---

# 38. Environmental Relationship to Narrative

Environmental design should support narrative without becoming a narrative delivery system.

The world can reveal history through:

* architecture;
* ruins;
* landscape;
* vegetation;
* old roads;
* objects;
* environmental anomalies;
* settlement patterns.

`NB-001`, `ML-001`, and `NC-001` own narrative structure and delivery.

BE-001 establishes the environmental vocabulary those systems use.

---

# 39. Environmental Relationship to Wildlife

`CW-001` owns creature definitions, behavior, AI, progression, and wildlife-specific systems.

BE-001 establishes:

* habitat identity;
* ecological plausibility;
* environmental distribution principles;
* visual relationship between wildlife and habitat;
* unusual wildlife escalation;
* environmental reasons for wildlife presence.

Wildlife should make environments feel alive rather than functioning solely as encounter content.

---

# 40. Environmental Relationship to Resources

`FR-001` and `RG-001` own resource rules.

BE-001 establishes that resource distribution should reinforce environmental identity.

Resources should therefore feel like something that belongs where the player finds them.

The player should gradually develop intuitive expectations:

> “If I need this, I probably know where to look.”

Rare resources may break this expectation when justified.

---

# 41. Environmental Relationship to Exploration

`EX-001` owns exploration mechanics and discovery progression.

BE-001 establishes the environmental foundation for exploration:

* layered geography;
* landmarks;
* transitions;
* hidden spaces;
* scenic rewards;
* environmental storytelling;
* unusual locations;
* increasingly strange spaces.

Exploration should be driven primarily by curiosity rather than checklist completion.

---

# 42. Environmental Relationship to Audio

`AU-001` owns implementation and music direction.

BE-001 establishes environmental sound identity.

Examples:

### Meadow

* wind;
* insects;
* birds;
* grasses.

### Woodland

* canopy;
* branches;
* birds;
* wildlife;
* leaves.

### Wetlands

* frogs;
* insects;
* reeds;
* water.

### Coast

* waves;
* wind;
* seabirds;
* harbor activity.

### Caves

* echoes;
* dripping water;
* rock movement;
* distant subterranean sounds.

### Ancient Forest

Familiar forest sounds with subtle anomalies.

Environmental audio should reinforce place recognition.

---

# 43. Environmental Identity Test

Before an environment is considered complete, it must pass the following test.

### Visual Test

Can the player identify the environment from its composition?

### Emotional Test

Does the environment produce a recognizable feeling?

### Ecological Test

Does its flora and wildlife make sense?

### Geographic Test

Does its location make physical sense?

### Gameplay Test

Does it provide meaningful reasons to exist?

### Navigation Test

Can the player orient themselves within it?

### Historical Test

Does it feel like a place with a past?

### Mystery Test

If mystery exists here, does it feel appropriate rather than arbitrary?

### Repetition Test

Does the environment feel sufficiently distinct from nearby environments?

If several answers are no, the environment requires revision.

---

# 44. Canonical Environmental Laws

The following laws are binding creative constraints.

### Law 1

**A biome must feel like a place, not a level.**

### Law 2

**Geography comes before biome labeling.**

### Law 3

**Ecology must support visual identity.**

### Law 4

**Gameplay identity must emerge from the environment rather than being arbitrarily assigned.**

### Law 5

**Transitions should make physical sense.**

### Law 6

**Ordinary environments must remain genuinely ordinary.**

### Law 7

**Mystery must be rare enough to retain meaning.**

### Law 8

**Beautiful environments are allowed to exist without mechanical justification.**

### Law 9

**Not every environmental detail needs lore.**

### Law 10

**Not every mystery needs an explanation.**

### Law 11

**The player can influence nature but cannot completely rewrite geography.**

### Law 12

**Environmental density must serve readability.**

### Law 13

**Landmarks must support navigation as well as aesthetics.**

### Law 14

**Biome variety must not become biome bloat.**

### Law 15

**No biome exists solely because the game needs another biome.**

### Law 16

**Strangeness should make the believable world more interesting, not make the believable world irrelevant.**

---

# 45. Canonical Environmental Identity

Underhallow's environment should consistently communicate:

> **A warm, beautiful, lived-in world where nature and civilization coexist — with something much older and stranger beneath the surface.**

The player should be able to spend hours simply:

* farming;
* walking;
* fishing;
* hunting;
* gathering;
* building;
* visiting town;
* watching wildlife;
* exploring;
* decorating home;
* discovering scenic places.

The deeper environmental mystery exists underneath that life.

It should not consume every environment.

---

# 46. Long-Term Environmental Experience

At approximately 20 hours, the player should understand the major environmental vocabulary of Underhallow.

They should recognize:

* farmland;
* meadow;
* woodland;
* coast;
* wetlands;
* highlands;
* major waterways;
* major town environments.

At approximately 100 hours, the player should understand the island deeply.

But they should still encounter:

* unexpected places;
* hidden environmental stories;
* unfamiliar micro-environments;
* unexplained anomalies;
* beautiful locations they had never noticed;
* mysteries that resist complete explanation.

The world should reward familiarity without becoming completely exhausted by it.

---

# 47. The 100-Hour Environmental Feeling

The intended long-term environmental feeling is:

> **“I've been here before, but I still don't fully understand this place.”**

The player should feel simultaneously:

* familiarity;
* ownership;
* comfort;
* curiosity;
* wonder;
* uncertainty.

This is one of the defining environmental experiences of Underhallow.

---

# 48. Downstream Specification Contract

The following specifications must treat BE-001 as environmental authority:

### `CW-001`

Must use BE-001 for habitat and environmental identity.

### `ML-001`

Must use BE-001's mystery-density and strangeness model.

### `NC-001`

Must use environmental history and environmental storytelling principles.

### `RW-001`

Must compose regions using BE-001's environmental hierarchy.

### `EX-001`

Must use environmental landmarks, micro-environments, transitions, and discovery principles.

### `FR-001`

Must use environmental ecology and flora identity.

### `RG-001`

Must distribute resources according to environmental identity.

### `FI-001`

Must distinguish aquatic environments according to BE-001.

### `TS-001`

Must preserve environmental readability across time-of-day and seasonal changes.

### `WE-001`

Must treat weather as an environmental amplifier.

### `AU-001`

Must establish distinct environmental sound identities.

---

# 49. Authority Boundaries

When conflicts occur:

* `AD-001` governs visual/art direction.
* `WB-001` governs world canon.
* `NB-001` governs narrative canon.
* `BE-001` governs environmental identity and ecological/world-environment relationships.
* `PI-001` governs Personal Island-specific design.
* `MI-001` governs Main Island spatial/world composition.
* downstream system specifications govern implementation details within their domain.

No downstream specification should redefine the canonical environmental philosophy without an explicit reconciliation pass.

---

# 50. Final Environmental Statement

Underhallow's environments are not a collection of biomes.

They are a continuous world shaped by geography, ecology, history, people, weather, time, memory, and mystery.

A meadow should be worth visiting because it is beautiful.

A forest should be worth entering because it feels alive.

A river should matter because it connects the world.

A coastline should remind the player that somewhere beyond the island is a larger world.

A ruin should make the player wonder who was here.

A cave should make the player wonder how deep the island goes.

An Ancient Forest should make the player feel that they have entered somewhere old enough to remember things nobody else does.

And, occasionally, the environment should make the player stop and think:

> **“That shouldn't be possible.”**

Then the world should allow them to keep walking.

That balance is the environmental identity of Underhallow.

> **Underhallow should feel like a place you could spend years getting to know rather than a map you are expected to complete.**
