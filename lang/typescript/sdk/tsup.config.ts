import { defineConfig } from "tsup";

export default defineConfig({
  entry: ["src/index.ts"],
  format: ["cjs"],
  target: "es2020",
  dts: true,
  clean: true,
  sourcemap: true,
  // Treat all AWS SDK packages and other peer deps as external.
  // session.ts dynamically requires optional SDK clients that may not be installed.
  external: [/^@aws-sdk\//, /^@smithy\//, "ws", "local-web-services-typescript-core"],
});
