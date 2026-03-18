import path from "path";
import type { Config } from "jest";

process.env.LWS_ARCH_PROJECT_ROOT = path.resolve(__dirname, "../..");

const config: Config = {
  preset: "ts-jest",
  testEnvironment: "node",
  testMatch: ["**/tests/architecture/**/*.test.ts"],
  transform: {
    "^.+\\.tsx?$": ["ts-jest", { tsconfig: "tsconfig.jest.json" }],
  },
};

export default config;
