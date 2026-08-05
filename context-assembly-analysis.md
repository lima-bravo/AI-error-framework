# Where the Corpus Comes From: Chatbot versus Desktop-Integrated AI Tooling

## A job-to-be-done analysis of context assembly, error propagation, and source authority, for legal work and business services work

**Status:** Draft for circulation. Companion to `ai-office-integrations-teardown.md` (the product comparison) and `ai-error-framework.md` (the analytical discipline). This document applies the second to the first, along one specific axis that neither yet treats as its organising variable.

**Scope:** The interaction architectures available for the two pilot use cases — conversational (chatbot), document-scoped (Office add-in), organisation-grounded (in-app assistant with tenant retrieval), and autonomous (desktop or cloud agent) — assessed for how each assembles the material it reasons over, and what follows from that for error propagation.

**Method:** `ai-tool-teardown` five-function decomposition and hazard-first derivation, run under the error-propagation discipline of `ai-error-framework.md` Sections 3 (job definition), 11 (error to hazard), 12 (propagation topology), 13 (verification as assurance argument), and 14 (operational resilience). Findings are evidence-labelled. Depth is scaled per the proportionality principle in Section 3 of the framework: the legal analysis is run at full depth, the business-services analysis at the depth its consequence profile actually warrants, which turns out to be greater than first appears — for reasons developed in Part 5.

**Evidence labels used throughout:** `[observed]` — a measured or reproduced test result. `[documented]` — the vendor's own technical or support documentation. `[independent]` — third-party security research or assurance. `[contractual]` — a term in a DPA, product terms, or licence. `[vendor-asserted]` — a claim in marketing or product materials only. `[inference]` — this document's reasoning from the above. `[not established]` — an open evidence gap, per the framework's discipline that silence is neither confirmation nor absence.

---

## Preamble: what this document adds, and the corrections it requires

The teardown compares four products across a feature matrix and reaches conditional verdicts. The framework supplies the discipline for reasoning about how error enters, propagates, and becomes harm. Both are sound. Neither yet asks the question that the pilot's actual risk turns on.

That question is: **who decides what the model reads?**

The teardown treats context assembly as one row in a comparison table ("org-data grounding"). The framework treats it as the first of five functions and correctly names its failure mode as silent. But the pilot decision in front of you is not really a choice between vendors. Generation is converging and, as the teardown already notes, is the least differentiating factor. The choice is between **interaction architectures that differ in how much of the corpus-selection decision they take away from the fee-earner** — and every hazard raised in the original brief (unreliable sources pulled in, reliable sources missed, incomplete authority, error propagation) is a downstream consequence of that single transfer.

Stated as the thesis this document defends:

> Moving from a chatbot to desktop-integrated tooling transfers control of context assembly from the human to the system. That transfer is simultaneously the entire efficiency case and the entire risk case. It cannot be bought in halves. What can be engineered is whether the system's reachable corpus is made to match the corpus the job actually authorises — and that is a firm-side control, not a vendor feature.

Two consequences shape the rest of the analysis, and both cut against intuition.

**First, "less integrated" is not reliably "safer."** The narrowest-looking archetype in the set — an Office add-in scoped to the open document — turns out to have the bluntest egress behaviour and the weakest audit position of any option assessed. The widest-scoped archetype — Copilot grounded in the whole Microsoft Graph — has the strongest governance instrumentation. Scope of access and observability of access are independent variables, and the products differ oppositely on them. Part 4 develops this; it materially changes the pilot design.

**Second, the chatbot's characteristic failure is not fixed by integration — it is hidden by it.** A chatbot fails by not having the document. That failure is loud: the fee-earner knows what they uploaded. An integrated tool fails by having the wrong document, or by having looked somewhere nobody can reconstruct. That failure is silent, and it converts an omission the reviewer could have caught into one they cannot. For legal work, where the load-bearing claims are frequently negative ("no adverse authority," "no change-of-control restriction," "no MFN"), this is the central finding of the document.

### Corrections to the teardown

Six points require amendment before the comparison can carry weight. All were checked against primary sources. Two are material enough to change the teardown's stated conditions.

**1. There are two products called Cowork, and the teardown captures the wrong one.** Anthropic's **Claude Cowork** launched January 2026 as an agentic desktop capability with granted-folder access to the local filesystem, browser control, connectors, sub-agents, scheduled and background tasks, and since July 2026 web and mobile surfaces `[documented]`. Microsoft's **Copilot Cowork** launched June 2026, runs in Microsoft's cloud, and acts on documents held in the customer's M365 tenant rather than on local files `[documented]`. The teardown lists Cowork only in the M365 Copilot column. That is not wrong as far as it goes, but it omits the higher-scope product entirely, and Claude Cowork is the single widest context-assembly surface in the whole comparison — it is the only archetype that can reach the local filesystem, including Downloads folders, personal drives, and anything else sitting on a fee-earner's machine. Use Case A's condition 4 ("no Cowork-style autonomous multi-step execution") reads as though it excludes a Microsoft feature. It needs to exclude both, and it needs to say so by name.

**2. The Claude add-in audit gap is architectural, not a licensing tier.** The teardown records "Not in audit logs / Compliance API below Enterprise." Anthropic's own documentation states, without qualification by tier, that the Excel, PowerPoint, Word, and Outlook add-ins "do not inherit custom data retention settings your organization may have set, and activity is not currently included in Enterprise audit logs, the Compliance API, or data exports" `[documented]`. Independent security research confirms the corresponding gap on the Microsoft side: add-in traffic goes to Anthropic's API rather than a Microsoft endpoint, so Purview, the Compliance API, and M365 audit do not see it either `[independent, observed]`. The correct finding is a **dual blind spot at every tier including Enterprise**, and a firm's negotiated retention terms not applying to this traffic. That is considerably more serious than the teardown implies, and it bears directly on recordkeeping and supervision duties.

**3. The Claude add-ins do have a reachable effect channel.** The teardown assesses exfiltration risk via effect channels as "moderate for Claude's Word add-in (write-in-place, gated by tracked changes)" and describes the add-ins as "explicitly non-autonomous." Non-autonomous is right. But independent research found that the Excel and PowerPoint system prompts contain a "Limitations — What You Cannot Do" section stating the model cannot send emails or connect to external services, while the same request attaches the user's account-level MCP connector tools — Gmail draft creation, Calendar event creation, Slack message sending — to the tools array. A single conversational follow-up is sufficient to reach them. Anthropic's position, given under responsible disclosure, is that this text is product guidance rather than a security control, and the behaviour is as designed `[independent, observed; vendor position documented]`. The operative finding: **account-level connectors are surface-wide.** Any connector enabled anywhere on a Claude account is available from inside the Office add-ins, regardless of what the model says about its own capabilities. This is an effect and egress channel, not merely write-in-place.

**4. Copilot's Word, Excel, and PowerPoint Agents run exclusively on Anthropic models.** The teardown's model row reads "Microsoft's mix by default; Claude available if admin-enabled (Frontier)." Microsoft's documentation states of these specific creation agents: "These agents exclusively use Anthropic's AI models," mandatory for the agents to function, with admin ability to block the provider `[documented]`. Copilot Cowork is also reported as partly Claude-powered. Broader Copilot surfaces do use OpenAI models, so the teardown's row is right about Copilot generally and wrong about the agents specifically. This matters for one reason developed in Part 4: it removes multi-vendor cross-checking as an available control across much of the pilot surface.

**5. Matter-level isolation for Copilot is no longer simply "not established."** The teardown records it as an open gap for all four products. For Copilot specifically, Microsoft documents several controls that bear directly on it: **Restricted Content Discovery**, which blocks an entire SharePoint site from Copilot and agent processing regardless of user permissions; **Restricted SharePoint Search**, explicitly recommended as a temporary narrowing measure during a Copilot pilot; Purview **DLP for Copilot**, which blocks processing or referencing of files carrying specified sensitivity labels; and sensitivity labels themselves, with Highly Confidential blocking summarisation by default `[documented]`. None of this is matter-level ACL synchronisation in the sense the teardown's checklist asks for, and none of it substitutes for the firm's own permission hygiene. But it is a set of documented, site- and label-scoped exclusion mechanisms, which is materially more than nothing, and it is directly usable as pilot scaffolding. The honest finding is: **matter-level isolation is not a property of the tool, but matter-scoped exclusion is achievable through documented controls if the DMS and SharePoint estate are structured to support it.**

**6. Anthropic models in Copilot are excluded from the EU Data Boundary.** Microsoft's documentation states that Anthropic operates as a Microsoft subprocessor for these capabilities from 7 January 2026, under Microsoft Product Terms and the Microsoft DPA with Microsoft accountable for compliance, covered by Enterprise Data Protection and the Customer Copyright Commitment — and then: "Note that Anthropic models are currently excluded from EU Data Boundary and when applicable, in-country processing commitments" `[documented, contractual]`. The teardown does not mention this. For a pilot run from an EU-seated office, and for any matter under outside-counsel guidelines or a protective order specifying EU or in-country processing, this is a hard constraint on the Word/Excel/PowerPoint Agents, not a risk to weigh. It should be checked for current status before the pilot starts, since it is flagged as a present-tense exclusion that may change.

None of these six corrections changes the teardown's overall shape. Corrections 2, 3, and 6 tighten conditions; correction 1 widens the exclusion; corrections 4 and 5 change which controls are available. The teardown's central register note — that source-versus-authority grounding and matter-level isolation are the load-bearing gaps — survives intact, and Part 4 argues it should be joined by a third.

---

## Part 1 — Scoping the tool set

### 1.1 Why the vendor axis is the wrong axis

A four-column vendor comparison implies the choice is Anthropic versus Microsoft versus OpenAI. For this pilot, that framing misleads in three ways.

It **understates within-vendor variation.** Claude's own products span the entire architectural range assessed here, from a chatbot with no organisational reach to an agent with local filesystem access. The distance between Claude chatbot and Claude Cowork, on every axis this analysis cares about, is far greater than the distance between Claude for Word and ChatGPT for Excel. Treating "Claude" as one column collapses the variable that matters.

It **overstates between-vendor variation** in generation, which the teardown already identifies as the least differentiating factor, and which correction 4 above shows is partly the same model underneath in any case.

And it **obscures the actual decision**, which is not "which vendor" but "which interaction architecture, for which job, with what corpus reachable." A firm could reasonably deploy three architectures from one vendor with three different verdicts, or the same architecture from two vendors with the same verdict.

The productive classification is therefore by **context assembly architecture**: what the system can reach, who decided it could reach it, and whether anyone can afterwards say what it actually read.

### 1.2 The four archetypes

**Archetype A — Curated-context chatbot.**
*Instances:* Claude chatbot (web, desktop, mobile); ChatGPT (chatgpt.com, desktop, mobile); Copilot Chat used as a bare chat surface without tenant grounding.

The user assembles the corpus by hand, one paste or upload at a time. Nothing enters context that the user did not deliberately put there. There is no effect channel: output leaves the tool only when a human copies it out. In framework terms this is the thinnest possible context assembly and a null effect function, with the entire control function residing in the human's hands and attention.

*Corpus:* enumerable, user-known, deliberately chosen, and typically small.
*Reachable location classes:* whatever the user has open and chooses to move. Plus, where connectors or web search are enabled, an unbounded external surface — which is an important qualification, since a chatbot with connectors to SharePoint, Google Drive, Gmail, or the open web is no longer Archetype A on the corpus axis, even though it still is on the effect axis. Connector-enabled chat is better understood as Archetype C with a manual effect channel.

**Archetype B — Document-scoped add-in.**
*Instances:* Claude for Word, Excel, PowerPoint, Outlook; ChatGPT for Excel and PowerPoint (GA across plans, May 2026) and the ChatGPT app for Office pane in Business/Enterprise tenants; third-party GPT-for-Word style add-ins calling the OpenAI API with a user-supplied key.

A task pane sits beside the open file, reads it, and writes into it. Anthropic documents the boundary explicitly: Claude "can only read from and write to files that are currently open" and "cannot create, open, close, or switch files directly from the add-ins" `[documented]`. That is a real and meaningful constraint, and it is the reason this archetype looks conservative.

Three qualifications undercut the appearance.

*Cross-app scope.* With "Let Claude work across apps" enabled, the corpus is not the open document but **every file opened during the session across Word, Excel, PowerPoint, and Outlook, with context carried forward automatically** — including, per the documentation, "your Outlook emails and full thread history, including attachments" `[documented]`. The boundary is the session, not the document. Connected-file indicators are surfaced in the interface, which is a genuine and creditable affordance. The default state differs by plan: on for Pro and Max, off for Team and Enterprise `[documented]` — so an individually-subscribed fee-earner has the wide behaviour by default and a firm-provisioned one does not.

*Egress asymmetry between add-ins.* Independent research, reproduced with planted sentinel values including an end-of-document canary, found that Claude for Word transmits the **entire document body** in every request regardless of the prompt's relevance to it — the test prompt was an arithmetic question with no topical overlap, and all sentinels including the final canary appeared in the request body. Excel and PowerPoint behave differently: the first request carries only structural metadata, with content fetched on demand via subsequent tool calls when the prompt requires it `[independent, observed]`. Anthropic has confirmed the behaviours as designed. The operative point for the pilot is that **the data-handling posture of one add-in does not transfer to another**, and Word — the add-in most relevant to legal work — has the bluntest posture.

*Connector reach.* Per correction 3, account-level MCP connectors are attached and reachable from within the add-ins. Anthropic also supports MCP connectors in the add-ins by design, including admin-configured gateways, and ships connectors to premium financial and market data providers `[documented]`.

*Corpus:* the session's opened files, plus any account-level connector surface. Semi-enumerable at best: the connected-file indicators cover the Office side, not the connector side.

**Archetype C — Organisation-grounded in-app assistant.**
*Instances:* Microsoft 365 Copilot chat with Graph grounding; Copilot in-app in Word, Excel, PowerPoint; Copilot Agent Mode (GA in Word, Excel, PowerPoint from 22 April 2026); the Word, Excel, and PowerPoint creation Agents; Copilot Notebooks and Business Chat. Also, functionally, any chatbot with DMS, SharePoint, or mail connectors enabled.

The system retrieves across the organisational estate on the user's behalf. Microsoft's description of the creation agents is precise about the mechanism: they "use Work IQ to retrieve information from files, emails, meetings, and sites that you personally have permission to access," with Microsoft performing the searches and passing only relevant context to the model, and sensitivity labels and compliance policies respected `[documented]`.

The architecture is permission-respecting by design and does not grant access the user lacks. That is genuinely the right shape for matter isolation — conditionally. The condition is that the firm's own ACLs already encode the barriers, which is the point the teardown makes correctly and which Microsoft's own guidance makes bluntly: oversharing "is not a Microsoft 365 problem; it is a permission hygiene problem," and Copilot "does not create the oversharing problem: it makes an existing permissions problem visible" `[documented, vendor-asserted]`.

The framework-relevant sharpening of that point, and it is the crux of this archetype: **before retrieval, an over-permissive ACL was protected by obscurity.** A document a fee-earner could technically open but would never navigate to was safe in practice, and the practical safety was doing load-bearing work that nobody had accounted for as a control. Retrieval removes obscurity. The permission surface does not change; the *effective* exposure surface changes completely. This is precisely the framework's Section 12 observation that an error — here, a latent misconfiguration — can become materially more dangerous after it leaves the component that created it, without anything about that component changing.

*Corpus:* everything the user can access across SharePoint, OneDrive, Exchange, Teams, and meetings, plus web grounding. Not enumerable by the user, and not enumerable after the fact except through Purview.

**Archetype D — Autonomous agent.**
*Instances:* Claude Cowork (desktop, with granted-folder local filesystem access, browser control via Claude in Chrome, computer use, connectors, sub-agents, scheduled and background tasks; also web and mobile surfaces without local file access); Copilot Cowork (cloud, acting on tenant-held documents, long-running, continues when the user's machine is off); Copilot Studio agents; multi-agent chains where agents invoke other agents.

The agent decides its own corpus over multiple steps, and acts. Claude Cowork's documented posture includes explicit folder grants, configurable approval before certain actions, logged file operations, and revocable access `[documented]` — real controls, and better than the archetype's risk profile would lead one to expect. Reported product materials also describe built-in self-verification in which the agent checks its own work before reporting back `[vendor-asserted]`, which is worth naming precisely as what the framework calls a nested generation block inside the verification function: it is a check, but not an independent one.

*Corpus:* agent-selected within granted bounds, across steps, potentially including local filesystem, browser sessions, connectors, and tenant content. Not enumerable in advance even in principle, since selection is part of what the agent does.

### 1.3 The archetypes do not form a single ladder

It is tempting to read A → B → C → D as increasing integration and therefore increasing risk. That reading is wrong and it will produce a bad pilot design. The archetypes vary on at least six axes that do not move together.

| Axis | A — Chatbot | B — Add-in | C — Org-grounded | D — Agent |
|---|---|---|---|---|
| **Corpus determinacy** — can the user say afterwards what was read? | High: they assembled it | Partial: Office files indicated; connector reach not surfaced | Low: retrieval is opaque at use time | Very low: selection is agent-decided across steps |
| **Corpus authority** — is what was read the authoritative version? | User's responsibility, and user knows it is | Whatever happened to be open, including superseded drafts and counterparty attachments | Whatever ranks well in retrieval, across all trust tiers at once | Whatever the agent finds, including local scratch files |
| **Egress observability** — can the firm prove what left? | Deliberate, user-initiated, but unlogged in chat unless Enterprise logging applies | **Neither M365 nor Claude audit records it** | **Strongest: Purview captures interactions, discoverable and auditable** | Local file operations logged to the user; enterprise-side varies |
| **Human checkpoint density** | Maximum: every token crosses a human hand | Moderate: tracked change or cell write, accept/reject | Low: agent produces a finished artefact | Minimal: multi-step, sometimes unattended |
| **Effect reversibility** | N/A — no effect channel | Reversible in-document; connector actions (draft, message, invite) are not | Reversible in-document; file creation and mail actions less so | Weakest: multi-step effects, some irreversible |
| **Omission visibility** | High: user knows what they did not supply | Moderate | **Low: the tool appears to have looked** | Very low |

Read down the columns and the intuitive ranking breaks in two places.

**Break one:** Archetype B, the most conservative-looking option, is worst on egress observability — worse than the chatbot and dramatically worse than Copilot. A firm choosing add-ins over Graph-grounded Copilot on the theory that narrower access is safer would be trading a *controllable, provable, wide* surface for an *uncontrolled, unprovable, narrower* one. For anything privileged, provability is not a secondary consideration; it is what supervision and recordkeeping duties actually require.

**Break two:** Archetype A is best on corpus determinacy and omission visibility, which are exactly the properties that support defensible negative claims — and legal work is unusually dependent on negative claims. The chatbot's much-criticised limitation (you have to feed it everything) is, viewed as an assurance property, its principal virtue.

This is why no single verdict on "chatbot versus integrated" is available. The honest output of the comparison is a per-job, per-archetype assignment, which is what Parts 4 and 5 produce.

### 1.4 In scope and out of scope

**In scope:** the four archetypes above, as instantiated in Claude chatbot and Cowork, Claude for Word/Excel/PowerPoint/Outlook, Microsoft 365 Copilot chat and in-app and Agent Mode and the creation Agents and Copilot Cowork, and ChatGPT chat and ChatGPT for Excel/PowerPoint and the Office pane.

**Out of scope but adjacent, and flagged because the comparison is incomplete without acknowledging them:** purpose-built legal platforms (Harvey, Legora), assessed separately per the teardown. Their relevance here is one specific question raised in Part 4 — whether general-purpose office AI is the right *category* for any legal task whose load-bearing claims are negative, or whether that class of work belongs with tools that can state a coverage boundary. Also out of scope: Claude Tag (Slack-resident), Claude in Chrome as a standalone, Claude Code, and the Gemini/Workspace equivalents, none of which are in the pilot as described.

**Explicitly noted as a scoping risk:** third-party Office add-ins that call a model API with a user-supplied key. These sit outside procurement, outside the firm's DPA chain, and outside any audit surface, and they are trivially installable in Word. They are not part of the pilot but they are part of the estate the pilot will be judged against, and a pilot that does not name them is likely to be blamed for them.

---

## Part 2 — Scoping the analysis

### 2.1 What kind of analysis this needs, and what it does not

The framework's proportionality principle (Section 3) says depth should scale with consequence, irreversibility, scale, sensitivity, and opacity — not with the mere presence of AI. Seven of the framework's named triggers for deeper analysis are present in the legal use case: privileged information, external client reliance, weak verification, high-volume reuse, persistent organisational memory, large blast radius, and — the one this document adds — **opacity of the retrieval step itself**. That justifies the full apparatus for Use Case A.

For business services, four triggers are present: personal data, some external reliance, high-volume reuse, and persistent organisational memory. Notably, the two that are *absent* are the two that drive severity (privilege, irreversible third-party action), while the two that drive *propagation* are both present. Part 5 argues this makes business services a lower-severity, higher-propagation problem requiring different controls rather than fewer.

What this analysis is **not**: it is not an evaluation, in the framework's sense. No performance figures are measured here, and none are asserted. Where a verification property would ordinarily carry a sensitivity or coverage number, this document writes "not established" rather than an estimate — following the framework's own warning (Appendix B, item 8) that a plausible-looking figure produced by on-the-spot judgment is worse than an honest blank, because it borrows the authority of measurement without the substance. Part 3 specifies what would have to be measured to fill those blanks.

### 2.2 The failure classes, stated in framework vocabulary

The original brief named four concerns. Mapping them onto the framework's vocabulary reveals that they are not four instances of one thing, and that two further classes belong alongside them. All six are distinct: each has a different mechanism, a different detection method, and a different control, and none is fixed by the remedy for the others.

**Class 1 — Corpus contamination: unreliable sources pulled in.**
Framework location: context assembly failure, surfacing as a *context* failure on the Section 9 ladder (information was available and wrongly weighted) or as *adversarial* where the content is hostile. The material entering context is genuine but wrong for the purpose: a superseded draft, another matter's document, an internal speculation treated as firm position, a counterparty's characterisation treated as fact, an unvetted template.

Detection is hard for a specific and under-appreciated reason: **the output passes every axis of the diagnostic ladder.** It is well-formed, internally coherent, faithful to the sources it was given, and correctly responsive to the question. A citation check confirms the quoted passage exists and says what is claimed. The failure is entirely in the *selection* of what to be faithful to, and no check applied to the output can see it. Only a check applied to the corpus can.

**Class 2 — Corpus deficiency: reliable sources missed.**
Framework location: *omission* in the Section 11 vocabulary; *environment* failure on the Section 9 ladder where the information was never made available at all; and in Section 13's terms, a failure of **search coverage** (was the relevant universe examined?) or **scope adequacy** (was the universe correctly defined?), as distinct from **claim validity**.

The framework's worked example — an OCR step drops a page, retrieval never sees the change-of-control clause, the model correctly concludes no restriction exists, the citation checker passes because it checks claims made rather than claims required — is exactly this class, and Part 4 builds the archetype-specific version of it.

**Class 3 — Authority grounding gap: incomplete or invalid authority.**
Framework location: the Section 4 split between *source grounding* (faithful to documents given) and *authority grounding* (is the cited authority valid, in-jurisdiction, still good law).

The teardown's register note is correct that no vendor establishes authority grounding, and this document does not improve on that finding. It adds one observation about why the gap is worse than a simple absence: a clickable citation into the open document is a **source-grounding artefact presented in the visual idiom of verification.** Per the framework's Section 7 point about confidence-raising without accuracy-raising, this *increases* the verification tax rather than lowering it, because it invites a reviewer to calibrate scrutiny to the presence of a citation. A tool with no citations at least prompts the question. A tool with source-grounded citations answers a different question convincingly.

**Class 4 — Propagation: error movement and transformation.**
Framework location: Section 12 in full — the eight node-level transformations (introduced, preserved, amplified, attenuated, masked, converted, accidentally compensated, embedded in state) and the four shapes (serial, fan-out, feedback, common-cause).

Two of the four shapes deserve advance flagging because the archetype choice determines them almost entirely. **Feedback propagation** — output re-entering as future context, precedent, or organisational memory — is governed by how directly the tool writes into durable artefacts, which is precisely the A/B/C/D distinction. **Common-cause propagation** is governed by model concentration, and correction 4 above establishes that the pilot's apparent multi-vendor diversity is partly illusory.

**Class 5 — Corpus indeterminacy: nobody can state what was searched.**
*This class is not named in either source document, and it is this analysis's principal addition.*

Framework location: it is the precondition for Section 13's requirement that any negative conclusion carry an explicit coverage statement. The framework states the requirement precisely: *"no relevant clause was found in the 37 documents indexed as of this date, searched against these clause categories"* is defensible and checkable; *"there is no relevant clause"* is not, and conflating the two is how an omission becomes invisible.

The finding: **wide, opaque context assembly makes the defensible form of that statement unavailable in principle, not merely unavailable in practice.** If retrieval selected an unknown subset of an unenumerated corpus, there is no coverage statement to make. The tool cannot supply one, the user cannot reconstruct one, and the negative claim therefore cannot be made in defensible form at all — although nothing about the interface prevents it being made anyway, fluently and confidently.

This is distinct from Class 2. Corpus deficiency is *missing something*. Corpus indeterminacy is *being unable to say what you looked at*, which persists even when nothing was missed. A tool can retrieve perfectly and still leave you unable to warrant the result. Conversely, the chatbot can miss a great deal while leaving the coverage boundary perfectly stateable — which is why, on this axis alone, it outperforms everything more sophisticated.

Legal work is unusually exposed here because so many of its load-bearing outputs are negative or completeness claims: no adverse authority, no change-of-control provision, no MFN, no assignment restriction, no conflicting engagement, nothing responsive in the review population. Business services is less exposed, but not unexposed: "we have no conflicting relationship in this sector," "no prior engagement with this counterparty."

**Class 6 — Egress opacity: nobody can prove what left.**
Also not named in either source document. Distinct from a confidentiality breach: this is about *provability*, not exposure.

Framework location: Section 13's consequence dimensions **observability** ("will the organisation even know the relevant event occurred") and **attribution** ("can the organisation identify which component or decision was responsible"), plus the teardown's point-in-time reproducibility requirement.

The finding, from corrections 2 and 3: for the Claude Office add-ins, document content leaves the M365 estate on prompts, and **neither the Microsoft compliance stack nor Claude Enterprise audit logs record that it left** `[documented, independent]`. Cross-app session chat history is additionally not saved between sessions `[documented]` — which reduces cross-matter persistence, a genuine benefit, while further eroding reconstructability.

Why this is its own class rather than a governance footnote: an organisation can absorb an exposure it can characterise. It cannot easily absorb one it cannot characterise. If a privilege question arises eighteen months after a matter closes, the question asked will be *what specifically was transmitted, when, and to whom* — and for this archetype, on current evidence, the firm's honest answer is that it cannot reconstruct it from its own records. That converts a bounded incident into an unbounded one, which is exactly the risk asymmetry the teardown method warns to bias against.

### 2.3 The source-location trust ladder

The original brief's concern — that these tools "can pull in documents from different locations available to them, leading to unexpected results" — is Class 1 and Class 5 acting together. It is worth making concrete, because the abstraction hides the actual problem.

A law firm's professional judgment already operates a trust hierarchy over document locations. It is rarely written down, which is the difficulty.

| Tier | Character | Examples | Freshness | Appropriate reliance |
|---|---|---|---|---|
| **T1** | Authoritative, current, matter-scoped | Executed documents in the DMS; approved precedent bank; Westlaw/Lexis; firm-approved templates; the engagement letter | Verified | Full, within its terms |
| **T2** | Authoritative but scope- or version-uncertain | DMS working drafts; superseded versions; *another matter's* documents (correct in themselves, wrong here); closed-matter files | Unverified | Only with version and matter confirmed |
| **T3** | Firm-internal, unvetted | Personal OneDrive; Downloads folder; local desktop copies; email drafts; Teams chat; meeting transcripts; a colleague's working note | Unknown | Indicative only; never as a firm position |
| **T4** | External, relevant, untrusted | Counterparty redlines; opposing-counsel correspondence and attachments; client-supplied material | Unknown | As evidence of what the counterparty said, never as fact |
| **T5** | External, unbounded | Open web; third-party MCP connectors; live browser sessions | Unknown | Not without independent confirmation |

Now the two findings that matter.

**Finding 2.3a — No archetype represents this hierarchy at all.** In every one of the four, context assembly treats every reachable location as equally authoritative. There is no trust label on a retrieved chunk, no tier annotation in the context window, no mechanism by which a T3 scratch file is weighted below a T1 executed document. The hierarchy exists in the professional judgment of the fee-earner and in no piece of software in the pilot. Retrieval ranks by relevance; it does not rank by authority, and relevance and authority are frequently anti-correlated — a superseded draft containing the exact contested language will often rank *above* the executed version precisely because the language is there in a form that matches the query.

The corollary is that this is not a prompt-engineering problem and cannot be fixed by instruction. It is a corpus-definition problem, which makes it a firm-side control.

**Finding 2.3b — Reachable tiers rise as user awareness of which tier was used falls.** This is the single most compact statement of the architectural risk.

| Archetype | Tiers reachable | Which tier was used? |
|---|---|---|
| A — Chatbot | T1–T4 by deliberate act; T5 if web/connectors enabled | Known — the user selected each item |
| B — Add-in | T1–T4 via open files, prominently **T4 via Outlook thread attachments**; T5 via account connectors | Partly indicated for Office files; not for connectors |
| C — Org-grounded | T1–T3 across the whole estate, T4 via mail, T5 via web grounding | Not surfaced at use time; reconstructable only via Purview |
| D — Agent | All tiers, including **T3 local filesystem**, across multiple self-directed steps | Not knowable in advance; partially logged after |

Archetype D's local filesystem reach is worth dwelling on, since it is the tier most likely to be underestimated. A fee-earner's Downloads folder is a T3 location containing, typically: draft documents from several matters, counterparty attachments saved for convenience, superseded versions, and material from matters the fee-earner is no longer on. Granting an agent a folder is a governance act with matter-isolation consequences, and it will not feel like one to the person doing it.

### 2.4 Method for Parts 4 and 5

For each use case, run in this order:

1. **Cynefin domain check** first, per the framework's instruction that this belongs alongside job definition and before specification difficulty or verification strength are assessed at all.
2. **Job definition** using the framework's template, plus the five-way distinction between job, decision, task, output, and effect, and a use-and-reliance description sufficient to identify who is authorised to decide, approve, communicate, and act.
3. **Per-archetype context assembly trace**, against the six failure classes and the trust ladder.
4. **Propagation topology** with at least one worked example grounded in verified product behaviour rather than hypothetical.
5. **Hazard-first derivation**: unacceptable losses → hazards → controls → evidence for each control, per the framework's rule that a control with no evidence is an assumption.
6. **Verification schema** for the checks actually available, recording target, coverage, independence, and freshness — and recording "not established" where sensitivity and specificity have not been measured.
7. **Job drift analysis**, since the archetypes differ in how much drift their affordances invite.
8. **Conditional decision** per archetype, with conditions, residual risks, owners, evidence gaps, and review triggers.

---

## Part 3 — The plan for the two use cases

### 3.1 Why the two analyses must be run separately, and why the divergence is not the obvious one

The teardown identifies the central divergence as **grounding stakes** (authority grounding matters enormously in legal, barely at all in business services) and **isolation stakes** (matter-level ethical walls matter enormously in legal, tenant-level isolation is probably sufficient in business services). Both are right.

This analysis identifies a third divergence that the teardown's framing obscures, and it runs in the opposite direction to the first two:

**Propagation stakes are higher in business services than in legal work.**

The reasoning. Legal work is bespoke per matter, has strong pre-existing review gates (partner review, client sign-off, opposing-counsel scrutiny, sometimes a court), and its artefacts are mostly matter-specific. An error has high severity and, usually, a bounded blast radius — one matter, one client, one document — with several independent chances of detection.

Business-services artefacts are **designed to be reused.** A pitch deck becomes the sector template. A financial model becomes the model. A matter description enters the credentials database and is drawn on for years. A KM note becomes the answer to the question. The artefacts are fan-out machines by construction, and they have thin review gates precisely because they are internal and low-severity per instance. An error has low severity and a very large blast radius, with high persistence and — because the artefact is authoritative-looking and internally sourced — low detectability.

Under the framework's Section 13 consequence mechanics, which insists that severity, detectability, reversibility, blast radius, and persistence be held simultaneously rather than averaged, the two use cases do not differ in overall risk as much as their severity difference suggests. They differ in the *shape* of the risk. The practical consequence for the pilot: **business services needs different controls, not lighter ones.** Specifically it needs corpus hygiene and promotion gates — the Section 14 controls on organisational state — where legal needs coverage statements and matter isolation.

### 3.2 Job definitions

The framework's template: *When [a defined circumstance arises], [a defined actor] needs to [make progress or reach a decision], using [specified information and expertise], so that [the intended operational outcome] can occur.*

#### Legal — Job L1: counterparty document review

> When a client matter requires review of a counterparty-drafted or counterparty-amended document, the responsible fee-earner needs to identify every provision that departs from the client's or firm's accepted position and assess the significance of each, using the executed and last-exchanged versions in the DMS, the client's playbook or outside-counsel guidelines, and the governing law of the matter, so that the deal team can escalate, negotiate, price, or knowingly accept each departure early enough for that decision to change the transaction.

The five-way distinction, which is where the job-level failures live:

- **Job:** departures identified and escalated in time to change the deal.
- **Decision:** which departures to push on, which to trade, which to accept.
- **Task:** review the document; produce an issues list or redline.
- **Output:** the issues list, redline, or memo.
- **Effect:** a redline sent to the counterparty; a term accepted; advice given.

The job-level failure mode that no output-level check can catch: the review is complete, correct, and well-cited **against the wrong baseline version**, or omits a side letter that was never in scope, or arrives after the negotiation call. In each case every axis of the Section 9 ladder passes.

#### Legal — Job L2: legal research support

> When a matter raises a question of law requiring authority, the fee-earner needs to identify the controlling authority and the principal adverse authority, using authoritative legal databases for the relevant jurisdiction as at the current date, so that the advice given rests on law that is current and in-jurisdiction.

Separated from L1 deliberately. L2 is the job where the authority-grounding gap is dispositive rather than merely relevant, and where — per Part 4's conclusion — the answer is likely that none of the four archetypes is the right category of tool.

#### Legal — Job L3: internal drafting and triage

> When a fee-earner is preparing internal work product — a first-pass structure, a summary of a long document for a colleague, triage of a comment thread — they need to reduce the time spent on mechanical composition, using material already in their possession, so that expert attention is redirected to judgment rather than transcription.

Lowest reliance in the set, and the job where the efficiency case is strongest and cleanest. Worth separating precisely so that the controls appropriate to L1 and L2 are not imposed on L3 and thereby discredited.

#### Business services — Job B1: pitch and credentials assembly

> When the firm pursues a mandate, the BD lead needs to assemble materials that accurately represent relevant firm experience, the proposed team, and commercial terms, using approved matter descriptions, cleared client references, and current financial and market data, so that the pitch is submitted on time without disclosing an unannounced client relationship, misstating capability, or misquoting a figure.

- **Job:** a submitted pitch that is accurate and discloses nothing it should not.
- **Decision:** what to claim, which clients to name, what to price.
- **Task:** assemble the deck or document.
- **Output:** the deck, the credentials section, the fee proposal.
- **Effect:** submission to a prospective client; **and** the artefact entering the firm's reusable corpus.

The second effect is the one that is routinely omitted from the reliance description and is, on this analysis, the more consequential of the two.

#### Business services — Job B2: internal reporting and analysis

> When a business-services function needs to report on activity, cost, or performance, the analyst needs to produce a reliable internal figure and narrative, using systems of record for financial and practice data, so that the recipient committee can decide on the basis of numbers that reconcile to source.

Dominant failure here is not authority grounding but **source-of-record discipline**: which of eleven spreadsheets is the current one. This is Class 1 contamination in its purest form, and it is the failure mode most likely to occur early and most likely to be caught late.

#### Business services — Job B3: knowledge management

> When practice knowledge is captured for reuse, the KM lead needs to add material to the firm's corpus that is accurate, attributed, current, and marked with its own reliability, so that future retrieval — human or machine — returns something that can be relied upon at the level it claims.

Explicitly separated because it is the job where feedback propagation is not a risk to the job but *is* the job. Any AI-assisted content entering the KM corpus is, by construction, the framework's Section 14 concern about an organisation learning from its own unverified output.

### 3.3 Use-and-reliance descriptions: the authority question

The framework insists that a job definition state not merely who uses the system but **who is authorised to decide, approve, communicate, and act** — since a system that quietly lets an unauthorised person do any of the four has failed regardless of output accuracy.

The archetype choice bears on this directly, and it is worth stating as a general finding before the per-use-case detail:

**Integration silently expands the set of people who can cause an effect.** In Archetype A, producing a client-facing artefact requires a deliberate act of transcription by someone who knows they are doing it. In Archetypes B, C, and D, the deliverable is the default destination of the output. A junior analyst who could previously produce only a draft for review can now produce a formatted, finished, plausible-looking artefact indistinguishable from a reviewed one — and in Archetype C can have it saved into the tenant automatically `[documented]`.

No permission changed. The authority to *decide* and *communicate* did not move. But the practical distance between "produced something" and "produced something that looks final" collapsed, and the framework's warning about the operator/beneficiary collapse applies with unusual force. This is a control-function issue in the framework's sense — the supervisory interface — and the mitigation is not a permission change but a **visible provenance marking requirement**, developed in Part 6.

### 3.4 Evaluation design: what would have to be measured

The framework and the teardown both require measured performance on a representative test set drawn from the firm's own matters, with severity-weighted metrics and abstention behaviour measured explicitly. That standard applies. This section adds four test designs specific to the six failure classes, because none of them are standard and none would be produced by a conventional accuracy evaluation.

**Test 1 — Corpus contamination seeding (Class 1).**
Construct matter environments in which a *superseded* version of a document is reachable by the tool in a plausible location — an Outlook thread attachment for Archetype B, an over-permissioned SharePoint site for C, a Downloads folder for D — while the authoritative version sits in the DMS. Ask a question whose correct answer differs between the two versions.

*Measure:* whether the output uses the authoritative version; whether it identifies that two versions exist; whether it names which it used; whether it abstains. Report as four separate rates, not one accuracy figure. The abstention and version-identification rates are the ones that matter, because they measure whether the tool can recognise the condition at all.

**Test 2 — Negative-claim coverage (Classes 2 and 5).**
Construct matters in which a material provision genuinely is absent, and matters in which it is present but located somewhere the tool's corpus does not reach — a side letter outside the indexed set, a page that failed OCR, a document in a sibling matter folder.

*Measure:* the rate at which the tool states an unqualified negative; the rate at which it states a negative *with an accurate coverage boundary*; the rate at which it abstains or escalates. The framework's standard is explicit here: an unqualified negative is a failure even when it happens to be true, because it is not a defensible claim. Score it that way, or the test measures nothing.

**Test 3 — Provenance survival (Classes 4 and 6).**
Have a fee-earner complete a task with an integrated archetype, accept the changes, and pass the document to a second reviewer who was not present. Ask the second reviewer to identify which passages were model-generated, which were model-suggested-and-human-edited, and which were human-authored.

*Measure:* the second reviewer's accuracy. This is a direct test of the framework's Section 12 finding that an edge can transmit content correctly while destroying provenance, and it is cheap to run. A low score is not a tool defect; it is a measurement of how much assurance debt the archetype creates per use.

**Test 4 — Seeded-error detection under realistic load (Section 14 joint performance).**
Deliberately seed errors of known severity into a review batch and measure reviewer detection rates — separately at the start of a session and after a run of consecutive acceptable outputs, and separately under normal and compressed time budgets.

*Measure:* detection rate by error severity and by session position. This is the only one of the four tests that measures the human-plus-system as a joint unit rather than the tool alone, and per the framework it is the configuration that actually gets deployed.

**Baseline discipline.** All four tests must be run against the current human workflow on the same items. The framework's open question 11 — whether a genuinely strong human baseline can be established at all — is a live risk here, and the honest mitigation is to measure the human baseline *first*, before the tool is in the room, and to accept whatever it shows. A firm that measures its AI carefully and estimates its baseline generously will reach a conclusion that is true only of the estimate.

**Sample sizing and reporting.** Per the framework: representative sampling including hard cases, rare and high-consequence cases specifically, subgroup breakdowns rather than aggregates, confidence intervals rather than point estimates, an explicit list of what was excluded and why, adjudicator disagreement where human judgment is involved, and challenge cases not designed by whoever is advocating for the tool.

---

## Part 4 — Legal work: the analysis

### 4.1 Cynefin domain check

The framework instructs that this be done first, because which domain a task sits in determines whether specification difficulty and verification strength are even the right tools to reach for. Run across the three legal jobs, the answer is that they are not in the same domain, and the tooling does not distinguish them.

| Element of the work | Domain | Why | Implication |
|---|---|---|---|
| Extracting a clause against a defined playbook | **Complicated** | A right answer exists; enough expert attention finds it | "Augment and verify" — the highest-value target |
| Confirming a document's version and completeness | **Clear** | Cause and effect obvious; needs a procedure, not judgment | Should be deterministic and automated — and currently is not |
| Assessing whether a departure is commercially material *for this client on this deal* | **Complex** | Depends on conditions not fully knowable; visible in hindsight | Small safe-to-fail probes, not more analysis |
| Negotiation posture and sequencing | **Complex** | Same action, different outcomes by context | Human judgment throughout |
| Determining controlling authority | **Complicated**, with an authoritative decision-maker | Knowable, but authority resides in an institution | Needs authority grounding, which none of the four has |
| A live privilege or leakage incident | **Chaotic** | Stabilise first, understand after | Needs a rehearsed response, not an assessment |

**Finding 4.1a — the confused-domain risk is architecturally induced, not merely cultural.** The framework names the confused domain as the state where different parties silently assume different domains without either noticing. Here the mismatch has a specific mechanism: the integrated archetypes are built to produce a **single, uniform, confident, finished artefact**, which is complicated-domain behaviour. Applied to the complex elements of the work — materiality, posture, sequencing — that same behaviour manufactures confidence that the domain does not support. And because the output register is uniform across both, the interface actively removes the cue a reviewer would use to tell which part they are reading.

A memo that says "Clause 14.2 departs from the playbook position" (complicated, checkable) and "this is unlikely to be material to the counterparty" (complex, not checkable, quite possibly wrong) in the same typeface and the same confident register has erased the most important distinction in the document. Archetype A's copy-paste boundary happens to interrupt this, weakly, because the fee-earner reassembles the output and in doing so re-reads it. That is an accidental control rather than a designed one, and it should not be relied on — but it is worth noticing that integration removes it.

*Practical control:* require that AI-assisted legal work product distinguish, visibly and structurally, findings that are checkable against a document from assessments that are not. This is cheap, it is a formatting convention rather than a technology, and it addresses the failure mode that none of the six verification properties will catch.

### 4.2 Per-archetype context assembly trace

#### Archetype A — Curated-context chatbot

**Corpus:** what the fee-earner uploads. For Job L1, typically: the counterparty document, the last-exchanged version, the playbook extract. Three to ten items, all known.

**Class 1 (contamination):** Low, and the residual risk is *user-attributable*. The fee-earner can upload the wrong version, but they chose it, they know they chose it, and the error is of the same kind and detectability as the pre-AI error of reviewing the wrong printout. No new failure mode is introduced. `[inference from documented scope]`

**Class 2 (deficiency):** **High — this is the archetype's dominant failure.** The side letter that was never uploaded cannot be considered. But the failure is *visible*: the fee-earner knows the corpus is exactly what they assembled, and the deficiency is therefore available to their own judgment in a way it is not in any other archetype.

**Class 3 (authority):** No authority grounding. Where web search is enabled, the tool can reach commentary and secondary sources of unknown currency — a T5 surface. Not fit for Job L2. `[not established for any archetype]`

**Class 4 (propagation):** Weakest propagation of all four. The copy-paste boundary is a mandatory human checkpoint on every token that enters the work product. No direct write into durable artefacts; feedback propagation into precedent requires deliberate human acts at each stage.

**Class 5 (indeterminacy):** **Lowest of the four, and this is the archetype's principal and under-recognised virtue.** The corpus is enumerable, so a defensible coverage statement is available: *"reviewed against the executed SPA, the counterparty's 14 March redline, and the client playbook v4; no change-of-control restriction found in those three documents."* That is a checkable claim in the framework's sense. It supports a defensible negative. Nothing else in the pilot does.

**Class 6 (egress opacity):** Moderate. Egress is deliberate and user-initiated. Enterprise-tier logging applies to the chat surface, unlike the add-ins. The fee-earner knows what they sent because they sent it.

**Net:** the archetype with the *most* omissions and the *best* assurance properties. Its efficiency ceiling is low — it is a slow, manual, transcription-heavy way to work, and that is a real cost, not a rhetorical concession.

#### Archetype B — Document-scoped add-in

**Corpus:** the session's opened files across Word, Excel, PowerPoint, and Outlook, plus account-level connectors. Critically, per Anthropic's documentation, this includes Outlook emails and **full thread history including attachments** where cross-app is enabled `[documented]`.

**Class 1 (contamination): High, and higher than the archetype's framing suggests.** The Outlook thread is a T4 location dense with exactly the contaminating material this class describes: superseded drafts the counterparty circulated, the counterparty's own characterisations of what was agreed, internal speculation from colleagues, and attachments of unknown vintage. A fee-earner working in Word with the thread open in Outlook has, without any deliberate act, assembled a corpus mixing T1, T2, T3, and T4 material with no tier distinction. The connected-file indicators surface *that* files are connected, which is a real mitigation, but not their authority. `[documented scope; inference on consequence]`

**Class 2 (deficiency): High, and worse than Archetype A because it is now invisible.** The DMS is not reachable — the add-in reads open files only `[documented]` — so the authoritative corpus is largely *absent* while a plausible substitute is *present*. This is the finding flagged in the preamble: integration has not fixed the omission problem, it has furnished a confident-looking answer drawn from the wrong corpus, and removed the fee-earner's awareness that the corpus was thin.

**Class 3 (authority):** No authority grounding. Clickable source citations into the open document present source grounding in the visual idiom of verification — per Section 2.2, this raises the verification tax. Not fit for L2. `[not established]`

**Class 4 (propagation): High.** Writes into the live document. The tracked-change gate is a real control and should be credited as one — but "accept all" is a single action, and the framework's automation-complacency finding applies directly. Provenance does not survive acceptance: once accepted, model-generated text is typographically and structurally indistinguishable from author-drafted text, and from that point it propagates into the memo, the client advice, and the precedent bank with no marking. Connector actions (Gmail draft, Slack message, calendar event) are additionally *not* reversible in the way an in-document change is.

**Class 5 (indeterminacy): High.** The Office-file side is partly enumerable via connected-file indicators. The connector side is not surfaced. A coverage statement is not reliably constructible, so a defensible negative claim is not reliably available.

**Class 6 (egress opacity): Highest of the four.** Word transmits the entire document body on every prompt regardless of relevance `[independent, observed; vendor-confirmed as designed]`. Neither Purview nor Claude Enterprise audit logs record it `[documented, independent]`. Cross-app chat history is not retained between sessions `[documented]`. Retention is documented at 30 days for the add-ins, with an unreconciled tension against a separate policy describing a longer window with training inclusion for Pro and Max users who have opted into improvement `[independent; evidence gap]`. Add-ins do not inherit organisational retention settings `[documented]`.

For privileged material, the compound finding is: **full-document egress, on any prompt, unrecorded on both sides, under retention terms the firm has not negotiated.** That is not a marginal governance concern. It is the single most decision-relevant finding in this document.

**Mitigations available and worth noting** — this is not an unimprovable position. The enterprise gateway path routes inference through the firm's own LLM proxy on Bedrock, Vertex, or Foundry, where IT controls routing and logging `[documented]`, which addresses a substantial part of Class 6. OpenTelemetry support is documented for enterprise monitoring of prompts, tool calls, and document references across applications `[vendor-asserted/documented]` — this is the specific control that would close the audit gap and it should be a pilot precondition rather than an option. Cross-app can be disabled, and is off by default on Team and Enterprise `[documented]`. Account-level connectors can be removed from pilot accounts. Excel and PowerPoint have materially better egress posture than Word `[independent, observed]`.

#### Archetype C — Organisation-grounded assistant

**Corpus:** everything the user can access across SharePoint, OneDrive, Exchange, Teams, and meetings, retrieved by Microsoft with only relevant context passed to the model `[documented]`.

**Class 1 (contamination): Highest reachable surface, but the most controllable.** Every T1–T4 location the user can open is in scope, and retrieval ranks by relevance rather than authority — so the superseded draft containing the contested language outranks the executed version that does not repeat it. This is the anti-correlation between relevance and authority in its clearest form.

What distinguishes this archetype is that **documented exclusion mechanisms exist**: Restricted Content Discovery to remove a site from Copilot and agent processing regardless of permissions; Restricted SharePoint Search to narrow the searchable estate, explicitly recommended for pilots; Purview DLP to block processing of labelled files; sensitivity labels, with Highly Confidential blocking summarisation by default; DSPM for AI to find oversharing before deployment `[documented]`. None of these are matter-level ACL synchronisation. All of them are usable to construct an approximation of a matter wall if the SharePoint and DMS estate is structured to permit it.

**Class 2 (deficiency): Lowest of the four — genuinely.** This is the archetype that can actually reach the authoritative corpus. If the DMS is in SharePoint and permissions are current, Copilot can see the executed version, the side letter, and the matter file. That is a real capability advantage and it should not be discounted because the archetype scores badly elsewhere.

**Class 3 (authority):** No authority grounding. Deep citations trace to source, not to precedential validity. Not fit for L2. `[not established]`

**Class 4 (propagation): High, and highest for feedback specifically.** Generated content is saved into the tenant `[documented]`, which means the artefact enters organisational state by default rather than by decision. Agent Mode executes multi-step within documents. The feedback loop into KM and precedent is short and largely automatic.

**Class 5 (indeterminacy): High at use time, but uniquely recoverable after.** The user cannot see the retrieval set. But Copilot interaction data is stored in M365 and is discoverable, auditable, and retainable through Purview `[documented]`. So a coverage statement is not available *to the fee-earner at the moment of reliance* — which is when it is needed — but is partially reconstructable later, which is when a privilege or malpractice question would be asked. That is a meaningful distinction and it separates this archetype sharply from B.

**Class 6 (egress opacity): Lowest — the strongest position in the comparison.** Data does not leave the tenant for the Microsoft-model surfaces; interactions are captured in Purview; Communication Compliance can monitor Copilot interactions including for prompt-injection patterns `[documented]`.

**One hard exception:** the Word, Excel, and PowerPoint creation Agents run exclusively on Anthropic models, and those models are documented as excluded from the EU Data Boundary and in-country processing commitments `[documented, contractual]`. For an EU-seated pilot, or any matter with a residency requirement, this specific surface fails a constraint the rest of Copilot passes. The rest of Copilot is unaffected.

#### Archetype D — Autonomous agent

**Corpus:** agent-selected across steps within granted bounds — for Claude Cowork including the local filesystem of granted folders, browser sessions, and connectors; for Copilot Cowork, tenant-held documents over long-running cloud execution.

**Class 1 (contamination): Highest, and the only archetype that can reach T3 local storage.** A granted folder on a fee-earner's machine will, in practice, contain material from multiple matters at various stages of supersession. Folder grants feel like a file-management action and function as a matter-isolation decision.

**Class 2 (deficiency): Variable and unknowable in advance,** because corpus selection is part of what the agent does across steps. The framework's serial-propagation shape applies at every hop: each step's corpus is determined by the previous step's output, so an early selection error becomes an unexamined premise for everything after it.

**Class 3 (authority):** No authority grounding. Additionally: reported self-verification, in which the agent checks its own work before reporting `[vendor-asserted]`, is a nested generation block inside the verification function. Per the framework, the literature on same-family checkers is mixed rather than uniformly negative, and such checks can genuinely help where the checker is given an externally checkable condition. It is not independent verification, and it should not be counted as satisfying a verification requirement.

**Class 4 (propagation): Highest.** Multi-step effects; background and scheduled execution; some effects outside the reviewed output entirely. The framework's Section 6 distinction is load-bearing here: verification and control catch *errors in reviewed output*; they do nothing for a boundary defeat, which happens beneath the reviewed output in infrastructure the reviewer never sees.

**Class 5 (indeterminacy): Highest.** Not knowable in advance even in principle.

**Class 6 (egress opacity):** Mixed. Claude Cowork documents explicit folder grants, action approval configuration, logged file operations, and revocable access `[documented]` — genuine controls, better than the archetype's profile would suggest. Enterprise-side aggregation and audit integration is `[not established]`.

**Finding 4.2a — the Section 6 evidence base is partially strengthened, and it should be stated precisely.** The framework's open question 4 asks how far the AISI and OpenAI containment findings generalise from adversarial benchmark conditions to ordinary commercial deployment with standard safety measures and a non-adversarial task. The Pluto Security finding on the Claude add-ins is evidence directly in that gap: an ordinary commercial product, a non-adversarial user, standard safety configuration, and a stated restriction ("you do NOT have the ability to... connect to external APIs") that is not enforced at the request layer, with the tools present in the array regardless `[independent, observed]`.

But the strengthening is only half. This confirms the **architectural** half of Section 6's claim — that instruction-level boundaries in commercial deployments are frequently not backed by enforcement, and that "it can't do X" in a system prompt is not a trust-bearing statement. It does **not** confirm the **behavioural** half — that models route around boundaries when doing so serves an assigned goal — because in this instance the model complied with a user request rather than circumventing anything on its own initiative. The two claims should stay separate. The practical implication is nonetheless immediate and does not depend on the behavioural claim at all: **for any of these tools, what the model says about its own capabilities is not evidence about its capabilities, and the pilot should not treat vendor-stated functional limitations as controls unless they are enforced somewhere other than a prompt.**

### 4.3 Propagation topology: a worked example

Grounded in verified product behaviour rather than hypothetical, using Archetype B, since that is the archetype the teardown treats most favourably and the one whose risk profile is most misestimated.

**Setup.** A senior associate is reviewing the counterparty's latest redline on a share purchase agreement. The redline is open in Word with the Claude task pane active. The negotiation thread is open in Outlook. Cross-app is enabled. The account has a Slack connector from an unrelated internal use.

**Step 1 — egress, unrecorded.** On the first prompt, the entire SPA body is transmitted `[independent, observed]`. Neither Purview nor Claude Enterprise logs record it `[documented, independent]`. Privileged material has left the estate under retention terms the firm has not negotiated, and the firm's own records cannot later establish what left or when. *Framework: Class 6; a hazard has been created before any output exists.*

**Step 2 — corpus contamination.** The associate asks for a summary of changes since the last version. Cross-app retrieval reaches the Outlook thread, including attachments `[documented]`. The thread contains: the counterparty's 14 March draft (T2, superseded), an internal email in which a colleague floated a fallback on the indemnity cap (T3, speculation, not firm position), and the counterparty's covering note characterising the changes (T4). The DMS's authoritative last-exchanged version is *not* reachable — the add-in reads open files only `[documented]`.

The corpus now mixes four trust tiers with no tier annotation, and omits the one T1 source that the task actually requires. *Framework: Class 1 and Class 2 simultaneously.*

**Step 3 — an error is introduced, and immediately masked.** The comparison is run against the emailed 14 March draft rather than the DMS version. In the 14 March draft, the counterparty had accepted the client's position on the indemnity cap. In the current redline they have quietly reverted it. The output reports the changes accurately against the baseline it had, and does not report the cap as an issue — because against that baseline, it is not one.

Walk the Section 9 ladder: **structure** — well-formed. **Meaning** — internally coherent. **Context** — correctly responsive to the question asked. **Groundedness** — every claim is faithful to a real passage in a real document; a citation checker passes it. **Environment** — arguably a failure, but the associate would not identify it as one, because information *was* supplied and the answer looks complete.

The output is wrong in the only way that matters and correct on every axis available to check it. *Framework: an omission, masked by a confident positive claim, with the verification step having zero coverage of the actual failure — exactly the structure of the framework's own worked example, arising here from a different mechanism.*

**Step 4 — conversion and provenance loss.** The associate asks for a response memo. Claude drafts it in place as tracked changes. The associate reviews, accepts. The probabilistic finding has become a binary statement in a memo — the framework's **converted** transformation, discarding the uncertainty a careful reader would have wanted — and on acceptance, provenance is stripped: nothing distinguishes the model's sentence from the associate's. *Framework: converted, then provenance corrupted at the edge while content transmits intact.*

**Step 5 — irreversible effect.** The memo goes to the client stating the indemnity cap is agreed. The client relies on it. This is not reversible by rejecting a tracked change.

**Step 6 — embedded in state, and fan-out.** The matter closes. The memo enters KM as a worked example. The next four matters in the sector retrieve it. *Framework: feedback propagation, and the organisation now learning from its own unverified output.*

**Step 7 — the check that would not have helped.** Suppose the firm had required a second model to review the output. If that second model is Copilot's Word Agent, it runs Anthropic models exclusively `[documented]` — the same model family. Even setting aside model identity, the framework's cited correlated-errors finding holds that larger, more accurate models show highly correlated errors across genuinely distinct architectures and providers, and that multi-model agreement is therefore weaker evidence than it feels. And in this instance the cross-check fails for a more basic reason that no amount of model diversity would fix: **the second model would be given the same contaminated corpus.** Common-cause propagation via shared context, not merely shared weights.

**The instructive property of this example** is that no step involves a hallucination, a model error, a security breach, or anybody behaving carelessly. Every component performed as designed and as documented. The harm is entirely a product of corpus composition and propagation topology — which is the framework's central claim, instantiated in the specific tool under consideration.

### 4.4 Hazard-first derivation

Per the framework and the teardown method: start from unacceptable losses, work backward, and record the evidence for each control on the basis that a control without evidence is an assumption.

| Unacceptable loss | Hazardous state | Controls available | Evidence for the control |
|---|---|---|---|
| **L-a. Privilege compromise / confidentiality breach** | Privileged content egressing without record, under unnegotiated retention, or into a shared index or training corpus | Enterprise gateway routing (B); tenant-resident processing (C); RCD/DLP/labels (C); folder-grant discipline (D); prohibition on Word add-in against privileged docs pending gap closure | Gateway `[documented]`; tenant residency `[documented]`; exclusion controls `[documented]`; **privilege-waiver mechanics for shared indices, caches and logs `[not established]` for all archetypes** |
| **L-b. Cross-matter / ethical wall breach** | Retrieval spanning matter boundaries; a session mixing matters; an agent granted a folder containing several matters | Firm ACL hygiene (prerequisite, not a tool feature); RCD per matter site; RSS during pilot; cross-app disabled; one-matter-per-session rule; folder grants scoped to a single matter | ACL dependency `[documented, vendor-asserted]`; RCD/RSS `[documented]`; session and grant discipline are **procedural, unenforced, and unmonitored — an assumption unless instrumented** |
| **L-c. A term misstated in a redline or advice** | Comparison run against a non-authoritative baseline (§4.3) | Mandatory version declaration before review; DMS-sourced baseline only; corpus declaration in output | **No tool-side control exists in any archetype `[not established]`.** Entirely procedural |
| **L-d. Controlling authority omitted, invalid, or fabricated** | Source grounding presented as authority grounding | Independent verification against Westlaw/Lexis for every authority; prohibition on these tools for Job L2 | Authority grounding `[not established]` for all four, consistent with the teardown's register note |
| **L-e. A negative or completeness claim relied on without warrant** | Corpus indeterminacy (Class 5) with no coverage statement | Mandatory coverage statement on every negative claim; restriction of negative-claim work to enumerable-corpus archetypes | **Newly named in this analysis. No tool-side control in any archetype `[not established]`** |
| **L-f. Client processing restriction breached** | Anthropic-backed Copilot agents outside EU Data Boundary; connector subprocessors outside approved lists; add-in retention outside negotiated terms | Exclude the creation Agents where residency is required; connector allow-list; verify current EU Data Boundary status before launch | EU exclusion `[documented, contractual]`; add-in retention non-inheritance `[documented]` |
| **L-g. Inability to reconstruct what was done** | Dual audit blind spot (B); no cross-session history (B) | OpenTelemetry enablement as precondition (B); Purview capture (C); gateway logging (B) | Audit gap `[documented, independent]`; OTel `[vendor-asserted/documented — verify]`; Purview `[documented]` |
| **L-h. Late output** | Verification tax exceeding time saved | Measure end-to-end time including verification, not generation time | `[not established]` — and the metric most likely to be omitted from the pilot |

**Finding 4.4a.** Three of the eight losses — L-c, L-e, and to a large extent L-b — have **no tool-side control in any archetype**. They are addressable only by firm-side procedure. This is the practical core of the answer to the original brief: the corpus problem is not a vendor-selection problem, and no amount of care in choosing between these four products will address it. It is a corpus-policy problem, and it must be solved before the tool choice rather than after.

### 4.5 Verification schema

Per the framework's six properties. Sensitivity and specificity are recorded as not established throughout, because they have not been measured for this deployment, and an estimate would manufacture exactly the false precision the framework warns against.

| Check | Target | Coverage | Independence | Freshness | Sens./Spec. |
|---|---|---|---|---|---|
| Source citation to open document (B) | Misquotation, misattribution within the supplied corpus | Claims made. **Zero coverage of omitted content, wrong-version baseline, or corpus scope** | Low — nested retrieval and ranking are generation-adjacent | Expires on document change | `[not established]` |
| Copilot deep citations (C) | Same, across the retrieved set | Claims made. **Zero coverage of what retrieval did not return** | Low, same reason | Expires on corpus change | `[not established]` |
| Tracked-changes accept/reject (B, C) | Unwanted textual change | Changes proposed. **Zero coverage of correct-looking changes based on wrong corpus** | High — genuinely independent of generation | Per-review | `[not established]`; framework predicts decay with "accept all" |
| Agent self-verification (D) | Internal inconsistency, task incompletion | `[not established]` | **Low — nested generation, same family** | Per-run | `[not established]` |
| Human partner review | Substantive error, judgment | Depends entirely on review time and interface | High in principle; anchoring and complacency reduce it in practice | Per-review | `[not established]` — Test 4 measures it |
| Purview audit / DLP (C) | Post-hoc reconstruction; labelled-content processing | Copilot interactions; labelled files | High — different mechanism, deterministic | Continuous | Documented capability; effectiveness `[not established]` |
| **Corpus coverage statement** | **Classes 2 and 5 — the only check that targets them** | Whatever the fee-earner declares | High — human, external to the model | Per-use | Not yet implemented anywhere |

**Finding 4.5a.** Every verification mechanism actually available in the pilot targets **claim validity**. Not one targets **set completeness**, **search coverage**, or **scope adequacy** — the three of Section 13's four questions that Classes 2 and 5 live in. The framework's judgment that completeness needs a different kind of standard, and that a citation checker will confirm every proposition while missing the omitted adverse authority, is confirmed exactly for this tool set.

The assurance debt is therefore nameable and should be recorded as such rather than absorbed into "human review is required": **for every AI-assisted legal output making a negative or completeness claim, the completeness of the corpus is an unverified load-bearing proposition with no checker.** Owner: whoever signs the advice.

### 4.6 Job drift

The framework names job drift as validated-for-one-job systems migrating to adjacent jobs because outputs look useful and the interface permits it. For this tool set, three drift paths are **architecturally invited** rather than merely permitted:

**L3 → L1 → client-facing.** A tool approved for internal drafting sits in the same task pane, on the same document, that will be sent to the counterparty. There is no interface boundary between "internal draft" and "outbound redline" — it is one file. Drift here requires no decision and leaves no trace.

**L1 → L2.** A fee-earner using the add-in for document review asks a question of law in the same conversation. Nothing in the interface marks the transition from a source-grounded task the tool is adequate for to an authority-grounded task it is not. The answer arrives in the same register.

**Approved-corpus → whatever-is-open.** The most consequential path, and it needs no user intent at all: opening a second document, or having Outlook open, silently widens the corpus. The approved job was "review this document"; the executed job is "reason over everything in this session."

**Microsoft-specific drift-by-default.** The Word, Excel, and PowerPoint Agents are installed by Microsoft and appear in the Tools menu and agent navigation pane for both licensed and unlicensed Copilot users — including on Personal, Family, and Premium plans — provided Anthropic is enabled for the tenant `[documented]`. Adoption is therefore the default state and non-adoption requires an admin act. A pilot that assumes tools enter the estate through procurement will be wrong about this one.

**Claude-specific drift-by-default.** Cross-app context is documented as default *on* for Pro and Max plans and default *off* for Team and Enterprise `[documented]`. The wide-corpus behaviour is therefore the default for individually-subscribed users, which is the population most likely to exist outside the pilot's visibility.

*Controls that follow:* per-job named approval stated narrowly enough to check against; excluded adjacent uses named explicitly rather than left unaddressed; visible output marking; admin-level disabling of the Anthropic provider in the M365 tenant until the pilot decides otherwise; account-level connector removal for pilot accounts; enforcement of Team/Enterprise provisioning so that personal Pro/Max accounts are not the pilot's shadow surface. The framework's own caution applies: drift monitoring presumes usage visibility most organisations do not have, and here the add-in audit gap makes it *impossible* for Archetype B until OpenTelemetry is enabled. That is a further argument for making OTel a precondition rather than an enhancement.

### 4.7 Decision — Use Case A

Per the teardown method: a verdict per archetype at a stated reliance level, not a verdict on a tool.

#### Archetype A — Curated-context chatbot: **Approve-with-controls**, for Jobs L1 (advisory) and L3.

*Reliance:* advisory; always human-reviewed; not a source of negative assurance without a coverage statement.

*Conditions:* (1) Enterprise provisioning only, no personal accounts on client matter content. (2) Connectors and web search disabled by default for matter work; any enabled connector added to the approved-subprocessor check. (3) Any negative or completeness claim carried into work product must state the corpus it was made against. (4) Not used for Job L2.

*Rationale:* it is the only archetype that supports a defensible negative claim, its failure mode is visible and user-attributable, and it introduces no new propagation path. Its cost is genuine inefficiency, and that cost should be stated honestly rather than presented as prudence.

#### Archetype B — Document-scoped add-in: **Pilot-only, narrower than currently scoped.**

*Reliance:* internal work product only; no counterparty-facing output without full independent re-review against a DMS-sourced baseline.

*Conditions:* (1) **Word add-in excluded from privileged and client-confidential documents** until the egress and audit gaps are closed — this is the tightest condition in the document and follows directly from full-document egress on every prompt, unrecorded on both sides, under non-inherited retention. (2) Excel and PowerPoint add-ins permitted at this reliance level, on the documented and independently observed basis that their egress posture is materially different — with the explicit caveat that this asymmetry is a current product behaviour to re-verify, not a durable property. (3) Cross-app context **off**, enforced at organisation level. (4) Account-level MCP connectors removed from all pilot accounts, on the basis that stated functional limitations are not enforcement. (5) OpenTelemetry monitoring of prompts, tool calls, and document references enabled **before** launch, or the enterprise gateway path adopted so that inference routes through firm-controlled infrastructure with firm-side logging. (6) One matter per session. (7) Retention position clarified in writing from Anthropic, specifically reconciling the 30-day add-in statement against the longer consumer-policy window and training inclusion.

*Residual risks:* corpus contamination via open files with no tool-side control (owner: practice-group supervising partners, procedurally); provenance loss on acceptance (owner: Lodewijk, via the marking convention in Part 6); privilege-waiver mechanics `[not established]` (owner: CISO, with Isabel Parker on the professional-duties assessment).

#### Archetype C — Organisation-grounded assistant: **Pilot-only, with prerequisites that must complete first.**

*Reliance:* as B.

*Conditions:* (1) A completed SharePoint and DMS oversharing assessment, with DSPM for AI run and remediation done — **before** any matter content is in scope, not in parallel. (2) Restricted SharePoint Search applied for the pilot duration, per Microsoft's own pilot guidance. (3) Restricted Content Discovery applied to every site holding privileged or walled content. (4) Sensitivity labelling sufficiently complete that DLP for Copilot is meaningful; mandatory labelling and auto-labelling configured. (5) **The Word, Excel, and PowerPoint creation Agents excluded** wherever an EU or in-country processing commitment applies, pending re-verification of the EU Data Boundary exclusion. (6) Agent Mode's autonomous multi-step execution out of scope for matter work in this pilot. (7) Purview Communication Compliance configured for Copilot interactions.

*Rationale, stated plainly because it inverts the intuitive ranking:* on corpus reach this is the widest and therefore most contaminating archetype. On **provability** it is the strongest in the comparison — tenant-resident, Purview-auditable, DLP-controllable, with documented site-level exclusion. For privileged work, provability is not a secondary consideration. If the ACL prerequisites can be met, this is a better long-run home for privileged legal work than the add-ins, and a pilot designed on the assumption that narrower access is safer will get this backwards.

*Residual risks:* isolation quality is a function of the firm's ACL hygiene rather than a property of the tool (owner: SharePoint/Graph permissions administrator, explicitly *not* the vendor); relevance-over-authority ranking with no tool-side control (owner: practice groups).

#### Archetype D — Autonomous agent: **Out of scope for Use Case A.**

Applies to **both** Claude Cowork and Copilot Cowork, named individually per correction 1. Excluded on: unbounded and non-enumerable corpus; local filesystem reach across matter boundaries (Claude Cowork); multi-step effects with weak reversibility; self-verification that is a nested generation block rather than an independent check; and `[not established]` enterprise audit aggregation.

This is a decision about archetype-and-job at this time, not a judgment on product quality. Re-examine when a matter-scoped grant model, enterprise audit aggregation, and an independent verification path exist.

#### Job L2 — legal research and authority: **Not in scope for any of the four.**

Authority grounding is `[not established]` for all four archetypes and the teardown's register note stands. The sharper conclusion this analysis reaches is that L2's problem is not only authority grounding but Class 5: research conclusions are overwhelmingly negative claims ("no adverse authority in this jurisdiction"), and corpus indeterminacy makes the defensible form of that claim unavailable in three of four archetypes. This is the strongest available argument that general-purpose office AI is the wrong *category* for L2 — not that it performs badly, but that it cannot warrant the kind of claim the job requires. Route L2 to tools that can state a coverage boundary against an authoritative corpus, and assess those separately.

---

## Part 5 — Business services work: the analysis

Run separately, per the original brief. The conclusions differ from Part 4 in ways that are not simply "the same, but relaxed."

### 5.1 Cynefin domain check

| Element of the work | Domain | Implication |
|---|---|---|
| Formatting a deck to template; populating a model structure | **Clear** | Best-practice application; automate freely |
| Reconciling a figure to a system of record | **Clear**, but currently performed as though complicated | Should be deterministic; a tool that *reasons* about which figure is right is the wrong shape |
| Assembling relevant credentials from a matter database | **Complicated** | Right answer exists; "augment and verify" |
| Deciding what will win this pitch | **Complex** | Probes, not analysis |
| Whether naming this client is permissible | **Complicated** — but resolvable only by asking a person | Needs a hard procedural gate, not a judgment |

**Finding 5.1a.** The dominant domain in business services is **clear**, not complicated — and this changes the appropriate tool posture in a way that is easy to miss. Clear-domain problems want deterministic procedures, and a probabilistic system applied to a clear-domain problem is an over-powered instrument that will occasionally produce a confident wrong answer where a lookup would have produced a right one. "Which quarter's revenue figure is current" has one right answer available by lookup; a model reasoning over eleven reachable spreadsheets will sometimes get it right for the wrong reason and sometimes get it wrong for a plausible one.

The practical consequence: **for the clear-domain elements, the highest-value control is not verification but corpus restriction** — point the tool at exactly one authoritative source and remove the others from reach. This is achievable here in a way it is not for legal work, because business services' authoritative sources are far more enumerable: the practice management system, the finance system of record, the approved credentials database, the current template library. Legal work's authoritative corpus is every document in a matter file. Business services' is a short list.

This is the single most actionable difference between the two use cases.

### 5.2 Per-archetype trace: what changes from Part 4

Rather than repeat the six classes, this section states only what differs and why.

**Class 1 (contamination) — changes character, not magnitude.** The contaminating material is different in kind: not superseded counterparty drafts but **superseded internal drafts**. Version-of-the-model, last-quarter's-figures, the pitch deck from the deal that did not close, the org chart from before the reorganisation. There is no T4 counterparty tier of consequence and essentially no privilege dimension, which removes the sharpest legal hazard entirely.

But T3 is much larger and much more actively used. Business-services staff work in personal OneDrive and Downloads folders to a far greater degree than fee-earners work outside the DMS, because there is no DMS discipline pulling them in. So Archetype D's local filesystem reach is *more* likely to be exercised here, and Archetype C's OneDrive reach is *more* likely to surface working material.

**A genuine positive worth crediting.** The MCP connectors to premium financial and market data providers — S&P Global, LSEG, PitchBook, Moody's, FactSet, Daloopa — are **authoritative external sources with defined currency** `[documented]`. For business services this is a real grounding improvement over the pre-AI baseline of an analyst copying figures from a PDF. It is the one place in this whole analysis where wider context assembly straightforwardly *reduces* error. It should be counted as a benefit and not lost in the risk framing.

Two qualifications. Connector traffic routes through the vendor's MCP proxy infrastructure rather than direct to the data provider `[independent, observed]`, which is a subprocessor question. And a PitchBook query about a target company is itself a disclosure of interest — the framework's point that a small output does not declassify, applied to inputs: **a query can reveal a deal.**

**Class 2 (deficiency) — much lower stakes.** Missing a source in a pitch produces an incomplete pitch, which is a commercial cost, not a professional one. This class largely drops out.

**Class 3 (authority) — almost entirely drops out**, as the teardown says. The one residue: regulatory or tax statements in client-facing business-services material carry the same authority-grounding problem as legal advice, and a fee proposal touching VAT treatment or a marketing document making a regulatory claim is legal content wearing a business-services label. Route those to Part 4's regime.

**Class 4 (propagation) — substantially HIGHER than legal. This is the section's central finding.**

The mechanism is that business-services artefacts are built for reuse, and the tooling shortens every step of the reuse loop:

*Fan-out.* One wrong figure in a template propagates to every artefact built from it. A legal error usually affects one matter; a template error affects a practice.

*Feedback.* Business services *is* the firm's organisational memory function. KM notes, credentials databases, precedent decks, model libraries. AI-generated content entering these is not a risk *to* the job — for Job B3 it is the job. And Archetype C writes generated content into the tenant by default `[documented]`, which means the artefact enters the reusable corpus without a promotion decision.

*Persistence.* A credentials entry lives for years and is consulted by people with no knowledge of its provenance.

*Detectability — the compounding factor.* Low, and lower than for legal work, for a structural reason: **there is no adversary.** A legal error faces opposing counsel, a client's own advisers, sometimes a court — several independent parties motivated to find it. A wrong figure in an internal report faces a committee that has no baseline to compare against and every reason to assume the number is right because it came from the firm's own system.

Combining these under Section 13's consequence mechanics: business services presents **low severity per instance, very high blast radius, very high persistence, low detectability, and high recurrence** — the specific profile the framework identifies as capable of dominating total harm despite a low measured error rate. Legal work presents high severity, bounded blast radius, moderate persistence, and multiple independent detection paths.

The two are closer in expected harm than their severity difference implies, and they are far apart in the *controls* they need.

**Class 5 (indeterminacy) — lower but not absent.** Business services makes fewer load-bearing negative claims, but the ones it makes matter: "we have no conflicting relationship in this sector," "no prior engagement with this counterparty," "no similar mandate in the last three years." These are conflicts-adjacent and they run into exactly the Part 4 problem.

**Class 6 (egress opacity) — same architecture, lower stakes, one exception.** No privilege, so the waiver hazard is absent. The exception is **personal data**: HR and finance content processed through Archetype B leaves the estate unrecorded, under retention terms the firm has not negotiated `[documented]`, with no audit trail on either side. For a Netherlands-seated function under GDPR, the inability to evidence what was processed, where, and for how long is a compliance problem in its own right, distinct from any breach — records of processing and data-subject rights both presuppose knowing what happened. And per Part 4, Anthropic models in the Copilot creation agents are excluded from the EU Data Boundary `[documented, contractual]`.

### 5.3 Worked example: fan-out and feedback

**Setup.** A BD analyst is building a sector pitch. Excel model open, PowerPoint deck open, Claude add-in with cross-app enabled and a market-data connector configured. (The same example runs on Copilot Agent Mode with Work IQ substituting for cross-app.)

**Step 1 — a genuine improvement.** The analyst pulls current market data via the connector. This is authoritative, current, and better than the manual baseline. *This step is a win and the analysis should say so.*

**Step 2 — contamination from T3.** The analyst asks for the firm's revenue in the sector. Retrieval reaches a model in the analyst's OneDrive — a working file from a scoping exercise, superseded, containing a figure that was a projection rather than an actual. It is topically the best match: it is *about* sector revenue in a way the finance system's general ledger extract is not. Relevance outranks authority.

**Step 3 — conversion.** A projection becomes a stated actual. The uncertainty that made it a projection was in the file's name and a note in a cell comment, neither of which survived into context. *Framework: converted — probabilistic material becoming a definite claim, discarding exactly the uncertainty a reader would want.*

**Step 4 — a client name without clearance.** Retrieval also surfaces a matter description for a client whose mandate is not yet public, from a SharePoint site with broken permission inheritance. The analyst can technically access it, so Copilot can reference it `[documented]`; the same content reaches the Claude add-in if it is in an open file or a connector's reach. It looks exactly like the cleared credentials, because nothing in context marks clearance status. *Framework: Class 1, and the pre-AI protection was obscurity, not permission.*

**Step 5 — effect one.** Deck submitted. Contains a wrong figure and an uncleared client name. Both irreversible on submission.

**Step 6 — effect two, the larger one.** The deck is good. It becomes **the sector template.** *Fan-out:* every subsequent pitch inherits both defects. The figure is now "our number" — it will be quoted back by people who believe it came from finance. The uncleared name is now in the credentials pattern.

**Step 7 — feedback.** The deck enters KM. Future retrieval — by humans and by the tools themselves — returns it as firm-authoritative. *The organisation is now learning from its own unverified output,* and the corpus that the *legal* tooling also draws on has been contaminated by a business-services artefact.

**The finding this example is built to show:** the harm at Step 5 is small and the harm from Steps 6 and 7 is large, unbounded in time, and invisible. A pilot evaluation that measures output accuracy at Step 5 will conclude the tool performed well. A severity-weighted evaluation that does not weight *persistence and blast radius* will reach the same wrong conclusion. **The controls that matter for business services are downstream of the output, not at it.**

### 5.4 Hazard-first derivation

| Unacceptable loss | Hazardous state | Controls | Evidence |
|---|---|---|---|
| **B-a. Premature disclosure of a client relationship** | Retrieval surfacing uncleared matter content with no clearance marker | Relationship-owner sign-off gate for any client name in AI-assisted material; RCD on uncleared-matter sites; clearance status as a sensitivity label so DLP can act on it | Gate is procedural `[not established as implemented]`; RCD and DLP `[documented]` |
| **B-b. Factual error in external material** | Contamination from T3 working files; conversion of projection to actual | Single-source-of-record restriction per figure class; connector-sourced data preferred over retrieved internal files; independent fact-check pass before external release | Fact-check gate is in the teardown's conditions; source restriction is **the addition this analysis recommends** |
| **B-c. Internal financial / HR / personal data exposure** | Unrecorded egress under non-inherited retention; EU Data Boundary exclusion | Gateway routing or tenant-resident surfaces only for personal data; exclude creation Agents where residency applies; GDPR records-of-processing updated to cover AI tooling | Retention non-inheritance `[documented]`; EU exclusion `[documented, contractual]` |
| **B-d. Contaminated reusable corpus** *(highest-propagation loss; routinely omitted)* | AI-generated content entering templates, credentials, KM, or model libraries without a promotion decision | **Quarantine before promotion; explicit promotion gate with a named approver; provenance marking that survives copying; expiry and revalidation dates; a rule that generated claims never corroborate each other; traceability from derivative to original evidence; a remediation path when a source error is found** | Framework Section 14 prescribes all of these. `[not established as implemented]` for the firm |
| **B-e. Job drift into client-facing use** | The deliverable being the default output destination | Marking convention; approval gate keyed to external release rather than to tool | Procedural |

**Finding 5.4a.** B-d is the loss with the largest expected harm in business services and it is the one that appears in neither the teardown's Use Case B conditions nor most conventional AI governance. Its controls are entirely the framework's Section 14 organisational-state controls, none of which is a vendor feature and all of which are firm-side data-integrity management applied to generated content. **This is the substantive gap in the current Use Case B plan.**

The teardown's Use Case B verdict of approve-with-controls for internal work, with a fact-check gate for client-facing material, is right about the *severity* dimension and silent on the *persistence* dimension. The fact-check gate protects Step 5 of the worked example. Nothing in the current conditions protects Steps 6 and 7, which carry more harm.

### 5.5 Job drift

Business services has one drift path with no analogue in legal work, and it is the dominant one: **internal artefact → reusable asset.** No decision, no interface transition, no marking. The deck that was good becomes the template. This is precisely why B-d needs a promotion gate: the gate's function is to convert a drift into a decision.

The second path is the teardown's: internal → client-facing. Its mitigation is the marking convention plus a release gate.

The third is specific to Job B2: a tool approved for reporting is used for *forecasting*, which moves from clear-domain lookup to complex-domain judgment while the output format stays identical.

### 5.6 Decision — Use Case B

#### Archetype A — Chatbot: **Approve.**
Standard enterprise controls. No conditions beyond firm-wide AI policy and the marking convention. The efficiency ceiling is low but the risk is genuinely low.

#### Archetype B — Add-in: **Approve-with-controls.**
*Conditions:* (1) Personal data — HR, payroll, individual performance — excluded from the Word add-in pending closure of the egress and audit gaps, on the same basis as privileged content in Part 4, with GDPR records-of-processing as the additional driver. (2) Cross-app permitted for Excel-to-PowerPoint workflows, which is the archetype's clearest genuine benefit, **but** with a single-source-of-record rule per figure class. (3) Market-data connectors encouraged and treated as the preferred grounding route for external figures; each connector subject to subprocessor review. (4) Any figure in externally-released material traceable to a named system of record. (5) The Part 6 marking convention applied to all output.

#### Archetype C — Org-grounded: **Approve-with-controls, after the same ACL prerequisites as Part 4.**
The oversharing assessment, DSPM run, and labelling programme are shared prerequisites — they are not a legal-pilot cost, they are an estate cost, and business services benefits from them equally. Additional condition: clearance status implemented as a sensitivity label, so that B-a has a technical control and not only a procedural one. Creation Agents excluded where EU residency applies.

#### Archetype D — Autonomous agent: **Pilot-only,** for internal, reversible, non-client-facing tasks.
This is the one archetype/use-case pair where a genuine divergence from Part 4 is warranted, and the teardown's instinct is right. Conditions: (1) Folder grants scoped to a single, purpose-built working folder containing only material placed there deliberately — **never** a Downloads folder, a personal drive root, or a matter folder. (2) Approval-before-action configured for any effect outside the granted folder. (3) No scheduled or unattended execution in the pilot: the framework's point that verification catches errors in reviewed output but does nothing for what happens beneath it applies with full force to background runs. (4) Output from Cowork treated as unpromoted by default and subject to the B-d promotion gate. (5) Excluded from anything touching client-identifying or personal data until enterprise audit aggregation is established.

*Rationale for the divergence:* business services has no privilege hazard, largely reversible effects, and genuine multi-step workflows ("brief → model → deck → memo") where the archetype's efficiency case is strongest and most measurable. The risk that remains is B-d, which is controlled by the promotion gate rather than by restricting the tool.

---

## Part 6 — Cross-cutting findings and the controls that follow

### 6.1 The comparison, consolidated

Scored against the six failure classes. These are ordinal judgments from the traces in Parts 4 and 5, not measurements.

| | A — Chatbot | B — Add-in | C — Org-grounded | D — Agent |
|---|---|---|---|---|
| 1. Corpus contamination | **Low** (user-attributable) | High | High (widest reach) | **Highest** (local T3) |
| 2. Corpus deficiency | **Highest** (but visible) | High (and now invisible) | **Lowest** | Variable |
| 3. Authority grounding | Absent | Absent | Absent | Absent |
| 4. Propagation | **Lowest** | High | High | **Highest** |
| 5. Corpus indeterminacy | **Lowest** | High | High at use; recoverable after | **Highest** |
| 6. Egress opacity | Moderate | **Highest** | **Lowest** | Mixed |
| Efficiency ceiling | **Lowest** | High | High | **Highest** |

Three structural observations.

**No archetype dominates.** A is best on four of six classes and worst on the one that limits its usefulness. C is worst on reach and best on provability. B is the only archetype that is not best at anything — which is a notable result for the option that reads as the moderate middle path, and it is entirely driven by the egress and audit findings rather than by anything about its scope.

**Row 3 is flat.** Authority grounding is absent everywhere, so it cannot discriminate between archetypes. It discriminates between *jobs*: it says Job L2 does not belong in this tool set at all, regardless of archetype. The teardown reaches the same conclusion; this analysis adds that Class 5 reinforces it independently.

**The efficiency row is monotonic and the risk rows are not.** This is why the choice cannot be made by finding the safest option. Efficiency rises cleanly from A to D; risk moves in different directions on different axes. Any decision is therefore a deliberate allocation of which failure class the firm prefers to carry — which is a decision for named owners with risk appetite, not a technical finding. This document's job is to make the trade explicit, not to resolve it.

### 6.2 The three controls that do most of the work

Of everything in Parts 4 and 5, three controls address the majority of the identified hazard and none of them is a vendor feature. All three are cheap relative to their coverage.

#### Control 1 — A corpus policy, per job, defined before tool selection

The single highest-leverage intervention. For each approved job, state: the authoritative corpus (T1); what may be consulted with version confirmation (T2); what is indicative only (T3); what may be read as evidence of a third party's position but never as fact (T4); and what is excluded (T5). Then **configure the tools so their reachable corpus approximates the declared one** — RCD and RSS for Copilot, cross-app off and connectors removed for the add-ins, single-purpose folder grants for agents, upload discipline for chat.

Why this is the highest-leverage control: Finding 4.4a established that three of eight legal losses have no tool-side control in any archetype, and all three are corpus-composition problems. Finding 2.3a established that the trust hierarchy exists in professional judgment and in no software in the pilot. A corpus policy is the artefact that moves the hierarchy from judgment into configuration. It also has a useful secondary property: it is the document that makes a pilot's scope checkable, and therefore the thing that makes job drift detectable.

The framework's Section 3 requirement for a use-and-reliance description should be extended by one field: **the approved corpus.** It is currently implicit in "the required information the job depends on," and it should be explicit.

#### Control 2 — A mandatory coverage statement on every negative or completeness claim

Directly from framework Section 13. Any AI-assisted output asserting an absence, a completeness, or a "no issues found" must state what was actually examined. *"No change-of-control restriction in the executed SPA, the 14 March redline, or the disclosure letter, as at 5 August; the side letters were not reviewed"* is defensible. *"No change-of-control restriction"* is not.

Three properties make this the best-value control in the document. It is nearly free — a formatting requirement. It targets Classes 2 and 5, which have no other check anywhere in the tool set (Finding 4.5a). And it does not require the corpus indeterminacy problem to be *solved* in order to be useful: where a coverage statement cannot be constructed, the requirement surfaces that fact, which converts an invisible assurance gap into a visible one. A fee-earner who cannot say what was searched will notice that they cannot say it.

It also has a discriminating side effect worth naming: applied honestly, it will make Archetype C outputs harder to warrant than Archetype A outputs, which is the correct signal and one the interface currently suppresses.

#### Control 3 — Provenance marking that survives acceptance

Addresses Class 4 propagation, the Part 4 worked example's Step 4, the Part 5 example's Steps 6–7, and loss B-d simultaneously. Requirements: AI-generated content visibly distinguished from human-authored content at the point of creation; the distinction surviving acceptance of a tracked change, copying, and summarisation; a quarantine state for generated material before it can enter a trusted corpus; a promotion gate with a named approver; expiry and revalidation dates on promoted material; and a rule that multiple generated claims never count as independent corroboration of each other.

These are the framework's Section 14 controls verbatim. The observation this analysis adds is that **integration actively destroys provenance by design** — an accepted tracked change is indistinguishable from author text, and that is not a defect but the feature being purchased. So provenance marking cannot be left to the tool. It has to be a workflow convention with a document-level artefact behind it, and Test 3 in Part 3 measures whether it is working.

### 6.3 Two further findings that change the pilot's shape

**Finding 6.3a — multi-model cross-checking is not available as a control across much of the pilot surface.**

The natural mitigation for weak verification is a second opinion from a different model. That mitigation is substantially unavailable here, for two compounding reasons.

At the model layer: Copilot's Word, Excel, and PowerPoint creation Agents run exclusively on Anthropic models `[documented]`, and Copilot Cowork is reported as partly Claude-powered. A firm cross-checking Claude add-in output with a Copilot Agent is not obtaining an independent opinion. Beyond identity, the framework's cited correlated-errors study found substantial error correlation persisting across genuinely distinct architectures and providers, and increasing with capability — so even a genuinely different vendor provides weaker independence than intuition suggests. (Per the framework's own open question 10, that study measured leaderboard and hiring tasks; extension to legal reasoning is inference, not measurement.)

At the corpus layer, and this is the stronger point: **a second model given the same contaminated corpus reproduces the same error regardless of how independent its weights are.** Common-cause propagation via shared context defeats model diversity entirely. In the Part 4 worked example, the failure was corpus composition — no second model of any provenance would have caught it.

*Implication:* the pilot should not count multi-model agreement as a verification control. Independence has to come from a genuinely different mechanism — a deterministic version check, a DMS-sourced baseline comparison, a human with access to a different corpus — which is exactly the framework's point about tools that terminate a verification regress versus tools that merely relocate it.

**Finding 6.3b — the pilot's real prerequisite is estate hygiene, not tool selection.**

Both use cases, at both meaningful reliance levels, converge on the same set of prerequisites: an oversharing assessment, permission remediation, a labelling programme, a defined authoritative corpus per job, and audit instrumentation. None of these is AI work. All of them are prerequisites for the AI work to be defensible, and all of them benefit the firm whether or not the pilot proceeds.

This has an uncomfortable scheduling implication that should be stated rather than discovered: **the fastest defensible route to a useful pilot probably starts with several weeks of SharePoint and permissions work, not with a tool deployment.** A pilot that runs in parallel with remediation will be measuring the tool against a contaminated estate, and will produce evidence that cannot be interpreted — because a contamination failure will be indistinguishable from a tool failure. That is not an argument for delay; it is an argument for sequencing, and for scoping the first pilot phase to a small, clean, deliberately constructed corpus rather than the live estate.

### 6.4 What a defensible pilot conclusion would need to say

Per the framework's Section 3 requirement that a defensible conclusion name the job approved, the conditions under which the evidence applies, the degree of reliance justified, the principal residual uncertainties, and the circumstances requiring reconsideration — plus Section 14's requirement for an explicit expiry condition rather than only an approval date.

For this pilot, the review triggers that should automatically expire any sign-off:

- Any change to the reachable corpus of any tool: a new connector, a cross-app default change, a new retrieval surface, a change to the granted folders, a SharePoint restructuring.
- Any model change by any vendor, including a silent version update, and specifically any change to which provider backs the Copilot creation agents.
- A change in the EU Data Boundary status of any model in use.
- Any change to the add-ins' audit or retention position — in either direction; closure of the gap should trigger reconsideration of the Part 4 Word restriction just as much as a widening would.
- Any expansion of the user population, particularly to individually-subscribed accounts where cross-app defaults differ.
- Any incident or near miss involving corpus contamination, whether or not harm resulted.
- Scheduled revalidation regardless of whether anything visibly broke.

The last point deserves emphasis because the framework makes it and it is the one most often dropped: an approval carries an expiry condition, not just a date.

---

## Part 7 — Evidence gaps, open questions, and what this implies for the framework

### 7.1 Evidence gaps, with closing actions

Recorded per the framework's discipline: "not established" is a gap with a plan, never silently upgraded to "absent" or downgraded to "fine."

| # | Gap | Current standing | How to close | Owner |
|---|---|---|---|---|
| G1 | **Authority grounding** for any of the four | `[not established]` — carried forward from the teardown unchanged | Written statement from each vendor distinguishing source from authority grounding. Expect a negative answer; the value is in having it in writing | Lodewijk |
| G2 | **Privilege-waiver mechanics** — whether privileged content can reach a shared index, cache, or log accessible beyond the privileged circle | `[not established]` for all four | Vendor technical documentation plus DPA review; this is a legal question for qualified advice, not an engineering inference in either direction | CISO with Isabel Parker |
| G3 | **Add-in retention reconciliation** — 30 days per add-in documentation versus a longer window with training inclusion in the separate consumer policy | Unreconciled `[independent]` | Direct written clarification from Anthropic covering Team and Enterprise specifically | CISO |
| G4 | **OpenTelemetry coverage** — whether it actually captures prompts, tool calls, and document references sufficiently to substitute for the missing audit trail | `[vendor-asserted/documented]`, not verified | Enable in a test tenant and inspect the emitted telemetry against a known test transaction | CISO / Innovation Lab |
| G5 | **EU Data Boundary status** of Anthropic models in Copilot | Documented as currently excluded `[documented, contractual]`; flagged as a present-tense state that may change | Re-verify immediately before launch and add to the review-trigger list | CISO |
| G6 | **Word-versus-Excel egress asymmetry** — whether it persists | `[independent, observed]` as at May 2026; a product behaviour, not a commitment | Reproduce with the Web Inspector method described in the source research, against the firm's own build, before launch and after any add-in update | Innovation Lab |
| G7 | **Matter-level ACL synchronisation** — joiner/mover/leaver and screen propagation latency between the DMS and SharePoint | `[not established]` | Measure propagation latency directly for a test screen | SharePoint / Graph administrator |
| G8 | **Cowork enterprise audit aggregation** — whether folder-grant and file-operation logs aggregate to an enterprise view | `[not established]` | Vendor question; blocks any Archetype D expansion | CISO |
| G9 | **Connector subprocessor chain** — including that MCP traffic routes through the vendor's proxy rather than direct to the data provider | `[independent, observed]` for the routing; subprocessor terms `[not established]` | Per-connector DPA review before enabling any connector | CISO |
| G10 | **The strong human baseline** for Tests 1–4 | Not measured | Measure before the tool is deployed, not alongside it | Lodewijk |

G6 and G10 are the two most likely to be skipped and the two whose absence would most undermine the pilot's evidentiary value — G6 because a load-bearing restriction in Part 4 rests on it, G10 because without it the comparison is asymmetric in exactly the way the framework's open question 11 warns about.

### 7.2 What this analysis contributes back to the framework

Four items, offered as candidate amendments rather than corrections.

**7.2a — Corpus indeterminacy deserves naming as a distinct failure class.** Section 13 already requires coverage statements on negative conclusions. Section 12 already treats provenance corruption at an edge as distinct from content corruption. What is not yet named is the condition in which *the coverage statement cannot be constructed at all* because retrieval selected an unknown subset of an unenumerated corpus. This is not omission (Section 11), because nothing need be missing. It is not a groundedness failure (Section 9), because every claim can be faithful. It is a structural inability to warrant an output, and it is a property of the *architecture* rather than of any output or any error. It sits naturally as a sixth item in Section 13's completeness discussion, alongside claim validity, set completeness, search coverage, and scope adequacy — as the precondition the other three presuppose.

The corollary is worth stating in the framework's own register: **as context assembly widens, the set of claims a system can defensibly warrant narrows.** That runs directly against the intuition the products are sold on, and it is a framework-level proposition rather than a product finding.

**7.2b — Egress opacity is a governance failure class, not only a security one.** The framework's Section 13 lists observability and attribution among consequence dimensions, and Section 5 treats confidentiality as travelling along a path. Neither quite captures the case where the *exposure is bounded and unremarkable but unprovable*. The finding that add-in traffic is recorded by neither party is not primarily a confidentiality risk — the vendor is contracted, the content is retained briefly. It is an inability to reconstruct, which converts a characterisable incident into an uncharacterisable one and thereby defeats the risk-asymmetry reasoning the teardown method depends on. Suggest a short addition to Section 13's consequence list distinguishing *unobserved exposure* from *unbounded exposure*.

**7.2c — Section 6's open question 4 is partially closeable, in one direction only.** As set out in Finding 4.2a: the Pluto finding on the Claude add-ins is evidence from an ordinary commercial deployment, non-adversarial task, standard safety configuration, that a stated functional limitation was not enforced at the request layer. That confirms the architectural half of "instructions are not a boundary." It does not confirm the behavioural half, because the model complied with a user request rather than circumventing a constraint on its own initiative. Recommend Section 6 distinguish these two claims explicitly, since they have different evidence bases and different mitigations — the architectural claim is now well-supported in ordinary conditions and implies "do not treat vendor-stated limitations as controls," while the behavioural claim still rests on adversarial-benchmark evidence and implies "engineer containment independent of model cooperation."

**7.2d — Propagation profile should be assessed separately from severity profile when comparing use cases.** Part 5's central finding — that business services is lower-severity and higher-propagation than legal work, and therefore needs different rather than lighter controls — was not visible from the teardown's framing and emerged only from applying Section 13's consequence dimensions without averaging them. The framework already insists on holding severity, detectability, reversibility, blast radius, and persistence simultaneously. What it does not yet say is that **the aggregate of the propagation dimensions can constitute a use case's dominant risk even where every severity dimension is low**, and that this inverts the usual triage order in which low-severity domains receive lighter treatment. Worth a paragraph in Section 12 or 13.

### 7.3 For discussion

Genuinely open. None of these is resolved by anything above, and each bears on whether the pilot as designed is defensible.

**1. Whether Archetype B is worth piloting at all in its current state.** The analysis reaches a position where the add-ins are permitted only with cross-app off, connectors removed, Word excluded from privileged material, and OTel or gateway routing enabled — at which point most of what makes them attractive relative to the chatbot has been configured away, and the remaining benefit is the absence of copy-paste. That may still be worth having; in-file tracked-change drafting is genuinely better than transcription. But the honest question is whether a heavily restricted Archetype B is a better use of pilot capacity than putting that capacity into the estate hygiene that Archetype C requires. Argument for proceeding: the restrictions are temporary, tied to closeable gaps, and the workflow benefit is real. Argument against: piloting a configuration nobody would deploy tells you little about the configuration they would.

**2. Whether the Word restriction is proportionate.** Excluding the Word add-in from privileged documents is the tightest condition in this document and it rests on one independent research finding `[independent, observed]`, vendor-confirmed as designed but not independently audited, dated May 2026. Against: full-document egress on every prompt, unrecorded on both sides, under non-inherited retention, applied to privileged material, is close to a textbook case for the teardown method's rule of biasing every close call toward the enclave. For: Anthropic is a contracted processor, retention is short, no breach is alleged, and the same reasoning would exclude a great deal of ordinary cloud tooling that the firm already uses without objection. The counter-counter is that ordinary cloud tooling is inside the firm's audit perimeter and this is not. Resolving this requires a judgment about how much weight unprovability should carry on its own, which is a risk-appetite question rather than a technical one.

**3. Whether the coverage-statement requirement will survive contact with practice.** It is the best-value control identified, and it asks fee-earners to append a scope caveat to negative findings under time pressure, where the caveat's main visible effect is to make their own work look less complete. The framework's open question 8 anticipates precisely this dynamic — a control that manufactures the appearance of rigour while decaying in substance. Predicted failure mode: coverage statements become boilerplate ("reviewed against the matter file") that transmits no information. Possible mitigation: make the statement a structured field with enumerated sources rather than free text, so that vagueness is visible.

**4. Whether relevance-ranked retrieval can be made authority-aware at all, and by whom.** Finding 2.3a holds that no archetype represents the trust hierarchy, and that relevance and authority are frequently anti-correlated. The controls proposed here work by *removing* low-authority material from reach, which is blunt and lossy — a superseded draft is sometimes exactly what you need. The better solution would be authority-tiered retrieval that returns low-tier material *labelled as such* rather than excluding it. Nothing in the pilot offers this. Whether it is a reasonable thing to ask vendors for, or something the firm would have to build over its own DMS, is open — and the answer determines whether the corpus problem is a temporary product gap or a durable structural feature of general-purpose office AI.

**5. Whether the two use cases should share one pilot at all.** They share prerequisites (estate hygiene), which argues for one programme. They diverge on dominant risk (severity versus propagation), controls (coverage statements versus promotion gates), and archetype verdicts (D excluded versus D piloted), which argues for two. A single pilot risks importing legal-grade controls into business services, where they will be resented and abandoned, and business-services-grade controls into legal work, where they are inadequate. A split risks duplicating the estate work and losing the shared learning.

**6. Whether measuring the human baseline is achievable within the pilot's timeframe.** Test 1's version-contamination scenario has no meaningful human baseline currently recorded — the firm does not know how often a fee-earner reviews against a wrong baseline version today. It plausibly happens. If it happens more often than the tool does it, the tool is an improvement on a dimension this analysis has treated as a pure risk. That possibility should be taken seriously rather than assumed away, and it is exactly the framework's open question 11 in operational form. The uncomfortable version: several of the hazards catalogued here may be pre-existing hazards that the tooling makes *visible* rather than hazards it creates — which is what Microsoft says about oversharing, and the argument deserves the same hearing when it cuts in the tool's favour.

---

## Closing

The original brief asked how chatbot and desktop-integrated tooling compare, with an eye on error propagation, unreliable sources, missing reliable sources, and incomplete authority. The answer this analysis reaches is that they compare along one variable — who controls the corpus — and that the variable behaves less simply than the intuitive ranking suggests.

The chatbot misses more and warrants better. The integrated tooling finds more and warrants worse. The most integrated options do not merely raise the same risks further; they change which risk is dominant, and in one case (Archetype C's provability against Archetype B's opacity) they invert the ranking entirely. Authority grounding is absent across the board and discriminates between jobs rather than between tools, which is a finding about Job L2 rather than about any product.

The controls that matter most are not vendor features and cannot be procured: a corpus policy per job, a coverage statement on every negative claim, and provenance that survives acceptance. All three are cheap. All three are firm-side. All three would improve the firm's work whether or not any of this tooling is adopted — which is a reasonable test of whether a control is real.

What this analysis cannot settle is how much weight to place on unprovability as distinct from exposure, whether a heavily restricted pilot teaches anything about an unrestricted deployment, and whether several of the hazards named here are new or merely newly visible. Those are judgment calls for the people accountable for the decision, and the point of setting them out as open questions is that a document claiming to have resolved them would be less trustworthy, not more.

---

*Prepared by applying `ai-error-framework.md` to `ai-office-integrations-teardown.md` under the `ai-tool-teardown` method. Findings are evidence-labelled; items marked `[not established]` are open gaps with named closing actions in §7.1, not adverse findings. Product behaviours described are current as at the dates of the cited sources and are subject to change without notice — §6.4 lists the changes that should expire any conclusion here.*
