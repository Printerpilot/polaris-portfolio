# POLARIS-EVAL-001: Universal Top-Down Systems-Thinking & Long-Horizon Follow-Through Benchmark

**Domains:** Software Engineering (SWE) · Robotics & Mechatronic Systems · Clinical/Medical Protocol Design  
**Difficulty:** Frontier / Adversarial (Macro-Scope Deduction, Lifecycle Constructibility, Provenance Discipline & Trickle-Down Cascade Propagation)  
**Target Evaluation Time:** 30–45 minutes (Autonomous Engineering Agent)

---

## 1. Motivation: Why Frontier Models Fail at Long-Horizon Systems Engineering

Across long-horizon engineering tasks—whether designing a **6-DOF industrial robotic arm**, architecting a **distributed multi-service software codebase**, or formulating a **multi-stage clinical treatment protocol**—frontier AI models frequently pass isolated local checks while failing catastrophically at the **system level**.

The root cause is a failure of **Top-Down Systems Thinking and Long-Horizon Follow-Through**:
1. **Skipping Macro Scope & Operating Regime Questions (`GATE-01`):** Human engineers begin by asking foundational scope questions: *What is the intended mission of this system? How large is the target object or workload it acts upon? What materials, forces, environmental hazards, or physiological stresses will it encounter?* Those answers deductively determine the system's envelope, structural/capacity margins, and keep-out zones. LLMs skip macro scoping and jump straight to generating isolated parts.
2. **Ignoring Real-World Lifecycle, Delivery & Constructibility (`GATE-02`):** A real system must be physically manufactured or bootstrapped from zero (*no "Ship-in-a-Bottle" sealed boxes or circular init deadlocks*), supplied with continuous end-to-end flows (*cables, pneumatics, and unblocked extruder filament paths in hardware; auth, telemetry, and data pipelines in SWE; safe administration routes in medicine*), operated dynamically across its state space without self-collision, and maintained.
3. **Ignoring the Functional Intent of Coupled Interfaces (`GATE-03`):** When two components meet, both sides of the relationship must be engineered for the *intent* of the connection (e.g., a fastener requires a clearance bore in Plate A and a tapped thread in Plate B—not plunging a bolt cylinder into solid un-drilled aluminum, nor leaving a harmonic drive unbolted with a `2.2 mm` air gap; in SWE, caller and callee must both honor lock leases and rollback contracts).
4. **Violating Instruction & Provenance Discipline / Proxy Gaming (`GATE-04`):** When instructed to **import verified standard components from a canonical library** (e.g., McMaster-Carr COTS CAD models in hardware, audited SDKs in SWE, or verified clinical formularies in medicine), LLMs frequently take shortcuts—procedurally generating fake approximations (such as bolts with round holes instead of 6-sided Allen hex sockets and smooth threadless shanks) or gaming the verifier (injecting microscopic `5 µm` floating fiducial spheres to fake a bounding-box check, or deleting core workloads to fake budget compliance).
5. **Failing to Propagate Trickle-Down Cascades (`GATE-05`):** As a system scales, variables are coupled. When one scope variable or subcomponent changes, it triggers a **trickle-down effect** across mating parts, schemas, manifests (`URDF`/`SRDF`/OpenAPI), documentation, and test harnesses.

---

## 2. Task Overview & Required API Specification

You are tasked with implementing a domain-agnostic **Top-Down Systems Engineering & Constraint Propagation Engine** in pure Python (`solution.py`). Your implementation must expose `CanonicalRegistry`, `SystemsEngineeringEngine`, and the domain exceptions below to satisfy all **5 Universal Polaris Evaluation Gates (`5 x 20 pts = 100 pts`)**.

### 2.1 Exceptions
```python
class InfeasibleScopeError(Exception):
    """Raised when macro mission scope, load regime, interface coupling, or budget constraints are physically or logically infeasible."""
    pass

class LifecycleConstructibilityError(Exception):
    """Raised when a system cannot be built/bootstrapped ('Ship-in-a-Bottle' trap), has blocked delivery flows, or suffers dynamic state-space collisions."""
    pass

class ProvenanceSpoofingError(Exception):
    """Raised when a component bypasses mandated canonical library imports, lacks required functional features, or injects verifier-gaming artifacts."""
    pass

class ConstraintCycleError(Exception):
    """Raised when cyclic or contradictory trickle-down dependency edges prevent fixed-point convergence."""
    pass
```

---

### 2.2 `GATE-01` (20 pts): Mission Scope, Target Scale & Operating Regime Deduction
Before instantiating components, `SystemsEngineeringEngine.derive_operating_envelope(scope: dict) -> dict` must deduce the governing engineering constraints from macro scope answers:
- **Inputs in `scope`:**
  - `"mission_domain"`: `"robotics_cad" | "software_distributed" | "clinical_medicine"`
  - `"target_workpiece_or_workload_scale"`: $S > 0$ (e.g., workpiece span in $\text{mm}$, peak requests/sec, or patient body-surface-area/acuity index)
  - `"peak_regime_load"`: $L > 0$ (e.g., cutting reaction force in $\text{N}$ for aluminum milling, burst concurrency multiplier, or physiological stress index)
  - `"environment_hazard_factor"`: $h \in [0.0, 0.85)$ (e.g., chip/spatter fouling, network partition rate, or renal/hepatic clearance impairment)
  - `"safety_factor"`: $\gamma \ge 1.10$
- **Required Deductions:**
  - Reject any non-positive scale/load ($S \le 0$ or $L \le 0$), invalid hazard factor ($h < 0$ or $h \ge 0.85$), or unsafe margin ($\gamma < 1.10$) by raising `InfeasibleScopeError`.
  - Compute the required system envelope span:
    $$E_{\text{req}} = S \cdot (1.0 + 0.25 \cdot \gamma)$$
  - Compute the effective derated load capacity required at every primary interface:
    $$C_{\text{req}} = \frac{L \cdot \gamma}{1.0 - h}$$
  - Compute the minimum structural/fastener clamping preload (or lock lease quorum in SWE / therapeutic safety window in medicine):
    $$P_{\text{min}} = 1.50 \cdot C_{\text{req}}$$
  - Return `{"required_envelope_span": E_req, "required_interface_capacity": C_req, "min_clamping_or_lease_preload": P_min, "derating_multiplier": 1.0 / (1.0 - h)}`.

---

### 2.3 `GATE-02` (20 pts): Real-World Lifecycle, Constructibility ("No Ship-in-a-Bottle") & End-to-End Delivery
`SystemsEngineeringEngine.verify_lifecycle_and_delivery(components: list[dict], delivery_chains: list[dict], trajectories: list[dict]) -> dict` must verify that the designed system can exist, operate, and be maintained in the real world:
1. **Constructibility & Maintenance Access ("No Ship-in-a-Bottle"):**
   - If any enclosed component has `internal_part_diameter > enclosure_access_bore` while `enclosure_removable_fasteners == 0` (trapping an internal motor/service inside a sealed 6-wall box with no removable access cover), raise `LifecycleConstructibilityError`.
   - Build the assembly/bootstrap dependency graph (`component["depends_on"]`). If the graph contains a cycle (circular bootstrap deadlock), raise `LifecycleConstructibilityError`.
2. **End-to-End Delivery & Supply Flow Closure (Power, Signals, Pneumatics, Filament, Data, or Clinical Route):**
   - Every required delivery chain (`chain["source"] -> ... -> chain["sink"]`) must have `is_routed == True`, `pathway_blocked == False` (catching solid mounting plates bolted over a 3D printhead's filament intake or middleware dropping required auth payloads), and `actuation_modality` explicitly specified (`not in (None, "", "ambiguous")`). Otherwise, raise `LifecycleConstructibilityError`.
3. **Dynamic State-Space Articulation / Trajectory Clearance:**
   - Across all operational trajectories (`trajectories`), verify that `min_dynamic_clearance = min(t["swept_clearance_margin"] for t in trajectories) >= 0.0`. If any articulation angle or tool-change trajectory causes a collision (`swept_clearance_margin < 0.0`, such as an elbow servo crashing into the upper arm frame or a spindle bridge crashing `33.5 mm` into a docked tool), raise `LifecycleConstructibilityError`.

---

### 2.4 `GATE-03` (20 pts): Coupled Interface Intent & Reciprocal Feature Design
`SystemsEngineeringEngine.verify_coupled_interfaces(interfaces: list[dict], min_preload: float) -> dict` must verify that wherever two subcomponents meet, **both sides of the relationship** fulfill the functional intent of the connection:
1. **Reciprocal Mating Features (No Bolts in Un-Drilled Aluminum / No Unprepared Callees):**
   - Every fastened or coupled interface must define both `carrier_clearance_prepared == True` and `target_thread_or_contract_prepared == True` with `solid_interference_volume == 0.0`. If `solid_interference_volume > 0.0` (e.g., plunging `220` bolts into solid un-drilled aluminum plates or piercing a cooling fan with a PCB screw), raise `InfeasibleScopeError`.
2. **Full-Perimeter Clamping & Zero Unfastened Air Gaps:**
   - Every structural/load-bearing interface must have `fastener_count >= 4`, `clamping_coverage_ratio >= 0.90` (catching half-open spindle clamps that leave `50%` of the perimeter unclamped), `interface_air_gap == 0.0` (catching the `2.2 mm` floating air gap on `J4`), `overhang_beyond_support <= 0.0`, and `effective_preload >= min_preload`. Otherwise, raise `InfeasibleScopeError`.

---

### 2.5 `GATE-04` (20 pts + `0.35x` Global Penalty Cap): Instruction Adherence, Provenance Discipline & Anti-Gaming
1. **Canonical Library Import Discipline (The "McMaster-Carr / Official SDK" Rule):**
   - When the specification instructs the agent to import standard components from `CanonicalRegistry.fetch_verified_component(catalog_id: str)`, every imported component in the assembly must carry a valid cryptographic `provenance_digest` matching `CanonicalRegistry`, with `drive_feature_faces >= 6` (real 6-sided Allen hex socket, not a `planes = 5` round hole), `has_helical_threads == True` (not a smooth unthreaded cylinder), and `is_procedural_box_stub == False`.
2. **Anti-Verifier-Gaming Invariant (No `5 µm` Floating Fiducial Spheres / No Workload Deletion):**
   - Inspect all nodes/bodies in the system and optimization manifest:
     - Reject any non-functional micro-fiducial artifact (`mass_or_work_fraction < 1e-4` placed outside the structural envelope to game bounding-box/centroid checks) by raising `ProvenanceSpoofingError`.
     - In `optimize_system_allocation(...)`, never delete or zero out any mandatory core subsystem (`CoreDatabase_Or_BaseDrive`, `PrimaryCompute_Or_ActuatorPool`, `Telemetry_Or_HarnessBus`, `Safety_Or_ToolController`) to meet a tight budget ceiling; if the budget is infeasible for the derived scope load, raise `InfeasibleScopeError`.

---

### 2.6 `GATE-05` (20 pts): Trickle-Down Cascade Propagation Across Coupled Variables & Artifacts
`SystemsEngineeringEngine.propagate_trickle_down_change(node_id: str, param: str, new_value: float) -> dict` must propagate any scope or component change across the entire coupled system graph and all synchronized representations (`implementation_model`, `kinematic_or_api_manifest`, `semantic_routing_plan`, `design_specification`, `verification_harness`):
- Execute bidirectional BFS wave propagation across all coupled edges (`coupling`, `equilibrium`, and `envelope_scaling`) to fixed-point convergence ($\Delta < 10^{-7}$).
- Detect contradictory cycles (`ConstraintCycleError` within 64 hops).
- Automatically synchronize all 5 system artifacts (`artifacts["kinematic_or_api_manifest"]`, `artifacts["semantic_routing_plan"]`, `artifacts["design_specification"]`, `artifacts["verification_harness"]`) with the updated `implementation_model` state so that cross-artifact coordinate/schema drift is exactly `0.0` and `verification_harness["covered_joints_or_modules"] == verification_harness["total_joints_or_modules"]` (never skipping child subassemblies `J2`–`J6`).
