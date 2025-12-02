import fs from "node:fs/promises";

/** @type {string} */
const data = await fs.readFile("./input.txt", "utf-8");
/** @type {[number, number][]} */
const ranges = data.split(",").map((range) => range.split("-").map(Number));

/** @type {number[]} */
const invalidIds = [];
ranges.forEach((range) => {
	const [start, end] = range;
	let curr = start;
	while (curr <= end) {
		const forInspection = curr.toString();
		const length = forInspection.length;
		const index = Math.floor(length / 2);
		if (forInspection.substring(0, index) === forInspection.substring(index)) {
			invalidIds.push(curr);
		}
		curr++;
	}
});

const sum = invalidIds.reduce((acc, curr) => acc + curr, 0);
console.log("Sum:", sum);
