import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
const data = input.split("\n");

let joltage = 0;

data.forEach((line) => {
	/** @type {number[]} */
	const bank = [];

	const remainingBatteries = line.split("").map(Number);
	while (remainingBatteries.length > 0) {
		const battery = remainingBatteries.shift();
		while (
			bank.length > 0 &&
			battery > bank.at(-1) &&
			bank.length + remainingBatteries.length > 11
		) {
			bank.pop();
		}
		if (bank.length < 12) {
			bank.push(battery);
		}
	}

	joltage += Number(bank.join(""));
});

console.log("Joltage:", joltage);
