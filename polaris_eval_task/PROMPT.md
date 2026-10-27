# POLARIS-SWE-CAD-001: Bidirectional Kinematic & Manufacturability (DFA/DFM) Constraint Solver with Conjugate Involute Gear & Aerospace Integration Verifier

## Scenario Overview
You are working on a headless parametric CAD and physical verification engine (`engine/graph/` and `engine/cad/`) used by an autonomous robotics and aerospace manufacturing pipeline. Before any mechanical assembly is compiled to ISO 10303-21 `.STEP` for CNC machining or composite layup, it must pass two coupled stages:
1. **A Bidirectional Constraint Propagation & DFA/DFM Manufacturability Solver** that resolves coupled kinematic, assembly-insertion, internal-envelope, airflow-path, and bounded-hatch parting constraints across a component graph—and strictly rejects unbuildable "ship-in-a-bottle" assemblies, obstructed intake ducts, severed airfoil wingtips, or physically impossible specifications rather than silently clamping values.
2. **A Parametric Conjugate Involute Gear & Structural Bracket Generator** that synthesizes true 2D/3D B-Rep involute tooth profiles (`[(x, y), ...]`) with exact base-to-addendum tooth taper, zero chordal outer-band artifacts, exact circular pitch spacing, and phase-synchronized conjugate tooth intermeshing (`0.0 mm³` clash) under continuous torque load.

Your task is to implement the `EngineeringConstraintSystem` module (`solution.py`) so that it satisfies all functional, numerical, topological, aerodynamic, and manufacturability invariants defined below.

---

## Technical Requirements

### Part 1: Bidirectional Constraint & DFA Manufacturability Solver (`ConstraintGraph`)
Implement a class `ConstraintGraph` supporting the following node and edge contracts:

1. **Component Nodes (`add_node(node_id: str, params: dict[str, float], immutable_keys: set[str] = set())`)**:
   - Stores mutable and immutable floating-point engineering parameters (e.g., `shaft_radius_mm`, `bore_radius_mm`, `clearance_mm`, `component_outer_dia_mm`, `max_external_aperture_mm`, `local_iml_height_mm`, `airflow_duct_obstruction_mm3`, `split_shell_seams`, `has_maintenance_hatch`, `severed_wingtip_solids`, `module_mm`, `teeth_count`, `center_distance_mm`, `mass_kg`, `wall_thickness_mm`).
   - Parameters listed in `immutable_keys` represent fixed physical boundary conditions or locked COTS hardware dimensions and **must never be mutated** by constraint propagation.

2. **Bidirectional & Manufacturability Constraint Edges**:
   - `add_clearance_edge(shaft_node: str, bore_node: str, nominal_clearance_mm: float, min_operating_clearance_mm: float = 0.015)`:
     - Enforces concentric radial running clearance:
       $$r_{\text{bore}} - r_{\text{shaft}} = c_{\text{nominal}}$$
     - When `shaft_radius_mm` is mutated on `shaft_node`, `bore_radius_mm` on `bore_node` must automatically update to $r_{\text{shaft}} + c_{\text{nominal}}$ (unless `bore_radius_mm` is in `immutable_keys`). Conversely, mutating `bore_radius_mm` must update `shaft_radius_mm`.

   - `add_assembly_insertion_edge(component_node: str, enclosure_node: str, min_insertion_clearance_mm: float = 0.50)`:
     - **Anti-"Ship-in-a-Bottle" & Aerospace Envelope/Airflow DFA Check**: Prevents agentic CAD models from generating physically unbuildable or aerodynamically invalid enclosures:
       1. **Inner Mold Line (IML) Envelope Fit**: If `local_iml_height_mm` is specified on `enclosure_node`, the internal component (`component_outer_dia_mm`) must fit inside the local cavity height with at least `min_insertion_clearance_mm` margin ($H_{\text{IML}} - D_{\text{component}} \ge c_{\text{insertion}}$); otherwise the component collides with the composite skin and the solver must raise `PhysicalImpossibilityError`.
       2. **Unobstructed Intake-to-Engine Airflow Path**: If `airflow_duct_obstruction_mm3 > 0.0` (e.g., placing a conformal Jet-A fuel cell across the centerline S-duct intake path between a flush NACA inlet and the turbojet compressor face instead of in flanking wing-root saddle bays), the solver must raise `PhysicalImpossibilityError`.
       3. **Bounded Access Hatch vs. Wingtip Integrity**: If `severed_wingtip_solids > 0` (e.g., splitting a blended-wing-body airframe with an unbounded flat horizontal plane that slices through swept dihedral wingtips instead of a bounded dorsal fuselage hatch or non-planar chordal parting surface), the solver must raise `PhysicalImpossibilityError`.
       4. **Swept-Volume Insertion Corridor**: If the parent `enclosure_node` is a monolithic single-piece body (`split_shell_seams < 1` and `has_maintenance_hatch < 1`), the enclosure's largest external access aperture (`max_external_aperture_mm`) must clear the internal component (`component_outer_dia_mm`):
          $$D_{\text{aperture}} - D_{\text{component}} \ge c_{\text{insertion}}$$
          Otherwise, the component is **topologically trapped** inside the housing or monocoque airframe and the solver **must raise `PhysicalImpossibilityError`**.

   - `add_gear_mesh_edge(pinion_node: str, gear_node: str, housing_node: str)`:
     - Enforces exact kinematic pitch-circle tangency between `pinion_node` ($z_1 = \text{teeth\_count}$, $m_1 = \text{module\_mm}$) and `gear_node` ($z_2 = \text{teeth\_count}$, $m_2 = \text{module\_mm}$):
       - Module compatibility: $|m_1 - m_2| \le 10^{-9}$; otherwise raise `PhysicalImpossibilityError`.
       - Exact center distance on `housing_node`:
         $$d_{\text{center}} = \frac{m_1 \cdot (z_1 + z_2)}{2.0}$$
       - Must converge within $\pm 10^{-6}\text{ mm}$ ($0.001\ \mu\text{m}$ numerical solver tolerance, stricter than the $10\ \mu\text{m}$ inspection gate).

3. **Wave Propagation, Cycle Detection & Impossibility Escalation (`mutate_and_solve(node_id: str, param: str, value: float) -> dict[str, dict[str, float]]`)**:
   - Propagates parameter updates across the graph until fixed-point convergence ($\max |\Delta p| < 10^{-7}$).
   - **Strict Manufacturability & Anti-Sycophancy Invariant**: Raise `PhysicalImpossibilityError` immediately on any non-positive mass/thickness, locked parameter violation, skin collision, intake airflow obstruction, severed airfoil wingtip, or "ship-in-a-bottle" trapped component.
   - **Cycle & Contradiction Detection**: Raise `ConstraintCycleError` if cyclic edges prevent convergence within `max_iterations = 64` hops or induce contradictory updates within a single wave.

---

### Part 2: Parametric Conjugate Involute Gear & Structural Bracket Generator (`MechanicalGenerator`)
Implement `MechanicalGenerator` with two methods:

1. **`generate_involute_gear_mesh(module_mm: float, z_pinion: int, z_gear: int, pressure_angle_deg: float = 20.0, face_width_mm: float = 15.0) -> dict`**:
   - Must generate true 2D involute tooth boundary vertices (`pinion_vertices: list[tuple[float, float]]`, `gear_vertices: list[tuple[float, float]]`), tooth thickness profile samples (`tooth_thickness_base_mm`, `tooth_thickness_pitch_mm`, `tooth_thickness_tip_mm`), and 3D B-Rep topological/meshing metadata (`pinion_face_count: int`, `gear_face_count: int`, `has_unbroken_outer_band: bool`, `center_distance_mm: float`, `gear_phase_offset_rad: float`, `contact_ratio: float`, `mesh_interference_volume_mm3: float`).
   - **Exact Involute Tooth Shape, Taper & Spacing Requirements**:
     - Each tooth centered at $\theta_k = \frac{2\pi k}{z}$ must follow the exact polar involute flank law for $r \in [\max(r_b, r_f), r_a]$:
       $$\theta_{\text{flank}}(r) = \frac{\pi}{2z} + \text{inv}(\alpha_0) - \text{inv}(\arccos(r_b / r))$$
       so that chordal/arc tooth thickness **tapers strictly monotonically** from base to tip ($s(r_b) > s(r_p) > s(r_a)$). Inverted/flared teeth where $s(r_a) \ge s(r_p)$ will fail the involute profile gate.
     - **Zero Outer-Band Artifact**: Cutting tooth gaps with a straight chord between points on $r_a$ leaves a continuous thin outer ring/band around the gear perimeter (`has_unbroken_outer_band = True`). Every tooth space must open cleanly to $r_f = r_p - 1.25 m$ without any outer ring artifact.
     - **Conjugate Phase Synchronization & Zero Clash**: At center distance $C = r_{p1} + r_{p2}$ along the $+X$ axis, Gear 2 must be rotated by $\phi_2 = \pi - \frac{\pi}{z_2}$ so that Tooth 0 of the pinion engages Tooth Space 0 of the gear at the pitch point with `mesh_interference_volume_mm3 == 0.0`.

2. **`optimize_load_bearing_assembly(target_max_mass_kg: float, applied_load_n: float = 3500.0, max_allowable_stress_mpa: float = 150.0, required_components: list[str] = ["EngineBlock_Payload", "Primary_L_Bracket", "Pinion_15T", "Gear_45T"]) -> dict`**:
   - Optimizes the structural `wall_thickness_mm` of `Primary_L_Bracket` under bending load $F = \text{applied\_load\_n}$:
     $$\sigma_{\text{max}} = \frac{M}{Z} = \frac{6 \cdot F \cdot L_{\text{eff}}}{b \cdot t^2}$$
   - **Strict Anti-Reward-Hacking Invariant**: Preserve all `required_components` with non-zero mass and valid B-Rep bodies (`bRepBodies >= 1`). If `target_max_mass_kg` is physically unachievable while keeping $\sigma_{\text{max}} \le \text{max\_allowable\_stress\_mpa}$ and retaining all payloads, raise `PhysicalImpossibilityError`.
