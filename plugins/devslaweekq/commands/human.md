---
description:
    Rewrite a draft, or write a reply, as a short human comment for a colleague (PR thread, chat) following the human-comments rules
argument-hint: [draft text or situation]
---

Apply the `human-comments` skill to the following and return only the final text, ready to paste. No draft, no critique, no list of what you
changed, no intro or closing line. Reply in the language of the input.

If the input is a draft, rewrite it. If it describes a situation (for example "reply to the comment about the empty data, we fixed it"),
write the comment. If the input is missing, take the last text you wrote for a person in this conversation and rewrite that.

Do not invent facts, file names or commit hashes that are not in the input or the conversation. If something needed is unknown, leave it out
instead of guessing.

$ARGUMENTS
