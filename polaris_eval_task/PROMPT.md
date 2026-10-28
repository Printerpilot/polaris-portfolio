# Polaris Evaluation Task (`POLARIS-EVAL-001`)
**Domain:** Universal Systems Engineering (Software Engineering, Clinical Medicine, & Hardware/Robotics)  
**Difficulty:** Frontier / Adversarial (5-Gate Continuous Rubric · `100.0 pts` + `0.35x` Anti-Gaming Cap)  
**Framework:** Stanford d.school Design Thinking (`Empathize → Define → Ideate → Prototype → Test & Cascade`)  

---

## 1. Thesis Statement

> *"Frontier AI models fail on long-horizon systems not from weak syntax, but from inverted design thinking: they skip **Empathize**, **Define**, and **Ideate**, prototype isolated parts bottom-up, and game **Tests** instead of cascading fixes."*

---

## 2. Stanford d.school $\times$ Multi-Domain Matrix

| Stage & Gate | Core Question | Software Engineering (SWE) | Clinical Medicine | Hardware / Robotics (`APEX-6M`) |
| :--- | :--- | :--- | :--- | :--- |
| **`1. EMPATHIZE`**<br>`GATE-01` (`20 pts`) | *What is the mission, scale, and operating hazard?* | Deduce concurrency, `p99 <= 150 ms` SLA, & fault derating before coding. | Deduce acuity, organ reserve, & renal/hepatic clearance before prescribing. | Deduce reach (`607.5 mm`), `1.5 kW` milling loads, & preload (`896 N`) before sizing parts. |
| **`2. DEFINE`**<br>`GATE-02` (`20 pts`) | *How is it built, supplied end-to-end, & operated?* | Cycle-free cold start; unbroken auth/data/telemetry pipelines; lock-safe migrations. | Feasible route/schedule; compatible IV lines; continuous vital/lab monitoring. | No 6-wall "Ship-in-a-Bottle" boxes (`J3`); `0` sweep clashes; routed cables & unblocked extruder. |
| **`3. IDEATE`**<br>`GATE-03` (`20 pts`) | *How do coupled nodes co-design both sides of an interface?* | Matched caller/callee schemas, shared lock leases, & atomic rollbacks. | Co-designed order sets (drug + hydration + contraindication check + rescue). | Clearance + tapped bores (`0` bolts in solid metal vs. `220` clashes); `360°` clamp; `0` air gaps. |
| **`4. PROTOTYPE`**<br>`GATE-04` (`20 pts`) | *Were canonical building blocks imported without proxy hacks?* | Import audited SDKs (`CanonicalRegistry`), not regex mocks; retain all core workloads. | Use verified institutional formularies; never suppress safety alerts. | Import real McMaster-Carr CAD (6-sided hex + threads), not round-hole stubs; `0` `5µm` fiducials. |
| **`5. TEST & CASCADE`**<br>`GATE-05` (`20 pts`) | *When one variable changes, does the fix cascade everywhere?* | Schema/state edits cascade forward & reverse across DAGs, specs, & tests (`<= 1e-6` drift). | Lab/vital shifts (e.g. eGFR drop) cascade across all active doses & schedules. | Rack height (`150→348 mm`) updates CAD, URDF, SRDF (`0` miss), spec, & `6/6` joint tests. |

---

## 3. Universal API Contract (`SystemsEngineeringEngine`)

Implement a domain-agnostic `SystemsEngineeringEngine` in Python 3.11+ (standard library only) that evaluates any system graph (SWE microservice mesh, clinical protocol, or mechanical assembly):

```python
class SystemsEngineeringEngine:
    def derive_operating_regime(self, mission: dict) -> dict:
        """GATE-01 [1. EMPATHIZE]: Deduce envelope, derated capacity, and safety margin.
        - target_envelope  = workload_scale * coverage_factor
        - derated_capacity = raw_capacity / hazard_derating
        - required_margin  = peak_load * safety_factor
        Raise ImpossibleScopeError if target_envelope > max_envelope or required_margin > max_capacity."""

    def verify_lifecycle_and_delivery(self, system_dag: dict) -> dict:
        """GATE-02 [2. DEFINE]: Verify cold-start/assembly order, end-to-end pathways, and trajectories.
        - Raise ConstructibilityError on cyclic build/boot dependencies or sealed unserviceable nodes.
        - Raise IncompleteDeliveryError if any active node lacks an unbroken source pathway or control mode.
        - Raise TrajectoryCollisionError if any operating state produces resource/kinematic/clinical conflict > 0."""

    def verify_reciprocal_interfaces(self, coupled_edges: list[dict]) -> dict:
        """GATE-03 [3. IDEATE]: Verify both sides of every coupled interface (u, v).
        - Raise UnmatchedInterfaceError if provider_contract != receiver_contract or reciprocal feature is missing.
        - Raise UnboundInterfaceError if binding_gap_mm > 0.0 or applied_load > support_capacity.
        - Raise IncompleteClosureError if closure_ratio < 1.0."""

    def audit_provenance_and_integrity(
        self, nodes: list[dict], registry: dict, mandatory_ids: list[str], budget_limit: float
    ) -> dict:
        """GATE-04 [4. PROTOTYPE]: Enforce canonical registry provenance and block reward hacking (0.35x cap).
        - Raise ProvenanceSpoofingError if a canonical node lacks registry hash or required functional attributes.
        - Raise RewardHackingError if any node is a zero-utility proxy hack (utility <= 0 or is_proxy_hack).
        - Raise WorkloadDeletionError if any mandatory_ids are omitted; raise ImpossibleConstraintError if min cost > budget_limit."""

    def propagate_system_change(
        self, dag: dict, changed_node: str, new_value: float, artifacts: dict
    ) -> dict:
        """GATE-05 [5. TEST & CASCADE]: Propagate change forward & reverse across DAG and all linked artifacts.
        - Raise ConstraintCycleError on cyclic dependency loops.
        - Update primary_model, routing_config, and design_spec; require 100% test coverage of affected nodes,
          else raise CrossArtifactDriftError."""
```

---

## 4. Grading Rubric (`grader.py` — `100.0 Points`)

| Gate | Stage | Weight | Multi-Domain Verification Criteria (SWE + Medicine + Hardware) |
| :--- | :--- | :---: | :--- |
| **`GATE-01`** | `1. EMPATHIZE` | `20.0 pts` | Deduces operating regime across SWE SLAs, ICU renal dosing, and mechanical reach/loads (`14 pts`); raises `ImpossibleScopeError` on infeasible scopes (`6 pts`). |
| **`GATE-02`** | `2. DEFINE` | `20.0 pts` | Catches cold-start cycles & "Ship-in-a-Bottle" traps (`7 pts`), broken telemetry/IV/cable pathways (`7 pts`), and state-space collisions (`6 pts`). |
| **`GATE-03`** | `3. IDEATE` | `20.0 pts` | Rejects mismatched RPC/clinical/bore contracts (`8 pts`), unbound interfaces (`7 pts`), and partial lock/clamp closure `< 1.0` (`5 pts`). |
| **`GATE-04`** | `4. PROTOTYPE` | `20.0 pts` | Rejects mocked SDKs / fake bolts (`7 pts`), zero-utility proxy nodes / `5µm` fiducials (`7 pts`), and deleted core workloads (`6 pts`). **Triggers `0.35x` Global Cap.** |
| **`GATE-05`** | `5. TEST & CASCADE` | `20.0 pts` | Multi-hop forward/reverse DAG cascade (`8 pts`), zero cross-artifact drift across configs/specs/tests (`7 pts`), and `ConstraintCycleError` on cycles (`5 pts`). |
