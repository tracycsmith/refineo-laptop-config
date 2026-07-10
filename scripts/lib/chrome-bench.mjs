// scripts/lib/chrome-bench.mjs
/**
 * @file chrome-bench.mjs
 * @description Drives installed Chrome through Speedometer 3 headlessly and
 *              prints the score. Run via: npx -y -p puppeteer-core node chrome-bench.mjs
 */
import puppeteer from 'puppeteer-core';

const CHROME = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
const URL = 'https://browserbench.org/Speedometer3.0/?startAutomatically=true';

const browser = await puppeteer.launch({
  executablePath: CHROME,
  headless: 'new',
  args: ['--no-first-run', '--disable-extensions'],
});
try {
  const page = await browser.newPage();
  await page.goto(URL, { waitUntil: 'networkidle2', timeout: 60_000 });
  await page.waitForFunction(
    () => document.querySelector('#result-number')?.textContent?.trim().length > 0,
    { timeout: 600_000, polling: 2_000 },
  );
  const score = await page.$eval('#result-number', el => el.textContent.trim());
  const conf = await page.$eval('#confidence-number', el => el.textContent.trim()).catch(() => '');
  console.log(`SPEEDOMETER3_SCORE=${score}`);
  if (conf) console.log(`SPEEDOMETER3_CONFIDENCE=${conf}`);
} finally {
  await browser.close();
}
