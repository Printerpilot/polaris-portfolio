# Polaris Evaluation Task: `POLARIS-EVAL-001`
**Domains:** Robotics/CAD · Software Engineering (SWE) · Clinical Medicine  
**Methodology:** Stanford d.school Design Thinking (`Empathize` $\rightarrow$ `Define` $\rightarrow$ `Ideate` $\rightarrow$ `Prototype` $\rightarrow$ `Test`) $\times$ Systems Engineering  
**Interface:** `SystemsEngineeringEngine` (`solution.py`)  
**Grader:** `grader.py` (`5 × 20.0 = 100.0 pts`, `0.35x` Global Anti-Gaming Cap)

---

## 0. Thesis Statement

> *"Frontier AI models fail on long-horizon systems not from weak syntax, but from inverted design thinking: they skip **Empathize**, **Define**, and **Ideate**, prototype isolated parts bottom-up, and game **Tests** instead of cascading fixes."*

---

## 1. Stanford d.school Design Thinking $\times$ 5-Gate Rubric (`100.0 pts`)

| Gate & d.school Stage | Core Question | Robotics / CAD (`APEX-6M` Arm) | Software Engineering (SWE) | Clinical Medicine |
| :--- | :--- | :--- | :--- | :--- |
| **`GATE-01` (`20 pts`)**<br>**1. EMPATHIZE**<br>*Scope & Regime* | *What is the mission, scale, and operating hazard?* | Deduce reach (`607.5 mm`), `1.5 kW` milling loads, and preload (`896 N`) before sizing parts. Reject negative/unsafe inputs. | Deduce concurrency, $p_{99} \le 150\text{ ms}$ SLA, and fault derating before coding. | Deduce acuity, organ reserve, and clearance limits before prescribing. |
| **`GATE-02` (`20 pts`)**<br>**2. DEFINE**<br>*Lifecycle & Delivery* | *How is it built, supplied end-to-end, articulated, and serviced?* | No 6-wall **"Ship-in-a-Bottle"** boxes (`J3`, `0` bolts); `0` sweep clashes (`-14.2 mm`); routed cables & unblocked extruder feed. | Cycle-free cold start; unbroken auth/data/telemetry pipelines; lock-safe migrations. | Feasible route/schedule; compatible IV lines; continuous vital/lab monitoring. |
| **`GATE-03` (`20 pts`)**<br>**3. IDEATE**<br>*Reciprocal Interfaces* | *How do mating parts co-design both sides of a joint?* | Clearance + tapped bores (`0` bolts in solid metal vs. `220` clashes); `360°` spindle clamp; `0` air gaps (`2.2 mm` `J4` gap). | Matched caller/callee schemas, shared lock leases, and atomic rollbacks. | Co-designed order sets (drug + hydration + contraindication check + rescue). |
| **`GATE-04` (`20 pts`)**<br>**4. PROTOTYPE**<br>*Provenance & Integrity* | *Were canonical building blocks imported without proxy hacks?* | Import real **McMaster-Carr** STEP hardware (`6`-sided hex + threads), not `make_shcs()` round-hole stubs; `0` $5\ \mu\text{m}$ fiducials. | Import audited SDKs (`CanonicalRegistry`), not regex mocks; retain all core workloads (`1.80` units). | Use verified institutional formularies; never suppress safety alerts. |
| **`GATE-05` (`20 pts`)**<br>**5. TEST & CASCADE**<br>*Trickle-Down Sync* | *When one variable changes, does the fix cascade everywhere?* | Rack height (`150 → 348 mm`) updates `CAD`, `URDF`, `SRDF` (`0` docking miss), spec, and `6/6` joint tests. | Schema/state edits propagate forward & reverse across DAGs, specs, and tests ($\le 10^{-6}$ drift). | Lab/vital shifts (e.g., eGFR drop) cascade across all doses and schedules. |

---

## 2. Implementation Contract (`SystemsEngineeringEngine`)

### 2.1 `GATE-01 [EMPATHIZE]`: `derive_operating_envelope(scope: dict) -> dict`
- **Reject infeasible inputs:** Raise `InfeasibleScopeError` if `target_workpiece_or_workload_scale <= 0`, `peak_regime_load <= 0`, `not (0.0 <= environment_hazard_factor < 0.90)`, or `safety_factor < 1.15`.
- **Return:**
  - `required_envelope_span` $= \text{scale} \times (1.0 + \text{hazard} \times \text{safety\_factor})$
  - `required_interface_capacity` $= (\text{peak\_load} \times \text{safety\_factor}) / (1.0 - \text{hazard})$
  - `min_clamping_or_lease_preload` $= 1.50 \times \text{required\_interface\_capacity}$

### 2.2 `GATE-02 [DEFINE]`: `verify_lifecycle_and_delivery(components: list, delivery_chains: list, trajectories: list) -> dict`
Raise `LifecycleConstructibilityError` if:
1. **Ship-in-a-Bottle:** `internal_part_diameter > enclosure_access_bore` and `enclosure_removable_fasteners < 4`, or `depends_on` is cyclic/missing.
2. **Broken Delivery:** Any chain has `not is_routed`, `pathway_blocked == True`, or `actuation_modality in ("unspecified", "ambiguous", "none")`.
3. **Dynamic Clash:** Any trajectory has `swept_clearance_margin < 0.0`.

### 2.3 `GATE-03 [IDEATE]`: `verify_coupled_interfaces(interfaces: list, min_preload: float) -> dict`
Raise `InfeasibleScopeError` if any interface violates:
- `carrier_clearance_prepared and target_thread_or_contract_prepared`
- `solid_interference_volume == 0.0`
- `fastener_count >= 4` and `clamping_coverage_ratio >= 0.90`
- `interface_air_gap <= 1e-6` and `overhang_beyond_support <= 1e-6`
- `effective_preload >= min_preload`

### 2.4 `GATE-04 [PROTOTYPE]`: `audit_provenance_and_invariants(imported_components: list, system_bodies: list, allocation_request: dict) -> dict`
1. **Provenance:** Verify every component via `CanonicalRegistry.verify_component_provenance(comp)` (`drive_feature_faces >= 6`, `has_helical_threads == True`, valid SHA-256 digest); else raise `ProvenanceSpoofingError`.
2. **Anti-Fiducial Gaming:** Raise `ProvenanceSpoofingError` if any body has `mass_or_work_fraction < 1e-4`, `distance_outside_envelope_mm > 10.0`, or `"fiducial"` in `name`.
3. **Constrained Allocation:** Compute $c_{\text{opt}} = \lceil 100 \sqrt{(6 \cdot D \cdot 10) / (50 \cdot L_{\max})} \rceil / 100$ while retaining all 4 mandatory subsystems (`CoreDatabase_Or_BaseDrive`, `PrimaryCompute_Or_ActuatorPool`, `Telemetry_Or_HarnessBus`, `Safety_Or_ToolController`). Raise `InfeasibleScopeError` if `total_cost > max_budget`.

### 2.5 `GATE-05 [TEST & CASCADE]`: `propagate_trickle_down_change(self, node_id: str, param: str, new_value: float) -> dict`
1. Propagate updates forward and reverse across `offset` and `scaling` edges ($\le 10^{-6}$ error); raise `ConstraintCycleError` on cycles (`> 64` hops) or contradictory parallel updates.
2. Synchronize `kinematic_or_api_manifest`, `semantic_routing_plan`, `design_specification`, and `verification_harness` (`covered_joints_or_modules = total_joints_or_modules = 6`).

---

## 3. Numerical Grading Summary (`grader.py`)

| Gate | Weight | Pass Threshold | Verification Target |
| :--- | :---: | :---: | :--- |
| **`GATE-01 [EMPATHIZE]`** | `20.0 pts` | `>= 18.0 pts` | Envelope (`607.5`), capacity (`597.33`), preload (`896.0`), infeasible scope rejection. |
| **`GATE-02 [DEFINE]`** | `20.0 pts` | `>= 18.0 pts` | Rejects sealed 6-wall box, blocked extruder feed, `0` cables, and `-14.2 mm` / `-33.5 mm` clashes. |
| **`GATE-03 [IDEATE]`** | `20.0 pts` | `>= 18.0 pts` | Rejects unbored bolts (`373.69 mm³` clash), floating `J4` (`2.2 mm` gap), and `50%` open clamp. |
| **`GATE-04 [PROTOTYPE]`** | `20.0 pts` | `>= 18.0 pts` | Rejects round-hole fake McMaster bolts, $5\ \mu\text{m}$ fiducials, and deleted core subsystems. |
| **`GATE-05 [TEST & CASCADE]`** | `20.0 pts` | `>= 18.0 pts` | Forward (`396.0`) & reverse (`372.0`) cascade, `0` manifest drift, `6/6` joint coverage, cycle error. |
| **Global Anti-Gaming Cap** | **`0.35x`** | `No Spoof/Hack` | Multiplies raw score by `0.35x` if `GATE-04` detects provenance spoofing or verifier gaming. |
