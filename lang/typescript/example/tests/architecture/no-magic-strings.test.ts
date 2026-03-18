import { testNoMagicStrings } from "lws-arch-tests";

describe("No Magic Strings", () => {
  it("assertions use expected*/actual* variables", () => {
    testNoMagicStrings(999);
  });
});
