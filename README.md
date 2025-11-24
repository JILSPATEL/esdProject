# Billing System (ESD Project)

## Google OAuth-Only Login

1. Create an OAuth 2.0 Client ID (Web) inside the Google Cloud console and add the frontend origin plus redirect URIs (already done for the default client).
2. Copy the generated Client ID/Secret and set `spring.security.oauth2.client.registration.google.client-id` and `.client-secret` in `src/main/resources/application.properties` (or override via environment variables). The mapper also reads the client ID to validate Google ID tokens.
3. On the frontend, use [Google Identity Services](https://developers.google.com/identity/gsi/web) to obtain an ID token (the `credential`) after the user picks their Google account.
4. Send that credential to the backend:

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"credential\": \"<GOOGLE_ID_TOKEN>\"}"
```

If the email embedded in the credential matches a row in the `students` table, the API returns the existing JWT response that can be used for the rest of the application.