import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");

/** @type {[number, number][]} */
const freshIngredientIdRanges = input
	.split("\n")
	.filter((line) => /^\d+-\d+$/.test(line))
	.map((line) => line.split("-").map(Number))
	.toSorted((a, b) => a[0] - b[0])
	.reduce((acc, curr) => {
		const index = acc.length;

		if (index === 0) {
			acc.push(curr);
			return acc;
		}

		const prev = acc[index - 1];
		if (curr[0] <= prev[1]) {
			prev[1] = Math.max(curr[1], prev[1]);
		} else {
			acc.push(curr);
		}
		return acc;
	}, []);

const count = freshIngredientIdRanges.reduce((acc, [start, end]) => {
	return acc + end - start + 1;
}, 0);
console.log("Fresh ingredients count:", count);
