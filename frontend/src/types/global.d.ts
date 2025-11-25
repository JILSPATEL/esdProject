export {};

declare global {
  interface Window {
    google?: {
      accounts: {
        id: {
          initialize: (config: google.accounts.id.IdConfiguration) => void;
          renderButton: (
            parent: HTMLElement,
            options: google.accounts.id.GsiButtonConfiguration,
          ) => void;
        };
      };
    };
  }
}

