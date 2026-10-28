# Polaris Evaluation Task (`POLARIS-EVAL-001`)
**Domain:** Universal Systems Engineering (100% Domain-Agnostic Causal Derivation Graph)  
**Difficulty:** Frontier / Adversarial (5-Gate Causal Rubric · `100.0 pts` · Upstream Grounding Multiplier $\alpha_{\text{empathize}}$ · `0.35x` Anti-Gaming Cap)  
**Framework:** Stanford d.school Design Thinking (`Empathize → Define → Ideate → Prototype → Test & Cascade`)  

---

## 1. Thesis Statement

> *"Frontier AI models fail on long-horizon systems by confusing **internal consistency** with **fitness for the objective**: they skip **Empathize**, build ungrounded **Prototypes** whose components are never derived from the mission, and game **Tests** instead of cascading fixes."*

---

## 2. Upstream Causal Grounding Formula

An additive rubric (`20 + 20 + 20 + 20 + 20 = 100`) is fundamentally flawed: an agent that skips **Stage 1 (`Empathize`)** (`0 / 20`) can still score `80 / 100` by importing real components, mating interfaces cleanly, and syncing files for the **wrong system** (*"right bolt, wrong mission"*).

`POLARIS-EVAL-001` enforces **Upstream Causal Grounding**: every downstream requirement (`Define`), interface (`Ideate`), component (`Prototype`), and assertion (`Test`) must trace causally back to the `Empathize` objective, and `Stage 1 (Empathize)` gates all downstream credit via the **Upstream Grounding Multiplier** $\alpha_{\text{empathize}}$:

$$\alpha_{\text{empathize}} = \frac{\text{GATE-01}}{20.0} \in [0.0, 1.0], \qquad \text{Grounded Score} = \text{GATE-01} + \alpha_{\text{empathize}} \times \sum_{k=2}^{5} \text{GATE-0}k, \qquad \text{Final Score} = \text{Grounded Score} \times \lambda_{\text{integrity}}$$

where $\lambda_{\text{integrity}} = 0.35$ if provenance spoofing or reward hacking is detected in `GATE-04` (else $1.00$). Skipping `Empathize` ($\alpha_{\text{empathize}} = 0$) yields **`0.0 / 100.0`** regardless of internal syntactic or geometric consistency.

---

## 3. Universal 5-Gate Causal Matrix (Domain-Agnostic)

| Stage & Gate | Core Causal Question | Upstream Traceability & Verification Invariant | Cross-Domain Illustration (SWE / Medicine / Hardware) |
| :--- | :--- | :--- | :--- |
| **`1. EMPATHIZE`**<br>`GATE-01` (`20 pts`)<br>*Sets $\alpha_{\text{empathize}}$* | *What is the real-world objective, environment, scale, and lifecycle?* | Halts on underspecified prompts (`MissingContextInquiryError`); derives `target_envelope`, `derated_capacity`, and `required_margin`; raises `ImpossibleScopeError` when infeasible. | **SWE:** Concurrency & `p99` SLA.<br>**Med:** Acuity & organ clearance.<br>**HW:** Workpiece scale & load regime. |
| **`2. DEFINE`**<br>`GATE-02` (`20 pts`) | *How is the system constructed, supplied end-to-end, and operated?* | Every requirement traces to `Empathize` (`UngroundedRequirementError`); blocks cyclic/sealed topologies (`ConstructibilityError`), broken pathways (`IncompleteDeliveryError`), & state clashes (`TrajectoryCollisionError`). | **SWE:** Cold-start DAG & telemetry.<br>**Med:** IV compatibility & monitoring.<br>**HW:** Assembly access & cable/feed routing. |
| **`3. IDEATE`**<br>`GATE-03` (`20 pts`) | *Do coupled subsystems co-design both sides of every interface for the defined loads?* | Every interface traces to `Define` (`UngroundedInterfaceError`), matches provider/receiver contracts (`UnmatchedInterfaceError`), enforces `0.0` unbound gap (`UnboundInterfaceError`), & `100%` closure (`IncompleteClosureError`). | **SWE:** Matched RPC schemas & lock leases.<br>**Med:** Co-designed order & rescue sets.<br>**HW:** Paired clearance/tapped bores & `360°` clamps. |
| **`4. PROTOTYPE`**<br>`GATE-04` (`20 pts`)<br>*+ `0.35x` Cap* | *Is each component both **causally sized for the mission** and from a verified source?* | Rejects ungrounded or undersized components (`UngroundedComponentError`), blocks spoofed registry hashes/attributes (`ProvenanceSpoofingError`), & catches zero-utility proxy hacks (`RewardHackingError`). | **SWE:** Audited SDKs sized for throughput.<br>**Med:** Formulary drugs dosed for clearance.<br>**HW:** McMaster CAD sized for mission load. |
| **`5. TEST & CASCADE`**<br>`GATE-05` (`20 pts`) | *Does the system meet the original objective, and do changes cascade everywhere?* | Validates end-to-end output against `Empathize` bounds (`ObjectiveMismatchError`); cascades mutations forward & reverse across DAGs, configs, specs, & tests (`CrossArtifactDriftError`, `ConstraintCycleError`). | **SWE:** Schema cascade across gateway/tests.<br>**Med:** Lab shift cascade across active doses.<br>**HW:** Datum shift cascade across CAD/URDF/SRDF. |

---

## 4. Universal API Contract (`SystemsEngineeringEngine`)

Implement `SystemsEngineeringEngine` in Python 3.11+ (standard library only):

```python
class SystemsEngineeringEngine:
    def derive_operating_regime(self, mission_brief: dict) -> dict:
        """GATE-01 [1. EMPATHIZE]: Interrogate mission context and deduce governing regime.
        - Raise MissingContextInquiryError if required context keys (objective_id, workload_scale,
          coverage_factor, raw_capacity, hazard_derating, peak_load, safety_factor,
          lifecycle_environment) are missing or None.
        - Deduce target_envelope = workload_scale * coverage_factor,
          derated_capacity = raw_capacity / hazard_derating,
          required_margin  = peak_load * safety_factor.
        - Raise ImpossibleScopeError if target_envelope > max_envelope or required_margin > max_capacity."""

    def verify_lifecycle_and_delivery(self, system_dag: dict, regime: dict) -> dict:
        """GATE-02 [2. DEFINE]: Verify causal grounding to regime, constructibility, delivery, and trajectories.
        - Raise UngroundedRequirementError if system_dag['derived_from_objective'] != regime['objective_id'].
        - Raise ConstructibilityError on cyclic dependencies or sealed unserviceable containers.
        - Raise IncompleteDeliveryError on broken source pathways or undefined control modes.
        - Raise TrajectoryCollisionError if any state trajectory produces conflict_magnitude > 0."""

    def verify_reciprocal_interfaces(self, coupled_edges: list[dict], regime: dict) -> dict:
        """GATE-03 [3. IDEATE]: Verify causal load grounding and reciprocal contracts on all edges (u, v).
        - Raise UngroundedInterfaceError if edge lacks requirement_id or support_capacity < regime['required_margin'].
        - Raise UnmatchedInterfaceError if provider_contract != receiver_contract or not reciprocal_feature_present.
        - Raise UnboundInterfaceError if binding_gap > 0.0 or applied_load > support_capacity.
        - Raise IncompleteClosureError if closure_ratio < 1.0."""

    def audit_provenance_and_integrity(
        self, nodes: list[dict], registry: dict, regime: dict, mandatory_ids: list[str], budget_limit: float
    ) -> dict:
        """GATE-04 [4. PROTOTYPE]: Enforce mission fitness + canonical provenance + anti-gaming (0.35x cap).
        - Raise UngroundedComponentError if a node lacks derived_from_requirement or rated_capacity < regime['required_margin'].
        - Raise ProvenanceSpoofingError if a canonical node mismatches registry hash or required_attrs.
        - Raise RewardHackingError on zero-utility proxy nodes; WorkloadDeletionError on missing mandatory_ids;
          ImpossibleConstraintError if mandatory cost > budget_limit."""

    def propagate_system_change(
        self, dag: dict, changed_node: str, new_value: float, artifacts: dict, regime: dict
    ) -> dict:
        """GATE-05 [5. TEST & CASCADE]: Validate against Empathize objective and cascade forward & reverse.
        - Raise ObjectiveMismatchError ifdag['objective_id'] != regime['objective_id'].
        - Raise ConstraintCycleError on cyclic dependency loops.
        - Cascade new_value forward & reverse across dag, synchronize all artifacts, and require 100% test coverage
          of coupled nodes (else raise CrossArtifactDriftError)."""
```
