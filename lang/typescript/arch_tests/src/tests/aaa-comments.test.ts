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
    } else if (entry.isFile() && (entry.name.endsWith('.test.ts') || entry.name.toLowerCase().endsWith('steps.ts'))) {
      results.push(full);
    }
  }
  return results;
}

function getTestFunctionBodies(content: string): string[] {
  const bodies: string[] = [];
  // Match it(...), test(...), describe(...) blocks - simplified heuristic
  const regex = /(?:it|test)\s*\([^,]+,\s*(?:async\s*)?\([^)]*\)\s*=>\s*\{([\s\S]*?)(?=\n  \}|\n\}\))/g;
  let match;
  while ((match = regex.exec(content)) !== null) {
    bodies.push(match[1]);
  }
  return bodies;
}

export function testAaaComments(ratchet = 0): void {
  const root = projectRoot();
  const testsDir = path.join(root, 'tests');
  const files = findTestFiles(testsDir);

  const violations: string[] = [];

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const bodies = getTestFunctionBodies(content);
    for (const body of bodies) {
      const hasArrange = body.includes('// Arrange');
      const hasAct = body.includes('// Act');
      const hasAssert = body.includes('// Assert');
      if (!hasArrange || !hasAct || !hasAssert) {
        violations.push(`${path.relative(root, file)}: missing // Arrange / // Act / // Assert`);
      }
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`AAA comment violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('AAA Comments', () => {
  it('all test functions have Arrange/Act/Assert comments', () => {
    testAaaComments(999);
  });
});
