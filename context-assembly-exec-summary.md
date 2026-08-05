# Executive Summary

## Chatbot versus desktop-integrated AI tooling: context assembly, error propagation, and source authority

**Companion to:** `context-assembly-analysis.md` (full analysis, ~20,000 words), which applies `ai-error-framework.md` to the pilot scoped in `ai-office-integrations-teardown.md`.

**A note on compression, per the lesson of the framework's own Round 7 review:** every statement below is a simplification of a more carefully bounded claim in the full document. Where a finding is load-bearing for a decision, read the cited section rather than relying on the summary. Two places where compression is particularly lossy are flagged inline.

---

## What was asked, and the answer in one paragraph

The question was how chatbot and desktop-integrated AI tooling compare from a job-to-be-done perspective, with attention to error propagation, unreliable sources being pulled in, reliable sources being missed, and incomplete authority — separately for legal work and business services.

The answer is that they compare along a single variable — **who controls the corpus the model reads** — and that this variable does not behave the way the product framing suggests. Moving from a chatbot to integrated tooling transfers corpus selection from the fee-earner to the system. That transfer is simultaneously the entire efficiency case and the entire risk case, and it cannot be purchased in halves. The chatbot misses more material and warrants its conclusions better; the integrated tooling finds more material and warrants its conclusions worse. Neither dominates, so the decision is a deliberate allocation of which failure mode the firm prefers to carry, not a search for the safer option.

---

## Six findings that should change the pilot design

**1. "Less integrated" is not reliably "safer," and in one case the ranking inverts.**
The Office add-ins — the narrowest-looking, most conservative option — have the weakest audit position of anything assessed. Document content leaves the M365 estate, and **neither the Microsoft compliance stack nor Claude Enterprise audit logs record that it left** (Anthropic's own documentation; independently reproduced). Microsoft 365 Copilot has the widest possible context reach and the strongest governance instrumentation: tenant-resident, Purview-auditable, DLP-controllable, with documented site-level exclusion mechanisms. For privileged work, provability is not a secondary consideration — it is what supervision and recordkeeping duties actually require. A pilot designed on the assumption that narrower access is safer will get this backwards. *(Full analysis §1.3, §4.2.)*

**2. Integration does not fix the chatbot's omission problem — it hides it.**
A chatbot fails by not having the document, and that failure is visible: the fee-earner knows what they uploaded. An integrated tool fails by having the *wrong* document, or by having searched somewhere nobody can reconstruct — and it produces a confident answer either way. The omission is converted from visible to invisible. Because so much load-bearing legal output consists of negative claims ("no adverse authority," "no change-of-control restriction," "no MFN"), this is the most consequential finding in the analysis. *(§2.2, §4.2.)*

**3. A failure class not currently named anywhere: corpus indeterminacy.**
The framework requires that any negative conclusion carry an explicit coverage statement — *"no relevant clause in the 37 documents indexed as at this date"* is defensible; *"there is no relevant clause"* is not. Wide, opaque retrieval makes the defensible form **unavailable in principle**, because there is no enumerable corpus to state. The tool cannot supply the coverage boundary and the user cannot reconstruct it — though nothing in the interface prevents the claim being made anyway, fluently. Stated as a general proposition: *as context assembly widens, the set of claims a system can defensibly warrant narrows.* The curated chatbot's much-criticised limitation is, viewed as an assurance property, its principal virtue. *(§2.2, §7.2a.)*

**4. Business services is the lower-severity but higher-propagation use case, and needs different controls rather than lighter ones.**
Legal errors are severe but bounded: one matter, one client, with several independent parties motivated to find them. Business-services artefacts are built for reuse — a good deck becomes the sector template, a figure becomes "our number," a note enters KM and is consulted for years by people with no knowledge of its provenance — and they face no adversary. Holding the framework's consequence dimensions separately rather than averaging them: business services presents low severity, very high blast radius, very high persistence, low detectability, and high recurrence. That is the profile the framework identifies as capable of dominating total harm despite a low measured error rate. **The current Use Case B conditions protect the output and not the corpus it contaminates, which is where the larger harm sits.** *(§3.1, §5.2, §5.4.)*

**5. Multi-model cross-checking is largely unavailable as a control.**
Copilot's Word, Excel and PowerPoint creation Agents run *exclusively* on Anthropic models (Microsoft's documentation), so cross-checking a Claude add-in against a Copilot Agent is not an independent second opinion. More fundamentally: **a second model given the same contaminated corpus reproduces the same error regardless of whose weights it uses.** Independence has to come from a different mechanism — a deterministic version check, a DMS-sourced baseline, a human with a different corpus — not a different vendor. *(§6.3a.)*

**6. No tool in the pilot represents the firm's trust hierarchy over document locations.**
The firm already distinguishes an executed DMS document from a working draft, a colleague's speculation, a counterparty attachment, and an open-web source. That hierarchy exists in professional judgment and in no software in the pilot. Retrieval ranks by *relevance*, and relevance and authority are frequently anti-correlated — a superseded draft containing the exact contested language will often outrank the executed version that does not repeat it. This is not fixable by prompting; it is a corpus-definition problem, and therefore a firm-side control. *(§2.3.)*

---

## Corrections required to the teardown

Six, all checked against primary sources. Two change its stated conditions.

| | Correction | Effect |
|---|---|---|
| 1 | There are **two** products called Cowork. Anthropic's Claude Cowork (local filesystem access, granted folders, background and scheduled execution) is omitted entirely; it is the widest context surface in the comparison | Widens the exclusion — Condition A4 must name both |
| 2 | The add-in audit gap is **architectural at every tier including Enterprise**, not a below-Enterprise licensing issue, and add-ins do not inherit negotiated retention settings | Materially tightens conditions |
| 3 | The Claude add-ins **do** have a reachable effect channel: account-level connectors (Gmail draft, Slack message, calendar event) are attached regardless of the system prompt's stated limitations, which Anthropic confirms is product guidance rather than a security control | Tightens conditions |
| 4 | Copilot's Word/Excel/PowerPoint Agents run **exclusively on Anthropic models** | Removes multi-vendor cross-checking as a control |
| 5 | Matter-level isolation for Copilot is **no longer simply "not established"** — Restricted Content Discovery, Restricted SharePoint Search, DLP for Copilot and sensitivity labels are documented, usable exclusion mechanisms | Makes a pilot possible that the teardown had blocked |
| 6 | Anthropic models in Copilot are **excluded from the EU Data Boundary** and in-country processing commitments | Hard constraint for an EU-seated pilot; unmentioned in the teardown |

The teardown's central register note — that source-versus-authority grounding and matter-level isolation are the load-bearing gaps — survives. The analysis adds corpus indeterminacy as a third.

---

## Decisions

Per use case and per archetype, at a stated reliance level. **Compression warning:** each verdict below carries conditions that are load-bearing, not decorative; the verdict without its conditions is not the finding.

| Archetype | Legal work | Business services |
|---|---|---|
| **A — Curated chatbot** | **Approve-with-controls** — advisory, always reviewed; the only archetype supporting a defensible negative claim | **Approve** |
| **B — Office add-in** | **Pilot-only, narrower than currently scoped.** Word add-in excluded from privileged documents pending closure of the egress and audit gaps; cross-app off; account connectors removed; audit instrumentation or gateway routing enabled *before* launch | **Approve-with-controls.** Personal data excluded from the Word add-in; single-source-of-record rule per figure class; market-data connectors encouraged as the preferred grounding route |
| **C — Org-grounded (Copilot)** | **Pilot-only, with prerequisites that must complete first** — oversharing assessment and remediation, Restricted SharePoint Search for the pilot, Restricted Content Discovery on walled sites, labelling sufficient for DLP to be meaningful. Creation Agents excluded where EU residency applies | **Approve-with-controls** after the same prerequisites; clearance status implemented as a sensitivity label |
| **D — Autonomous agent** | **Out of scope** — both Claude Cowork and Copilot Cowork, named individually | **Pilot-only** for internal, reversible, non-client-facing work; single purpose-built folder grants only, never a Downloads folder or drive root; no unattended execution |
| **Legal research (Job L2)** | **Not in scope for any archetype.** Authority grounding is absent across the board, and research conclusions are overwhelmingly negative claims that corpus indeterminacy prevents warranting. Route to tools that can state a coverage boundary | — |

---

## The three controls that do most of the work

None is a vendor feature. All are cheap relative to their coverage. All would improve the firm's work whether or not the tooling is adopted — which is a reasonable test of whether a control is real.

**1. A corpus policy, per job, defined before tool selection.** For each approved job, state the authoritative corpus, what may be consulted with version confirmation, what is indicative only, what may be read as evidence of a third party's position but never as fact, and what is excluded. Then configure each tool so its *reachable* corpus approximates the *declared* one. Three of the eight legal losses identified have no tool-side control in any archetype, and all three are corpus-composition problems.

**2. A mandatory coverage statement on every negative or completeness claim.** Nearly free, and it targets the two failure classes that have no other check anywhere in the tool set. It does not require the indeterminacy problem to be solved to be useful: where a coverage statement cannot be constructed, the requirement surfaces that fact, converting an invisible assurance gap into a visible one.

**3. Provenance marking that survives acceptance.** Integration destroys provenance by design — an accepted tracked change is indistinguishable from author-drafted text, and that is the feature being purchased, not a defect. So marking must be a workflow convention with a document-level artefact behind it, plus a quarantine state and a named-approver promotion gate before generated content enters templates, credentials, KM or model libraries.

---

## Sequencing: the uncomfortable implication

Both use cases, at both meaningful reliance levels, converge on the same prerequisites: an oversharing assessment, permission remediation, a labelling programme, a defined authoritative corpus per job, and audit instrumentation. **None of this is AI work, and all of it is a precondition for the AI work to be defensible.**

The practical consequence is that the fastest defensible route to a useful pilot probably begins with several weeks of SharePoint and permissions work rather than a tool deployment. A pilot run in parallel with remediation will produce evidence that cannot be interpreted, because a corpus-contamination failure will be indistinguishable from a tool failure. This is an argument for sequencing, not delay: scope the first phase to a small, deliberately constructed, clean corpus rather than the live estate.

Ten evidence gaps are recorded with named owners and closing actions (§7.1). Two are most likely to be skipped and most damaging if they are: independently reproducing the add-in egress behaviour against the firm's own build, on which a load-bearing restriction rests; and **measuring the human baseline before the tool is deployed rather than alongside it**, without which the comparison will be asymmetric in precisely the way the framework warns about.

---

## What remains open

Six questions are set out for discussion (§7.3). Three bear most directly on whether the pilot as designed is defensible.

**Whether a heavily restricted Archetype B pilot teaches anything.** By the time cross-app is off, connectors are removed, Word is excluded from privileged material and audit instrumentation is mandatory, most of what makes the add-ins attractive relative to the chatbot has been configured away. Piloting a configuration nobody would deploy may not be a good use of pilot capacity — against which, the restrictions are tied to closeable gaps and in-file tracked-change drafting is genuinely better than transcription.

**How much weight unprovability should carry on its own.** The Word restriction is the tightest condition in the analysis and rests on one independent finding, vendor-confirmed as designed but not independently audited. Against it: the same reasoning would exclude a good deal of cloud tooling the firm already uses without objection. For it: that tooling sits inside the firm's audit perimeter and this does not. Resolving this is a risk-appetite judgment, not a technical one.

**Whether some of these hazards are new or merely newly visible.** Microsoft's position on oversharing is that Copilot does not create the problem but makes an existing one visible. That argument deserves the same hearing when it cuts in the tooling's favour. The firm does not currently know how often a fee-earner today reviews against a wrong baseline version. If that happens more often than the tool does it, the tool is an improvement on a dimension this analysis has treated throughout as a pure risk. Taking that possibility seriously is the same discipline as taking the risks seriously.
