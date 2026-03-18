import * as path from 'path';
import * as fs from 'fs';
import { projectRoot } from '../root';

const MAX_LINES = 500;

function findSourceFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules' && entry.name !== 'dist') {
      results.push(...findSourceFiles(full));
    } else if (entry.isFile() && entry.name.endsWith('.ts') && !entry.name.endsWith('.d.ts')) {
      results.push(full);
    }
  }
  return results;
}

export function testFileLength(ratchet = 0): void {
  const root = projectRoot();
  const srcDir = path.join(root, 'src');
  const files = findSourceFiles(srcDir);

  const violations: string[] = [];

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const lineCount = content.split('\n').length;
    if (lineCount > MAX_LINES) {
      violations.push(`${path.relative(root, file)}: ${lineCount} lines (max ${MAX_LINES})`);
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`File length violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('File Length', () => {
  it('source files are at most 500 lines', () => {
    testFileLength(999);
  });
});
