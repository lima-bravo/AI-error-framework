# Executive Summary

## AI tools for legal and business services work: where we have got to, what concerns us, and where this is going

---

### The thinking behind this work

We started from an observation about how AI projects actually fail.

When something goes wrong with an AI tool, the instinct is to blame the model — it invented something, it wasn't clever enough, the technology isn't ready. In our experience that diagnosis is usually wrong, and because it is wrong, the remedy that follows it doesn't work. The failures we can actually trace almost always belong to the *arrangement around* the model rather than to the model itself: what information it was handed, who checked its answer, what happened to that answer afterwards, and whether anyone would have noticed if it were wrong. Two products running the identical underlying AI can be very differently safe. So the thing worth evaluating is the whole way of working, not the AI.

We have also been deliberate about the standard we are holding these tools to, because getting that wrong makes every later judgement unreliable. The bar is not perfection. Nothing meets that, including our own current processes, and demanding it would block useful work without making anyone safer. The bar is whether the complete arrangement — people, tools, checks, fallbacks — does the work better than a well-resourced, competent person using the best conventional method available. That is a genuinely demanding test, because it requires us to be honest about what our own people actually achieve, which is harder and less comfortable than measuring the software.

Three further ideas have shaped what follows.

**A correct answer can still cause harm.** It can go to the wrong person, be relied on more heavily than the evidence supports, be used past the point where it was still true, or be produced too late to change the decision it was meant to inform. None of this shows up in a check designed to catch wrong answers.

**Mistakes travel, and they change on the way.** An error that would be trivial where it started can become serious once it has been copied into a template, entered a precedent file, or been quoted back as though it came from a system of record. This is the part most reviews miss entirely, because they examine the output and stop there.

**A check only catches what it was built to look for.** This sounds obvious and is routinely forgotten. A tool that verifies every citation in a document can be excellent at that and completely blind to the one authority that should have been cited and wasn't. "Verified" is not a single property, and the word does a lot of quiet damage.

---

### The question that turned out to matter

We expected the interesting differences between these tools to be about capability — which one drafts better, which one is more accurate. They largely aren't. The underlying AI models are converging, and in at least one case two products we assumed were competitors turn out to be running the same model underneath.

The difference that matters is far more mundane and much more consequential:

**Who decides what the AI reads?**

With a chatbot, you do. You choose each document, paste or upload it, and know exactly what is in the pile. With AI built into Word, Excel and PowerPoint, or into the wider Microsoft environment, the tool decides — reaching into whatever is open, whatever is in the email thread, whatever sits in SharePoint or on the hard drive, and selecting what looks relevant.

Everything else follows from that one shift. It is the whole efficiency case: not having to assemble the pile by hand is precisely what makes these tools fast and pleasant. And it is the whole risk case. You cannot buy one without the other, and it is worth being clear-eyed that the useful feature and the thing that worries us are the same feature, rather than treating the second as a flaw that will be fixed later.

---

### What changes when the AI moves into the document

Four things change, and they do not all move in the same direction. That is the part that makes this genuinely difficult rather than merely cautious.

**It reads more, so it misses less.** A chatbot only knows what you gave it. If you forgot the side letter, the side letter does not exist. The integrated tools can reach the whole matter file, which is a real and material improvement. This should not be discounted just because the rest of this note is careful.

**It reads more, so it reads the wrong things.** The material it reaches is not all equally trustworthy, and nothing in these tools distinguishes between a signed agreement, last month's superseded draft, a colleague's speculative email, a counterparty's self-serving characterisation, and something someone left in a Downloads folder. They rank material by how relevant it looks, not by how much it should be trusted — and those two things frequently pull in opposite directions. A superseded draft containing exactly the disputed wording will often look *more* relevant than the executed version that doesn't repeat it.

**The failure becomes invisible.** This is the shift we find most concerning. When a chatbot misses something, you know why: you know what you uploaded. When an integrated tool misses something, or reads the wrong version, it still produces a confident, well-structured, professional-looking answer, and there is nothing in it to suggest anything went wrong. We have moved a visible failure to an invisible one, which is not obviously an improvement even though the tool is doing more.

**Wide reach makes it harder, not easier, to stand behind an answer.** This one is counter-intuitive and it is the central finding. A great deal of our most important work consists of saying that something *isn't* there — no adverse authority, no change-of-control restriction, no conflicting relationship. Saying that responsibly means being able to say what you looked at. With a hand-assembled pile you can: you name the four documents. With retrieval across an entire estate, neither the tool nor the user can reconstruct what was actually searched — so the honest version of the statement cannot be made, although nothing stops the confident version being made anyway. As the tool reaches wider, the set of things you can properly warrant gets *narrower*.

Two smaller observations that cut against expectations, and which we mention without unpacking here.

The tool that looks most conservative — a panel beside your open document, reading only that document — has the weakest record of what it actually did. Under some configurations, having the panel open sends the whole document out, on any question, and neither our Microsoft compliance tooling nor the AI vendor's own audit logs record that it happened. The most expansive option, by contrast, keeps everything inside our own environment where it can be logged, restricted and inspected. Narrower access and better accountability are not the same thing, and they do not come from the same products.

And the obvious safeguard — ask a second AI to check the first — does much less than it appears to. Partly because two of the products we were comparing turn out to share the same model. Mostly because a second opinion drawn from the same wrong pile of documents will confidently reach the same wrong conclusion. Independence has to come from somewhere other than a second AI.

---

### What worries us

Stated plainly, in the order we would rank them.

**We cannot say what these tools read.** Everything else is downstream of this. It undermines our ability to stand behind negative findings, which is a large part of what clients pay us for.

**We cannot always say what left the building.** For some tools, client material leaves our environment and neither we nor the vendor holds a record that it did. This is not primarily a confidentiality worry — the vendors are contracted and the exposure is bounded. It is that if a question arises in eighteen months about what was sent where, our honest answer is that we cannot reconstruct it. An exposure we can characterise is manageable. One we cannot characterise is not.

**Where documents sit still means something, and no tool knows it.** Our people already distinguish the executed version in the document management system from a draft on someone's desktop. That judgement exists in their heads and in no piece of software we looked at.

**Good work quietly becomes reference material.** A deck that worked becomes the template. A figure becomes "our number" and gets quoted back by people who assume it came from finance. A memo enters the knowledge base and shapes how similar matters are handled for years. The tools make every step of that loop shorter and remove the moment at which someone consciously decided the material was good enough to reuse. This is why our business-services work, which looks lower risk because individual mistakes are less serious, may in aggregate carry more risk than our legal work, where mistakes are serious but land on one matter and face several people motivated to find them.

**Nothing checks for what is absent.** Every safeguard on offer checks the claims that were made. Not one checks whether the right claims were made in the first place.

**We do not yet know our own baseline.** We do not know how often, today, without any AI, a fee-earner reviews against the wrong version of a document. It certainly happens. If it happens more often than these tools do it, then something we have treated throughout as a risk is in fact an improvement. We think that possibility deserves serious testing rather than a comfortable assumption, and we would rather find out than not.

---

### The controls we want, and what actually exists

| What we want | Where it stands |
|---|---|
| Restrict each tool to an approved set of sources for each kind of work | **Partly available.** Microsoft's environment offers real mechanisms to exclude sites and sensitive documents. Blunt — it removes material rather than labelling it — but usable, and better than we had assumed |
| A record of what was sent, and when | **Available for some tools, absent for others.** One product family records nothing on either side; monitoring can be switched on, or traffic routed through our own infrastructure, but this has to be done deliberately and before launch |
| Any "we found nothing" statement to say what was searched | **Missing everywhere.** No tool can produce it. We can require it of our people, which is cheap and would help, but it is our discipline rather than a product feature |
| Something that flags what was *not* examined | **Missing everywhere.** We have found no tool that attempts this |
| AI-drafted text stays identifiable after it is accepted | **Missing by design.** Making the output indistinguishable from your own writing is the feature being sold. This has to be our convention, not the tool's |
| A conscious decision before anything becomes reusable reference material | **Entirely ours to build.** No tool offers it, and it is the control we think is most obviously absent from current plans |
| Confirmation that cited law is current and correctly applied | **Absent from every product we assessed.** Citations point at documents, not at whether the law still stands. For genuine legal research, we do not think these are the right category of tool |
| Sources returned with an indication of how much to trust them | **Does not exist anywhere.** The thing we most want, and nobody offers it |

The pattern is clear enough. The controls that exist are the ones vendors can build into a product. The ones missing are the ones that require someone to have decided what the firm considers authoritative — which no vendor can do for us, and which we have not yet done for ourselves.

That leads to a conclusion we did not expect and do not entirely welcome: **the real prerequisite for this pilot is not choosing a tool. It is several weeks of unglamorous work on document permissions, source labelling, and deciding what counts as authoritative for each kind of task.** Running the pilot before that work is done would produce results we cannot interpret, because a tool failing and a messy document estate look identical from the outside. This is an argument about sequence, not about delay — and the work is worth doing whether or not we adopt any of this software, which is a fair test of whether a control is real.

---

### Where this is heading

Four directions, in rough order of how soon they matter.

**From "is it accurate?" to "can we say what it looked at?"** Accuracy is measurable and mostly reassuring. It is also the wrong question for work whose value lies in completeness. We expect our evaluation to shift towards testing whether a tool knows the edges of what it examined, and whether it declines when it should — including deliberately hiding a superseded version somewhere the tool can find it, and seeing what happens.

**From excluding untrustworthy sources to labelling them.** Our current controls work by putting material out of reach, which is lossy — sometimes the superseded draft is exactly what you need. What we actually want is retrieval that returns lower-grade material clearly marked as such. Nothing offers this. Whether it is a reasonable thing to ask vendors for, or something we would have to build over our own systems, is an open question, and the answer determines whether this is a temporary gap in immature products or a durable limitation of general-purpose office AI.

**Towards measuring ourselves as carefully as we measure the software.** If we scrutinise the AI rigorously and estimate our own performance generously, we will reach a favourable conclusion that means nothing. Establishing an honest baseline before deployment is the least interesting and most important part of the pilot.

**Towards a sharper question about which tools belong where.** For some work — legal research in particular — the issue is not that these tools perform badly. It is that they cannot warrant the kind of statement the work requires. That points towards purpose-built tools for a narrow set of tasks and general office AI for everything else, rather than one tool doing all of it. We think that division will become clearer as we test, and it is the strategic question underneath the operational one.

---

**In one line:** these tools are genuinely useful and the efficiency case is real, but the thing that makes them fast is the same thing that makes them hard to stand behind — and the controls that would close that gap are mostly ours to build rather than theirs to sell.
