# Reference: add-typescript-javascript-sdk (proposal)

## Stage
proposal

## How This ADR Was Used
Created here — this ADR was established as part of drafting the
`add-typescript-javascript-sdk` proposal to capture the technology stack decisions
required before any TypeScript implementation work begins.

## Decision Made
Fastify + Vitest + cucumber-js + pnpm + better-sqlite3 + jose were selected as the
TypeScript/JavaScript stack. The JavaScript SDK will re-export the compiled TypeScript SDK
output rather than maintaining a separate source tree.

## Impact
These choices constrain all TypeScript and JavaScript implementation work in
`lang/typescript/` and `lang/javascript/`. Future proposals adding TypeScript providers or
SDK features must use this stack without deviation unless a new ADR supersedes this one.
