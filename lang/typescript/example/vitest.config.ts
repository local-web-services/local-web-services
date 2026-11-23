import { defineConfig } from "vitest/config";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  resolve: {
    alias: {
      "local-web-services-typescript-sdk": path.resolve(
        __dirname,
        "../sdk/src/index.ts",
      ),
      "local-web-services-typescript-core": path.resolve(
        __dirname,
        "../core/src/index.ts",
      ),
    },
  },
  test: {
    globals: false,
    environment: "node",
    testTimeout: 15_000,
    include: ["tests/**/*.ts"],
    exclude: ["**/node_modules/**", "**/dist/**"],
  },
});
