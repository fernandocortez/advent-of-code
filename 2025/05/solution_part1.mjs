import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");

/** @type {[number, number][]} */
const freshIngredientIdRanges = [];
/** @type {Map<number, boolean>} */
const isFreshByIngredientId = new Map();

input.split("\n").forEach((line) => {
	if (/^\d+-\d+$/.test(line)) {
		freshIngredientIdRanges.push(line.split("-").map(Number));
	} else if (/^\d+$/.test(line)) {
		isFreshByIngredientId.set(Number(line), false);
	}
});

isFreshByIngredientId.keys().forEach((id) => {
	freshIngredientIdRanges.forEach(([start, end]) => {
		if (id >= start && id <= end) {
			isFreshByIngredientId.set(id, true);
		}
	});
});

const freshIngredientsCount = Array.from(isFreshByIngredientId.values()).reduce(
	(sum, isFresh) => (isFresh ? sum + 1 : sum),
	0,
);
console.log("Fresh ingredients count:", freshIngredientsCount);
