import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");

const mathHomework = input
	.split("\n")
	.map((line) => line.split(" "))
	.map((line) => line.filter((char) => char.length > 0))
	.map((line) =>
		line.map((char) => (/^\d+$/.test(char) ? Number(char) : char)),
	);

// switch data to be arranged into rows instead of columns
const mathHomeworkProblems = Array.from(
	{ length: mathHomework[0].length },
	() => [],
);
mathHomework.forEach((row) => {
	row.forEach((col, colIdx) => {
		mathHomeworkProblems[colIdx].push(col);
	});
});
const solvedProblems = mathHomeworkProblems.map((problem) => {
	const operation = problem.pop();
	if (operation === "+") {
		return problem.reduce((acc, curr) => acc + curr, 0);
	} else if (operation === "*") {
		return problem.reduce((acc, curr) => acc * curr, 1);
	}
	throw new Error(`Unhandled math operation: ${operation}`);
});

const grandTotal = solvedProblems.reduce((acc, curr) => acc + curr, 0);
console.log("Grand total:", grandTotal);
