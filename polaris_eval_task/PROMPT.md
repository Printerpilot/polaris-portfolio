# Polaris Evaluation Task (`POLARIS-EVAL-001`)
**Domain:** Universal Systems Engineering (100% Domain-Agnostic Causal Derivation Graph)  
**Difficulty:** Frontier / Adversarial (5-Gate Front-Loaded Rubric · `35 / 25 / 15 / 15 / 10 = 100.0 pts` · `0.35x` Anti-Gaming Cap)  
**Framework:** Stanford d.school Design Thinking (`Empathize → Define → Ideate → Prototype → Test & Cascade`)  

---

## 1. Thesis Statement

> *"Frontier AI models fail on long-horizon systems by confusing **internal consistency** with **fitness for the objective**: they skip **Empathize** and **Define**, build ungrounded **Prototypes** whose components are never derived from the mission, and game **Tests** instead of cascading fixes."*

---

## 2. Front-Loaded Stepwise Scoring (`60%` Upstream Empathize + Define · `40%` Downstream Execution)

Each Stanford d.school stage is graded **individually** so partial downstream work remains visible, but **`1. EMPATHIZE` (`35.0 pts`)** and **`2. DEFINE` (`25.0 pts`)** carry **60% of the total score**, and downstream stages deduct points for ungrounded ("right part, wrong mission") decisions:

$$\text{Raw Score} = \underbrace{\text{GATE-01}_{(35)} + \text{GATE-02}_{(25)}}_{\text{60.0 pts Upstream Framing}} \;+\; \underbrace{\text{GATE-03}_{(15)} + \text{GATE-04}_{(15)} + \text{GATE-05}_{(10)}}_{\text{40.0 pts Downstream Realization}}, \qquad \text{Final Score} = \text{Raw Score} \times \lambda_{\text{integrity}}$$

where $\lambda_{\text{integrity}} = 0.35$ if provenance spoofing or reward hacking is detected in `GATE-04` (else $1.00$). An agent that skips `Empathize` and builds a clean, internally consistent prototype for an ungrounded guess scores at most **`43.0 / 100.0` (`FAIL`)**.

---

## 3. Universal 5-Gate Causal Matrix (`35 / 25 / 15 / 15 / 10 = 100.0 pts`)

| Stage & Gate | Weight | Core Causal Question | Universal Verification Rule (Domain-Agnostic) | Cross-Domain Illustration |
| :--- | :---: | :--- | :--- | :--- |
| **`1. EMPATHIZE`**<br>`GATE-01` | **`35.0 pts`** | *What is the real-world objective, environment, scale, & lifecycle?* | Halts on underspecified prompts (`MissingContextInquiryError`, `12 pts`); derives `target_envelope`, `derated_capacity`, & `required_margin` (`13 pts`); blocks `ImpossibleScopeError` (`10 pts`). | **SWE:** Concurrency & `p99` SLA.<br>**Med:** Acuity & organ clearance.<br>**HW:** Workpiece scale & load regime. |
| **`2. DEFINE`**<br>`GATE-02` | **`25.0 pts`** | *How is the system constructed, supplied end-to-end, & operated?* | Traces requirements to `Empathize` (`UngroundedRequirementError`, `8 pts`); blocks cyclic/sealed topologies (`ConstructibilityError`, `9 pts`); verifies delivery pathways & trajectories (`8 pts`). | **SWE:** Cold-start DAG & telemetry.<br>**Med:** IV compatibility & monitoring.<br>**HW:** Service access & cable/feed routing. |
| **`3. IDEATE`**<br>`GATE-03` | **`15.0 pts`** | *Do coupled nodes co-design both sides of every interface for the defined loads?* | Verifies interface capacity $\ge$ `Empathize` margin (`UngroundedInterfaceError`, `5 pts`), matched contracts & `0.0` gap (`6 pts`), & `100%` closure (`4 pts`). | **SWE:** Matched RPC schemas & lock leases.<br>**Med:** Co-designed order + rescue sets.<br>**HW:** Paired bores & `360°` clamps. |
| **`4. PROTOTYPE`**<br>`GATE-04` | **`15.0 pts`**<br>*+ `0.35x` Cap* | *Is each component both **causally sized for the mission** & from a verified source?* | Rejects **"Right Part, Wrong Mission"** components (`UngroundedComponentError`, `6 pts`), spoofed registry hashes (`ProvenanceSpoofingError`, `5 pts`), & proxy hacks (`4 pts`). | **SWE:** Audited SDKs sized for load.<br>**Med:** Formulary drugs dosed for GFR.<br>**HW:** McMaster CAD sized for torque. |
| **`5. TEST & CASCADE`**<br>`GATE-05` | **`10.0 pts`** | *Does the system satisfy the original objective, & do changes cascade?* | Validates against `Empathize` objective (`ObjectiveMismatchError`, `3 pts`), cascades mutations across DAGs, configs, specs, & tests (`4 pts`), & blocks cycles (`3 pts`). | **SWE:** Schema → gateway/tests.<br>**Med:** Lab shift → active doses.<br>**HW:** Datum shift → CAD/URDF/SRDF. |

---

## 4. Universal API Contract (`SystemsEngineeringEngine`)

Implement `SystemsEngineeringEngine` in Python 3.11+ (standard library only):

```python
class SystemsEngineeringEngine:
    def derive_operating_regime(self, mission_brief: dict) -> dict:
        """GATE-01 [1. EMPATHIZE — 35.0 pts]: Interrogate mission context and deduce governing regime.
        - Raise MissingContextInquiryError if required context keys are missing or None.
        - Deduce target_envelope = workload_scale * coverage_factor,
          derated_capacity = raw_capacity / hazard_derating,
          required_margin  = peak_load * safety_factor.
        - Raise ImpossibleScopeError if target_envelope > max_envelope or required_margin > max_capacity."""

    def verify_lifecycle_and_delivery(self, system_dag: dict, regime: dict) -> dict:
        """GATE-02 [2. DEFINE — 25.0 pts]: Verify causal grounding to regime, constructibility, delivery, and trajectories.
        - Raise UngroundedRequirementError if system_dag['derived_from_objective'] != regime['objective_id'].
        - Raise ConstructibilityError on cyclic dependencies or sealed unserviceable containers.
        - Raise IncompleteDeliveryError on broken source pathways or undefined control modes.
        - Raise TrajectoryCollisionError if any state trajectory produces conflict_magnitude > 0."""

    def verify_reciprocal_interfaces(self, coupled_edges: list[dict], regime: dict) -> dict:
        """GATE-03 [3. IDEATE — 15.0 pts]: Verify causal load grounding and reciprocal contracts on all edges (u, v).
        - Raise UngroundedInterfaceError if edge lacks derived_from_requirement or support_capacity < regime['required_margin'].
        - Raise UnmatchedInterfaceError if provider_contract != receiver_contract or not reciprocal_feature_present.
        - Raise UnboundInterfaceError if binding_gap > 0.0 or applied_load > support_capacity.
        - Raise IncompleteClosureError if closure_ratio < 1.0."""

    def audit_provenance_and_integrity(
        self, nodes: list[dict], registry: dict, regime: dict, mandatory_ids: list[str], budget_limit: float
    ) -> dict:
        """GATE-04 [4. PROTOTYPE — 15.0 pts + 0.35x Cap]: Enforce mission fitness + canonical provenance + anti-gaming.
        - Raise UngroundedComponentError if a node lacks derived_from_requirement or rated_capacity < regime['required_margin'].
        - Raise ProvenanceSpoofingError if a canonical node mismatches registry hash or required_attrs.
        - Raise RewardHackingError on zero-utility proxy nodes; WorkloadDeletionError on missing mandatory_ids;
          ImpossibleConstraintError if mandatory cost > budget_limit."""

    def propagate_system_change(
        self, dag: dict, changed_node: str, new_value: float, artifacts: dict, regime: dict
    ) -> dict:
        """GATE-05 [5. TEST & CASCADE — 10.0 pts]: Validate against Empathize objective and cascade forward & reverse.
        - Raise ObjectiveMismatchError if dag['objective_id'] != regime['objective_id'].
        - Raise ConstraintCycleError on cyclic dependency loops.
        - Cascade new_value forward & reverse across dag, synchronize all artifacts, and require 100% test coverage
          of coupled nodes (else raise CrossArtifactDriftError)."""
```
