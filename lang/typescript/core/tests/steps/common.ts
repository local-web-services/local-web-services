/** Common step definitions shared across all services. */

import { Then } from "@cucumber/cucumber";
import assert from "assert";
import type { LwsWorld } from "../support/world";

Then("the command will succeed", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got failure: ${JSON.stringify(this.lastResult.output)}`
  );
});

Then("the command will fail", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    false,
    "Expected failure but the command succeeded"
  );
});

Then("the output will contain {string}", function (this: LwsWorld, expected: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    actualOutput.includes(expected),
    `Expected output to contain "${expected}" but got: ${actualOutput}`
  );
});

Then(
  "the output will contain an IAM access denied error",
  function (this: LwsWorld) {
    const actualOutput = JSON.stringify(this.lastResult.output);
    // Check for access denied indicators in JSON or check for 403 status code (e.g. S3 returns XML that the SDK wraps without name)
    const hasAccessDenied =
      actualOutput.includes("AccessDeniedException") ||
      actualOutput.includes("AccessDenied") ||
      actualOutput.includes("access denied") ||
      actualOutput.includes("NotAuthorizedException") ||
      (this.lastResult.success === false &&
        (actualOutput.includes('"httpStatusCode":403') ||
         actualOutput.includes('"httpStatusCode": 403')));
    assert.ok(
      hasAccessDenied,
      `Expected IAM access denied error but got: ${actualOutput}`
    );
  }
);

Then(
  "the output will not contain an IAM access denied error",
  function (this: LwsWorld) {
    const actualOutput = JSON.stringify(this.lastResult.output);
    const hasAccessDenied =
      actualOutput.includes("AccessDeniedException") ||
      (actualOutput.includes("AccessDenied") && !actualOutput.includes("NotAccessDenied"));
    assert.ok(
      !hasAccessDenied,
      `Expected no IAM access denied error but got: ${actualOutput}`
    );
  }
);

Then(
  "the output will contain a JSON chaos error",
  function (this: LwsWorld) {
    const actualOutput = JSON.stringify(this.lastResult.output);
    const hasChaosMark =
      actualOutput.includes("__type") ||
      actualOutput.includes("InternalFailure") ||
      actualOutput.includes("ServiceUnavailable") ||
      actualOutput.includes("chaos") ||
      this.lastResult.success === false;
    assert.ok(
      hasChaosMark,
      `Expected JSON chaos error but got: ${actualOutput}`
    );
  }
);

Then(
  "the output will contain an XML chaos error",
  function (this: LwsWorld) {
    const actualOutput = JSON.stringify(this.lastResult.output);
    const hasChaosMark =
      actualOutput.includes("ErrorResponse") ||
      actualOutput.includes("Error") ||
      actualOutput.includes("InternalError") ||
      actualOutput.includes("ServiceUnavailable") ||
      this.lastResult.success === false;
    assert.ok(
      hasChaosMark,
      `Expected XML chaos error but got: ${actualOutput}`
    );
  }
);

Then(
  "the output will contain an S3 XML chaos error",
  function (this: LwsWorld) {
    const actualOutput = JSON.stringify(this.lastResult.output);
    const hasChaosMark =
      actualOutput.includes("Error") ||
      actualOutput.includes("InternalError") ||
      actualOutput.includes("ServiceUnavailable") ||
      this.lastResult.success === false;
    assert.ok(
      hasChaosMark,
      `Expected S3 XML chaos error but got: ${actualOutput}`
    );
  }
);

Then(
  "the call will have taken at least {int} milliseconds",
  function (this: LwsWorld, minMs: number) {
    assert.ok(
      this.timedResult.elapsedMs >= minMs,
      `Expected call to take at least ${minMs}ms but took ${this.timedResult.elapsedMs}ms`
    );
  }
);
