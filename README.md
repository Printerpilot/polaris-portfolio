# Troy Brennan Lunn — Google DeepMind Polaris Portfolio & Sample Evaluation Task

**Live Interactive Portfolio:** [https://printerpilot.github.io/polaris-portfolio/](https://printerpilot.github.io/polaris-portfolio/)  
**All-Bright-Blue Headings Edition:** [https://printerpilot.github.io/polaris-portfolio/deepmind.html](https://printerpilot.github.io/polaris-portfolio/deepmind.html)  
**1-Page Tuned Resume (PDF):** [https://printerpilot.github.io/polaris-portfolio/Troy_Lunn_DeepMind_Polaris_Resume.pdf](https://printerpilot.github.io/polaris-portfolio/Troy_Lunn_DeepMind_Polaris_Resume.pdf)

---

## Contents

- **[`index.html`](./index.html)** — Interactive DeepMind Polaris Portfolio Showcase featuring:
  - Live **5-Gate Deterministic Grader Simulator (`POLARIS-SWE-CAD-001`)** comparing 3 candidate trajectories (*Shape Spoofing*, *Payload-Deletion Reward Hacking*, and *Gold Reference*).
  - **Multi-Team "Tennis Match" Engineering Swarm & 1:1 Auditor Agent Architecture** (`DesignOrchestrator` + 7 `DesignTeam` Workers vs. `SimulationOrchestrator` + 6 FEA/CFD/DFM verification teams).
  - **The Physical & Manufacturability Intuition Gap** (why frontier AI designs "ship-in-a-bottle" CAD assemblies that pass static coordinate checks yet cannot be built, assembled, or maintained).
  - **Six Systems Engineering Pillars** across **198,000+ lines of shipped production code**.
- **[`Troy_Lunn_DeepMind_Polaris_Resume.pdf`](./Troy_Lunn_DeepMind_Polaris_Resume.pdf)** — 1-page vector PDF resume tailored to **Research Engineer, Polaris (Job ID `114077679900074694`)**.
- **[`polaris_eval_task/`](./polaris_eval_task/)** — Complete executable Polaris evaluation task (`PROMPT.md` + 5-Gate `grader.py` + `scorecard_results.json`).

## Updating the Live Site

Run `./publish.sh` (or ask Gemini in Antigravity to update and push) to publish any changes immediately to GitHub Pages:

```bash
./publish.sh "Update portfolio"
```
