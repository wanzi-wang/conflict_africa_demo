# Plan-First Workflow

## When to plan
For any task that involves:
- Writing a new script (not just editing an existing one)
- Changing the pipeline structure or data flow
- Adding a new empirical analysis or identification strategy
- Modifying multiple files

## How to plan
1. State the goal in one sentence
2. List the files that will be read, created, or modified
3. Describe the approach (what the code will do, step by step)
4. Flag risks: what could break downstream? What assumptions are we making?
5. Wait for user approval before writing code

## When NOT to plan
- Bug fixes to a single file (use `/pipeline-debug` or `/fixcheck`)
- Documentation updates (use `/docupdate`)
- Small edits the user has already fully specified
- Reading/exploring data or code

## Token savings
Planning prevents wasted iterations. A 30-second plan review costs far less than rewriting a script that went in the wrong direction.
