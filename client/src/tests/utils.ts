import { flushPromises } from '@vue/test-utils';

export const assert = (assertionFn: () => void) => {
    return new Promise(async (resolve:  (value?: unknown) => void) => {
      const tryAgain = async (resolve: (value?: unknown) => void) => {
        await flushPromises();
        try {
          assertionFn();
          resolve();
        } catch (err) {
          tryAgain(resolve);
        }
      };
  
      tryAgain(resolve);
    });
  };