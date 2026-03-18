import { testNoSkippedTests } from "lws-arch-tests";

describe("No Skipped Tests", () => {
  it("no xit/xdescribe/test.skip/it.skip in test files", () => {
    testNoSkippedTests(0);
  });
});
