# TROY BRENNAN LUNN
**Greater San Diego, CA (Open to Mountain View, CA / Relocation)**  
`troy.lunn@endlesswallet.io` · `tkdtroy@gmail.com` · [github.com/Printerpilot](https://github.com/Printerpilot) · [endlesswallet.io](https://endlesswallet.io)

---

## SUMMARY & MISSION
Systems Architect, AI Evaluation & Swarm Engineer, and Founder with **198,000+ lines of production code** architected and shipped across autonomous multi-agent swarms, deterministic verification rubrics, CAD/robotics kernels, Model Context Protocol (MCP) bridges, and zero-trust fintech platforms. Daily power-user and comparative evaluator of **Gemini (Antigravity)**, **Claude (Claude Code / Cowork)**, and **Grok Build** across complex, long-horizon software and hardware engineering workflows. Former **U.S. Junior National Taekwondo Team Member (U.S. Olympic Training Center, Colorado Springs)** and **youngest All-American in the sport**—driven to build frontier AI evaluation and reasoning systems that better humanity and accelerate the transition to a world of unimaginable abundance.

---

## TECHNICAL SKILLS & POLARIS ALIGNMENT
- **AI Coding Agents & Evaluation Engineering:** Long-horizon task design; deterministic Python/AST/B-Rep graders; anti-reward-hacking, anti-shape-spoofing, and anti-sycophancy rubrics; cross-model trajectory & failure analysis (**Gemini 2.5/4 in Antigravity**, **Claude Code**, **Grok Build CLI**, **OpenAI Codex**).
- **Multi-Agent Swarms & LLM Infrastructure:** Hybrid **DiffusionGemma + Autoregressive (AR) Auditor** swarms; Cloud TPUv8I KV-cache prefix sharing & JetStream continuous batching (`asyncio`); LangGraph; Model Context Protocol (MCP stdio, FastMCP SSE, JSON-RPC 2.0); on-device MediaPipe GenAI (**Gemma 3 1B-IT q8**) & OpenClaw cloud gateways.
- **Languages & Full-Stack Systems:** Python, Swift (`SwiftUI`), Kotlin (`Jetpack Compose`), TypeScript / JavaScript (`React 19`, `Deno`, `Node.js`, `Electron`, `Hono`, `Three.js`), SQL (`PostgreSQL 17` / `Supabase`), C++ / OpenCASCADE (`build123d`, `CadQuery`, `adsk.core` / `adsk.fusion`), Solidity / EVM (`ethers.js`, Base L2).
- **CAD, Robotics & Physics Verification:** Parametric B-Rep & continuous Signed Distance Field (SDF) kernels; Surface Nets iso-surface extraction; ROS2 `URDF` / MoveIt2 `SRDF` / Gazebo `SDF`; headless FEA / CFD / kinematic interference verification.

---

## SELECTED AI SYSTEMS, EVALUATION & ENGINEERING EXPERIENCE

### Independent AI Systems Researcher & Principal Architect | *Agentic Swarms, Evals & CAD/MCP Infrastructure* | **2025 – Present**

- **Polaris-Style Deterministic Graders, Physical Intuition Rubrics & Anti-Reward-Hacking Verifiers (`verify_design.py`, `tennis_match_swarm`, `layer1_agentic_loop`):**
  - Engineered automated verification rubrics that evaluate frontier LLMs on long-horizon mechanical and software synthesis without relying on LLM-as-a-judge self-grading.
  - Built **B-Rep topological complexity gates** (`verify_design.py`) that defeat LLM **"Shape Spoofing"**—catching models that extrude 3-face cylinders named `"Pinion_15T"` instead of synthesizing true `>20`-face involute gear teeth—while discriminating NURBS spline-mesh tessellation artifacts (`<0.1 cm³`) from true volumetric collisions and enforcing `10 μm` (`0.001 cm`) kinematic center-distance accuracy.
  - Formalized **Physical & Manufacturability Intuition (DFA/DFM)** into deterministic graders after observing that frontier AI lacks an intuitive grasp of the *totality* of an engineering task—routinely designing **unbuildable "Ship-in-a-Bottle" assemblies** that pass static coordinate checks yet cannot be built or maintained (e.g., placing large bearings or motors inside a 1-piece CNC-milled frame whose external holes are smaller than the component, or sealing a jet engine and fuel cell inside an airframe with only small intake/exhaust ports and zero split seams or access hatches).
- **Multi-Team "Tennis Match" Engineering Swarm, 1:1 Auditor Agents & Hybrid DiffusionGemma Swarm (`tennis_match_swarm`, `distributed_design_swarm`, `diffusion_gemma_swarm`):**
  - Architected a dual-orchestrator **"Tennis Match" Engineering Swarm** where `DesignOrchestrator` (Chief Engineer) decomposes missions into typed `DesignGoal` contracts across **7 specialized `DesignTeam` Workers** (`MDE`, `OML_Aero`, `Propulsion`, `Thermal`, `EE`, `Avionics`, `Materials`) linked by a bidirectional `GraphSolver`, while `SimulationOrchestrator` runs **6 independent verification teams** (`FEANVHTeam`, `AeroCFDTeam`, `ThermalDynamicsTeam`, `EMCSignalTeam`, `IndustrialEngineeringTeam` for DFM/DFA workcells, `SupplyChainCostingTeam`) in closed-loop rallies until **Design Freeze**.
  - Paired every Worker subagent 1-to-1 with an adversarial **`InternalAuditor` / `AuditorAgent` failure-detection gatekeeper** that intercepts **Reward Hacking** (deleting the `1.80 kg` `EngineBlock` payload to pass weight targets), **Physical Sycophancy** (`"zero mass"` compliance), **API Hallucinations**, and **State-Cycle Infinite Loops** (`AuditorEscalation`), backed by `AuditorBridge` `64³` SDF-to-voxel telemetry and a **Cloud TPUv8I (384 MB SRAM)** hybrid `DiffusionGemmaWorker` + AR `TextAuditorAgent` KV-cache sharing pipeline.
- **Autodesk Fusion 360 State-Aware MCP Server v3.0 & Multi-LLM Bridges (`FusionStateAwareAgent`, `~18,400+ LOC`):**
  - Built an in-process Fusion 360 add-in exposing **111 deterministic CAD/CAM/inspection MCP tools** across **Gemini/Antigravity**, **Claude Desktop**, and **Grok**, featuring thread-safe main-UI event marshalling, persistent topological entity pointers (`REFERENCE_MAP`), and every-turn bounding-box/parameter state snapshots.
  - Engineered a custom FastMCP SSE reverse proxy over Tailscale Funnel featuring **16 KB SSE comment padding** (defeating Cloudflare stream buffering) and ASGI host-header rewriting.
- **Modular Agentic CAD & Robotics Skill Suite (`.agents/skills/` — 288 files, `85,297 LOC`) & Flagship Hardware Systems:**
  - Authored 7 comprehensive agent skills (`cad`, `urdf`, `srdf`, `sdf`, `render`, `step-parts`, `sendcutsend`) with a Three.js/Vite **CAD Explorer**, live **MoveIt2 WebSocket IK server**, and automated SendCutSend DFM preflight verifiers.
  - **APEX-6M 6-Axis CNC Robot Arm (`3,460 LOC`):** Programmatically generated a 13-subassembly, 6-DOF industrial robot arm (**142 COTS `.STEP` parts**, 3 quick-change heads including a 24,000 RPM ISO20 ATC spindle with twisted helical carbide cutters and a 190-body Voron StealthChanger printhead) with `0.0 mm` interference and validated URDF/SRDF kinematics.
  - **"Ideal Engine" Hybrid SDF + B-Rep Kernel (`1,292 LOC`) & BWB Stealth Airframe (`19,562 LOC` across 356 scripts):** Built a 2-stage continuous SDF + Surface Nets + OpenCASCADE ISO 10303-21 `.STEP` compiler with a bidirectional BFS constraint solver (`SpatialClearanceEdge`, `LogisticalEdge`), plus 13-station analytical NACA spanwise lofting and watertight CFD fluid-volume extraction.

### Creator & Lead Engineer | *Grok Executive Suite & ClawBridge Mobile Agent Runtime* | **2026 – Present**

- **Grok Executive Suite (`grok-cowork-app` — `7,690+ LOC`, 16 macOS arm64 DMG Releases `v0.1.0` → `v0.4.1`):**
  - Built a native Apple Silicon Electron desktop workspace for Grok Build CLI featuring multi-project context injection, isolated `node-cron` scheduled execution streams, 350ms live `events.jsonl` tool-telemetry tracking, Apple Developer ID notarization, and bundled CoreGraphics/JXA macOS desktop-control MCP servers (7 stdio / 16 SSE tools).
- **ClawBridge Mobile Agent Swarm Control Surface (`com.troy.clawbridge` — `3,660+ LOC`, Android `v1.7.0`):**
  - Built a React 19 / TypeScript 6 / Capacitor 8 Android runtime embedding an in-process Hono/Zod OpenAI-compatible gateway (`127.0.0.1:7842`) that dynamically routes between offline on-device **MediaPipe Gemma 3 1B-IT (q8)** and cloud **OpenClaw** swarm nodes provisioned via 1-click **Oracle Cloud (OCI)** `#cloud-config` + Caddy auto-TLS scripts.

### Founder & Lead Systems Architect | *Endless Wallet LLC (`endlesswallet.io`)* | **2019 – Present**

- Architected and shipped a **67,400+ LOC** non-custodial P2P social lending & 7-C credit evaluation (**CORE**) platform across **native iOS (`SwiftUI`, `36,555 LOC`, Build 112)**, **native Android (`Jetpack Compose`, `22,370 LOC`, v33 / SDK 36)**, **React 19 Web (`1,241 LOC`)**, and **Supabase PostgreSQL 17 (`46 SQL migrations`, `23 Deno/TS Edge Functions`)** by orchestrating **Gemini (Antigravity)**, **Claude**, and **Grok** across shared multi-agent handoff specs.
- Engineered a **$0.00-fee Base Mainnet (Chain ID 8453) USDC settlement rail** (`c2c-pay`, `autopay-worker` with 288 `pg_cron` heartbeats/day and micro-ETH gas sponsorship); a zero-dependency **California Limited Guaranty PDF & SHA-256 e-signature engine**; and **NIST SP 800-207 Zero-Trust hardware device attestation** (custom Deno CBOR/ASN.1 DER/ECDSA P-256 Apple App Attest root CA verifier + Play Integrity + **94+ consecutive daily autonomous AI SecOps audit digests**), earning full **Plaid Production Approval**.

---

## COMPETITIVE DISTINCTION & LEADERSHIP
- **U.S. Junior National Taekwondo Team Member & Resident Athlete, U.S. Olympic Training Center (Colorado Springs, CO):** Competed internationally at the highest level of elite athletics; recognized as the **youngest All-American in the sport** at the time of award.
- **Entrepreneur & Advanced Manufacturing Engineer, Cast Aero:** First-principles aerospace and defense manufacturing systems design.
