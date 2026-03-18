import * as path from 'path';
import * as fs from 'fs';
import { projectRoot } from '../root';

function findTestFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules') {
      results.push(...findTestFiles(full));
    } else if (entry.isFile() && (entry.name.endsWith('.test.ts') || entry.name.toLowerCase().endsWith('steps.ts'))) {
      results.push(full);
    }
  }
  return results;
}

export function testNoSkippedTests(ratchet = 0): void {
  const root = projectRoot();
  const testsDir = path.join(root, 'tests');
  const srcDir = path.join(root, 'src');
  const files = [...findTestFiles(testsDir), ...findTestFiles(srcDir)];

  const violations: string[] = [];
  const skipPatterns = [/\bxit\s*\(/, /\bxdescribe\s*\(/, /\btest\.skip\s*\(/, /\bit\.skip\s*\(/];

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const lines = content.split('\n');
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      for (const pattern of skipPatterns) {
        if (pattern.test(line)) {
          violations.push(`${path.relative(root, file)}:${i + 1}: skipped test`);
        }
      }
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`Skipped test violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('No Skipped Tests', () => {
  it('no xit/xdescribe/test.skip/it.skip in test files', () => {
    testNoSkippedTests(0);
  });
});
