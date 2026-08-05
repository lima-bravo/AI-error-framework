# Executive Summary

## AI tools for legal and business services work: where we have got to, what concerns us, and where this is going

---

### The thinking behind this work

We began with a question about how AI projects fail.

When an AI tool gets something wrong, the instinct is to blame the model. It made something up. It wasn't clever enough. The technology isn't ready. That diagnosis is usually wrong. And because it is wrong, the fix that follows it does not work.

The failures we can actually trace belong to the arrangement around the model, not to the model itself. Four things determine whether a tool is safe: what information it was given, who checked the answer, what happened to that answer afterwards, and whether anyone would have noticed a mistake. Two products can run the identical AI and be very differently safe. So the thing to evaluate is the way of working, not the AI.

We have also been careful about the standard we hold these tools to. The bar is not perfection. Nothing meets that standard, including our current processes. Demanding it would block useful work without making anyone safer.

The right bar is comparison. Does the whole arrangement — people, tools, checks, fallbacks — do the work better than a competent, well-resourced person using the best conventional method? That test is demanding, for an uncomfortable reason. It requires us to know what our own people actually achieve. Measuring ourselves is harder than measuring the software.

Three further ideas shaped everything that follows.

**A correct answer can still cause harm.** It might go to the wrong person. It might be trusted more heavily than the evidence supports. It might arrive after the decision it was meant to inform. None of that shows up in a check built to catch wrong answers.

**Mistakes travel, and they grow on the way.** An error can be trivial where it starts. It becomes serious once someone copies it into a template. It becomes more serious again when it enters a precedent file, or gets quoted back as though it came from a system of record. Most reviews miss this entirely, because they examine the output and stop there.

**A check only catches what it was built to find.** This sounds obvious and is routinely forgotten. A tool can verify every citation in a document perfectly. The same tool will be blind to the one authority that should have been cited and never was. "Verified" is not a single property, and the word does quiet damage.

---

### The question that turned out to matter

We expected the differences between these tools to be about capability. Which one drafts better. Which one is more accurate. They mostly are not. The underlying models are converging. Two products we assumed were competitors turn out to share the same model.

The difference that matters is far more mundane:

**Who decides what the AI reads?**

With a chatbot, you do. You choose each document and upload it. You know exactly what is in the pile.

With AI built into Word, Excel and PowerPoint, the tool decides. It reaches into whatever is open, whatever sits in the email thread, whatever lives in SharePoint or on the hard drive. Then it picks what looks relevant.

Everything else follows from that one shift. It is the whole efficiency case. Not assembling the pile by hand is exactly what makes these tools fast. It is also the whole risk case. The two are the same feature. We cannot buy one and decline the other, and it would be a mistake to treat the risk as a flaw someone will fix later.

---

### What changes when the AI moves into the document

Four things change. They do not all move in the same direction. That is what makes this difficult rather than simply risky.

**It reads more, so it misses less.** A chatbot only knows what you gave it. Forget the side letter and the side letter does not exist. The integrated tools can reach the whole matter file. That is a genuine improvement, and we should not discount it because the rest of this note is cautious.

**It reads more, so it reads the wrong things.** Not everything within reach deserves equal trust. These tools cannot tell a signed agreement from last month's superseded draft, a colleague's speculative email, or something left in a Downloads folder. They rank material by how relevant it looks. Relevance and trustworthiness often point in opposite directions. A superseded draft containing the disputed wording will usually look more relevant than the executed version that does not repeat it.

**The failure becomes invisible.** This is the change that concerns us most. When a chatbot misses something, you know why. You know what you uploaded. When an integrated tool misses something, or reads the wrong version, it still produces a confident, well-structured answer. Nothing in that answer suggests a problem. We have turned a visible failure into an invisible one. That is not obviously progress, even though the tool is doing more work.

**Wide reach makes it harder to stand behind an answer.** This is counter-intuitive, and it is the central finding. Much of our most valuable work consists of saying that something is *not* there. No adverse authority. No change-of-control restriction. No conflicting relationship. Saying that responsibly means being able to say what you examined. With a hand-assembled pile you can. You name the four documents. With retrieval across the whole estate, nobody can — not the tool, and not the user. The honest version of the statement becomes unavailable. The confident version remains perfectly available. As the tool reaches wider, the range of things you can properly warrant gets narrower.

Two further observations cut against expectation. We note them here without unpacking the detail.

**The most conservative-looking option keeps the worst record.** A panel beside your open document sounds tightly scoped. In some configurations, simply having it open sends the entire document out, whatever you asked about. Neither our Microsoft compliance tooling nor the vendor's own audit logs record that this happened. The most expansive option does the opposite. It keeps everything inside our environment, where it can be logged, restricted and inspected. Narrow access and good accountability are different properties. They do not come from the same products.

**The obvious safeguard does less than it appears to.** Asking a second AI to check the first feels like a second opinion. Two of the products we compared share the same model, so in that case it is not one. The deeper problem survives even with genuinely different models. A second opinion drawn from the same wrong pile of documents reaches the same wrong conclusion. Independence has to come from somewhere other than another AI.

---

### What worries us

In the order we would rank them.

**We cannot say what these tools read.** Everything else follows from this. It undermines our ability to stand behind a negative finding. Negative findings are much of what clients pay us for.

**We cannot always say what left the building.** With some tools, client material leaves our environment and no record exists on either side. The confidentiality risk itself is bounded, because the vendors are under contract. The real problem is different. Suppose a question arises in eighteen months about what was sent where. Our honest answer would be that we cannot reconstruct it. An exposure we can describe is manageable. One we cannot describe is not.

**Where a document sits still means something, and no tool knows it.** Our people already distinguish the executed version in the document management system from a draft on someone's desktop. That judgement lives in their heads. It lives in none of the software we looked at.

**Good work quietly becomes reference material.** A deck that worked becomes the template. A figure becomes "our number", then gets quoted back by people who assume it came from finance. A memo enters the knowledge base and shapes similar matters for years. These tools shorten every step of that loop. They also remove the moment when someone consciously decided the material was good enough to reuse. This is why our business services work may carry more risk in aggregate than our legal work, even though each individual mistake is less serious. Legal mistakes are severe. But they land on one matter, and they face several people motivated to find them.

**Nothing checks for what is absent.** Every safeguard on offer checks the claims that were made. None checks whether the right claims were made.

**We do not know our own baseline.** We do not know how often a fee-earner today, with no AI involved, reviews against the wrong version of a document. It certainly happens. If it happens more often than these tools do it, then something we have treated throughout as a risk is in fact an improvement. That deserves testing rather than assumption. We would rather find out.

---

### The controls we want, and what exists today

| What we want | Where it stands |
|---|---|
| Restrict each tool to an approved set of sources, per kind of work | **Partly there.** Microsoft's environment offers real ways to exclude sites and sensitive files. It is blunt — it removes material rather than grading it — but it works, and it is more than we expected |
| A record of what was sent, and when | **There for some tools, absent for others.** One product family records nothing on either side. Monitoring can be switched on, or traffic routed through our own infrastructure. Both must be done deliberately, before launch |
| Every "we found nothing" statement to say what was searched | **Missing everywhere.** No tool can produce it. We can require it of our people, which is cheap and would help. That is our discipline, not a product feature |
| Something that flags what was *not* examined | **Missing everywhere.** We found no tool that attempts it |
| AI-drafted text to stay identifiable once accepted | **Missing by design.** Making the output indistinguishable from your own writing is the feature being sold. This has to be our convention |
| A conscious decision before anything becomes reference material | **Entirely ours to build.** No tool offers it. It is the control most obviously absent from current plans |
| Confirmation that cited law is current and correctly applied | **Absent from every product we assessed.** Citations point at documents, not at whether the law still stands. For real legal research, these are not the right category of tool |
| Sources returned with a mark of how far to trust them | **Does not exist anywhere.** The thing we want most, and nobody sells it |

The pattern is clear enough. The controls that exist are the ones a vendor can build into a product. The ones missing all require somebody to have decided what this firm treats as authoritative. No vendor can decide that for us. We have not yet decided it for ourselves.

That leads somewhere we did not expect and do not especially welcome. The prerequisite for this pilot is not choosing a tool. It is several weeks of unglamorous work on document permissions, source labelling, and defining what counts as authoritative for each task. Run the pilot before that work is done and the results will not be interpretable. A tool performing badly and a messy document estate look identical from the outside. This is an argument about sequence, not about delay. The work is worth doing whether or not we adopt any of this software, which is a fair test of whether a control is real.

---

### Where this is heading

**From "is it accurate?" to "can we say what it looked at?"** Accuracy is measurable and mostly reassuring. It is also the wrong question for work whose value lies in being complete. Our testing will shift towards whether a tool knows the edge of what it examined, and whether it declines when it should. One test we plan is simple: hide a superseded version somewhere the tool can find it, then see what happens.

**From excluding weak sources to labelling them.** Today's controls work by putting material out of reach. That is lossy, because sometimes the superseded draft is exactly what you need. What we actually want is retrieval that returns weaker material clearly marked as weaker. Nothing offers this. Whether it is reasonable to ask vendors for it, or something we would have to build over our own systems, is still open. The answer tells us whether this is a temporary gap in immature products or a lasting limit of general-purpose office AI.

**Towards measuring ourselves as carefully as we measure the software.** Scrutinise the AI rigorously, estimate our own performance generously, and we will reach a favourable conclusion that means nothing. Establishing an honest baseline before deployment is the least interesting and most important part of the pilot.

**Towards a sharper view of which tools belong where.** For legal research in particular, the problem is not that these tools perform badly. It is that they cannot warrant the kind of statement the work requires. That points towards purpose-built tools for a narrow set of tasks, and general office AI for everything else. We expect that division to sharpen as we test. It is the strategic question sitting underneath the operational one.

---

**In one line:** these tools are genuinely useful, and the thing that makes them fast is the same thing that makes them hard to stand behind. Most of the controls that would close that gap are ours to build, not theirs to sell.
