import { SignJWT, generateKeyPair as joseGenerateKeyPair } from "jose";
import type { KeyLike } from "jose";

export type { KeyLike };

export async function generatePoolKeys(): Promise<{ privateKey: KeyLike; publicKey: KeyLike }> {
  const { privateKey, publicKey } = await joseGenerateKeyPair("RS256");
  return { privateKey, publicKey };
}

export async function signAccessToken(
  privateKey: KeyLike,
  opts: {
    sub: string;
    username: string;
    poolId: string;
    clientId: string;
    issuer: string;
  },
): Promise<string> {
  return new SignJWT({
    sub: opts.sub,
    username: opts.username,
    client_id: opts.clientId,
    token_use: "access",
  })
    .setProtectedHeader({ alg: "RS256" })
    .setIssuer(opts.issuer)
    .setIssuedAt()
    .setExpirationTime("1h")
    .sign(privateKey);
}

export async function signIdToken(
  privateKey: KeyLike,
  opts: {
    sub: string;
    username: string;
    email?: string;
    poolId: string;
    clientId: string;
    issuer: string;
  },
): Promise<string> {
  const payload: Record<string, unknown> = {
    sub: opts.sub,
    "cognito:username": opts.username,
    aud: opts.clientId,
    token_use: "id",
  };
  if (opts.email !== undefined) {
    payload["email"] = opts.email;
  }
  return new SignJWT(payload)
    .setProtectedHeader({ alg: "RS256" })
    .setIssuer(opts.issuer)
    .setIssuedAt()
    .setExpirationTime("1h")
    .sign(privateKey);
}
