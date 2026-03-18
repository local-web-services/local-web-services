import { testFileNaming } from "lws-arch-tests";

describe("File Naming", () => {
  it("test files are named *.test.ts or *steps.ts", () => {
    testFileNaming(999);
  });
});
