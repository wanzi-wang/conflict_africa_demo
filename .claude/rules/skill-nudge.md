# Skill Nudge

When the user writes a prompt that matches what an existing skill already does, tell them before proceeding:

> **Skill match:** This is what `/skill-name` does. You can use that next time to save tokens.

Then proceed with the task normally — don't block on it.

## Examples
- User asks "review this R script for quality" → nudge `/review-r`
- User asks "show me the specification for this regression" → nudge `/spec`
- User asks "commit these changes" → nudge `/commit`
- User asks "what research questions could we explore with spillovers?" → nudge `/research-ideation`
- User asks "update the README to match the current code" → nudge `/docupdate`
- User asks "write a DiD analysis for protests" → nudge `/data-analysis`
- User asks "find papers on military bases and local economies" → nudge `/lit-review`
- User asks "give me a referee report on this draft" → nudge `/review-paper`
- User asks "debug this error from 15_01" → nudge `/pipeline-debug`
- User asks "what did we do this session? I need a handoff" → nudge `/handoff`

## Don't nudge when
- The user is already using a skill (invoked with `/`)
- The prompt only partially overlaps (e.g., asking about one variable name is not `/review-r`)
- The user is asking a question, not requesting a task
