export function projectRoot(): string {
  const root = process.env.LWS_ARCH_PROJECT_ROOT;
  if (!root) throw new Error('LWS_ARCH_PROJECT_ROOT is not set.');
  return root;
}
