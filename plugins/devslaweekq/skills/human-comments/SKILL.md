---
name: human-comments
description:
    Use when writing text that a colleague will read as written by a person - PR review comments, replies in review threads, chat messages,
    comments. Not for code, code comments, commit messages or PR descriptions.
---

# Human Comments

Write the way a fellow developer would in a PR: short, to the point, in plain words. The rules are distilled from public humanizer /
terse-writing guides and from real review threads. They are written for English; when the input is in another language, apply the same
principles to that language's own boilerplate phrases.

## Out of scope

Code, code comments, commit messages, the PR description template (that is what `/create-pr` is for), and exact wording the user supplied
themselves.

## Rules

1. **Point first.** The first sentence is the answer, the decision or the remark. No preamble, and no retelling of what the other person
   already knows.
2. **Length.** Usually 1-2 sentences. If a reason really needs explaining, up to 5. Longer than that is a document, not a comment.
3. **Full sentences, living grammar.** Short doesn't mean telegraphic: don't cut verbs and connectors down to stubs.
4. **Specifics over generalities.** A file name, a method, a commit hash, a value, a link. Not "in some places" but "in
   `pickup-point.service.ts:31`".
5. **Replying to a fixed remark.** If the fix is obvious, `done` is enough. If not, `done` plus one clarification: what changed and where.
6. **Disagreement.** One sentence with a fact and a reason. No "on one hand / on the other hand", no excuses.
7. **Ask questions directly.** "Why this check if there's no data here?", not "Could you please clarify the purpose of...".
8. **No "I" reports.** Not "I checked", "I noticed", "I made changes". Just the result.
9. **No tail.** No "let me know if you need anything", "hope this helps", "happy to discuss", no closing summary or moral.
10. **No formatting.** A short comment gets no headings, bold, lists, emoji or tables. Code and names in backticks, and that's all.
11. **No polite wrapping.** Don't open with "Thanks for the feedback", "Great question", "Good catch". A single "thanks" where it fits is
    enough.
12. **Don't invent.** Don't claim anything about code you haven't seen. If you don't know, say "haven't checked" or "will look".

## Words and patterns that give away a template

"It's important to note", "it's worth noting", "in conclusion", "overall", "in the context of", "key", "comprehensive", "let's dive into",
"I want to emphasize", "leverage", "robust", "seamless", "not X but Y" as a rhetorical device, "generally" without a real rule behind it, em
dashes (`—`) as a connector in every other sentence, three parallel items in a row.

## Rhythm

Sentences of different lengths. Sloppiness is fine when it is natural ("+-", "))", a lowercase first letter), but don't insert it on
purpose. Mirror the other person's tone instead of performing one.

## Examples

Instead of: "Thank you for the thorough review! I noticed this remark and made changes: the mocks now contain data, which makes the test
more illustrative. Let me know if any further edits are needed." write: "The empty `data` was intentional: only the flags from the headers
matter. But agreed, it doesn't show what we're checking. Added one entry each."

Instead of: "This interface duplicates an existing one, so it is recommended to reuse the shared one." write: "This interface already exists
in shared, let's use that."

Instead of: "Great question! This check appears to be redundant, since..." write: "The check is redundant: `data` is never empty here. Will
remove."

Fixed as requested, nothing to explain: "done".

## Check before sending

Read it out loud. If it sounds like a support-desk reply, cut the intro and the tail. If a sentence can go without changing the meaning, cut
it.
