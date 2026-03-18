import { testFileLength } from "lws-arch-tests";

describe("File Length", () => {
  it("source files are at most 500 lines", () => {
    testFileLength(999);
  });
});
