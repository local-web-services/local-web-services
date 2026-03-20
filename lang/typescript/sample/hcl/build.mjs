import * as esbuild from 'esbuild';

const functions = ['create-order', 'get-order', 'process-order', 'generate-receipt'];

for (const fn of functions) {
  await esbuild.build({
    entryPoints: [`lambda/${fn}/index.ts`],
    bundle: true,
    platform: 'node',
    target: 'node20',
    outdir: `lambda/dist/${fn}`,
    external: [],
  });
}
