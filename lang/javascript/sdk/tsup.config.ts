import { defineConfig } from "tsup";
import { fileURLToPath } from "url";
import { dirname, resolve } from "path";

const __dirname = dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  entry: ["src/index.ts"],
  format: ["cjs", "esm"],
  dts: false,
  clean: true,
  outDir: "dist",
  // Keep runtime deps external; they go in package.json dependencies
  external: ["fastify", "@fastify/formbody"],
  // Bundle workspace packages from their TypeScript source
  noExternal: [/^local-web-services-/],
  esbuildOptions(options) {
    options.alias = {
      ...options.alias,
      "local-web-services-typescript-sdk": resolve(
        __dirname,
        "../../typescript/sdk/src/index.ts",
      ),
      "local-web-services-typescript-core": resolve(
        __dirname,
        "../../typescript/core/src/index.ts",
      ),
    };
  },
});
