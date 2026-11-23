## ADDED Requirements

### Requirement: JavaScript SDK Re-Export
The `local-web-services-javascript-sdk` package SHALL re-export all public symbols from the
TypeScript SDK as a dual CJS + ESM build with no TypeScript type declarations in the published
package.

#### Scenario: CJS require works without TypeScript
- **WHEN** `const { LwsSession } = require('local-web-services-javascript-sdk')` is used in a plain Node.js script
- **THEN** `LwsSession` is a constructor that can start and stop local providers

#### Scenario: ESM import works
- **WHEN** `import { LwsSession } from 'local-web-services-javascript-sdk'` is used in an ESM module
- **THEN** `LwsSession` is imported correctly and functions identically to the TypeScript SDK

### Requirement: JavaScript SDK No Type Declarations
The published JavaScript SDK package SHALL NOT include `.d.ts` declaration files, keeping it a
pure JavaScript package.

#### Scenario: Package contains no .d.ts files
- **WHEN** the `local-web-services-javascript-sdk` package is inspected after `pnpm pack`
- **THEN** no files with the `.d.ts` extension are present in the tarball
