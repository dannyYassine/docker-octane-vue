import { test, expect } from '@playwright/test';

test('loads the app', async ({ page }) => {
  await page.goto('http://localhost:3000');

  await expect(page).toHaveURL(/localhost:3000/);
});