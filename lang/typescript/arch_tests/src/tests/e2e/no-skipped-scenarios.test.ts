import * as path from 'path';
import * as fs from 'fs';
import { projectRoot } from '../../root';

function findFeatureFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules') {
      results.push(...findFeatureFiles(full));
    } else if (entry.isFile() && entry.name.endsWith('.feature')) {
      results.push(full);
    }
  }
  return results;
}

export function testNoSkippedScenarios(ratchet = 0): void {
  const root = projectRoot();
  // Feature files live in the shared spec directory
  const specDir = path.join(root, '..', '..', '..', 'specification', 'core', 'informal');
  const files = findFeatureFiles(specDir);

  const violations: string[] = [];
  const skipPatterns = [/@skip\b/, /@wip\b/];

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const lines = content.split('\n');
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      for (const pattern of skipPatterns) {
        if (pattern.test(line)) {
          violations.push(`${path.relative(root, file)}:${i + 1}: skipped scenario`);
        }
      }
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`Skipped scenario violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('No Skipped Scenarios', () => {
  it('no @skip or @wip tags in feature files', () => {
    testNoSkippedScenarios(0);
  });
});
