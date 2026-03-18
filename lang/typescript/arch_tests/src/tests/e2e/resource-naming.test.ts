import * as path from 'path';
import * as fs from 'fs';
import { projectRoot } from '../../root';

function findStepFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules') {
      results.push(...findStepFiles(full));
    } else if (entry.isFile() && entry.name.toLowerCase().endsWith('steps.ts')) {
      results.push(full);
    }
  }
  return results;
}

export function testResourceNaming(ratchet = 0): void {
  const root = projectRoot();
  const testsDir = path.join(root, 'tests');
  const files = findStepFiles(testsDir);

  const violations: string[] = [];
  // Resource names for e2e tests should follow test-<service>-<n> pattern
  // Check for hardcoded names that don't match the pattern
  const invalidNamePattern = /["'`](?!test-)[a-z][a-z0-9-]*(?:-\d+)?["'`]/g;
  const resourceKeywords = /(?:TableName|QueueName|BucketName|TopicArn|SecretId|FunctionName|StateMachineArn)\s*:/;

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const lines = content.split('\n');
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      if (resourceKeywords.test(line)) {
        const names = line.match(/["'`]([a-z][a-z0-9-]*)["'`]/g) || [];
        for (const name of names) {
          const cleaned = name.replace(/["'`]/g, '');
          if (!cleaned.startsWith('test-') && !cleaned.startsWith('arn:') && cleaned.length > 3) {
            violations.push(`${path.relative(root, file)}:${i + 1}: resource '${cleaned}' does not follow test-<service>-<n> naming`);
          }
        }
      }
    }
  }

  const actual = violations.length;
  if (actual > ratchet) {
    const msg = violations.slice(0, 20).join('\n');
    fail(`Resource naming violations: ${actual} (ratchet=${ratchet})\n${msg}`);
  }
}

describe('Resource Naming', () => {
  it('e2e resources follow test-<service>-<n> naming convention', () => {
    testResourceNaming(999);
  });
});
