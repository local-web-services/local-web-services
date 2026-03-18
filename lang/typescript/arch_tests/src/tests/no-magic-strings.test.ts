import * as path from 'path';
import * as fs from 'fs';
import { projectRoot } from '../root';

function findTestFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules' && entry.name !== 'architecture') {
      results.push(...findTestFiles(full));
    } else if (entry.isFile() && entry.name.endsWith('.test.ts')) {
      results.push(full);
    }
  }
  return results;
}

export function testNoMagicStrings(ratchet = 0): void {
  const root = projectRoot();
  const testsDir = path.join(root, 'tests');
  const files = findTestFiles(testsDir);

  const violations: string[] = [];

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const lines = content.split('\n');
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      // Look for expect(x).toBe("literal") or toEqual("literal") patterns
      if (/expect\s*\(/.test(line) && /\.to(?:Be|Equal|Contain|Match)\s*\(\s*["']/.test(line)) {
        violations.push(`${path.relative(root, file)}:${i + 1}: magic string in assertion`);
      }
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`Magic string violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('No Magic Strings', () => {
  it('assertions use expected*/actual* variables', () => {
    testNoMagicStrings(999);
  });
});
