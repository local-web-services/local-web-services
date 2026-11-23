import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { CognitoIdentityProviderClient } from "@aws-sdk/client-cognito-identity-provider";
import { makeSession } from "./world.js";
import type { CognitoWorld } from "./world.js";

let sharedSession = makeSession();
let sharedCognitoClient: CognitoIdentityProviderClient | null = null;

BeforeAll(async function () {
  await sharedSession.start();
  sharedCognitoClient = new CognitoIdentityProviderClient(sharedSession.clientConfig("cognito-idp"));
});

AfterAll(async function () {
  await sharedSession.stop();
});

Before(async function (this: CognitoWorld) {
  if (sharedCognitoClient === null) throw new Error("Cognito session not initialized");
  this.session = sharedSession;
  this.cognitoClient = sharedCognitoClient;
  this.poolId = "";
  this.clientId = "";
  this.accessToken = "";
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: CognitoWorld) {
  this.error = null;
  this.result = null;
});
