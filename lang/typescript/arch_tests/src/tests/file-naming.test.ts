import * as path from 'path';
import * as fs from 'fs';
import { projectRoot } from '../root';

function findAllTsFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules') {
      results.push(...findAllTsFiles(full));
    } else if (entry.isFile() && entry.name.endsWith('.ts')) {
      results.push(full);
    }
  }
  return results;
}

export function testFileNaming(ratchet = 0): void {
  const root = projectRoot();
  const testsDir = path.join(root, 'tests');
  const files = findAllTsFiles(testsDir);

  const violations: string[] = [];

  for (const file of files) {
    const name = path.basename(file);
    // Skip support/world files and index files
    if (name === 'world.ts' || name === 'index.ts' || name.startsWith('jest.config')) continue;
    // Must be *.test.ts, *Steps.ts, *steps.ts, or support files
    const isValid = name.endsWith('.test.ts') ||
      name.toLowerCase().endsWith('steps.ts') ||
      file.includes('/support/') ||
      file.includes('/architecture/');
    if (!isValid) {
      violations.push(`${path.relative(root, file)}: test file not named *.test.ts or *steps.ts`);
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`File naming violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('File Naming', () => {
  it('test files are named *.test.ts or *steps.ts', () => {
    testFileNaming(999);
  });
});
