import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
/** @type {string[][]} */
const data = input.split("\n").map((range) => range.split(""));

const getAdjacentSubGrid = ((grid) => {
	const MIN_GRID_ROW_INDEX = 0;
	const MAX_GRID_ROW_INDEX = grid.length - 1;
	const MIN_GRID_COLUMN_INDEX = 0;
	const MAX_GRID_COLUMN_INDEX = grid[0].length - 1;

	/**
	 * @param {number} rowIdx
	 * @param {number} colIdx
	 */
	return (rowIdx, colIdx) => {
		const prevRowIdx = rowIdx > MIN_GRID_ROW_INDEX ? rowIdx - 1 : undefined;
		const nextRowxIdx =
			rowIdx < MAX_GRID_ROW_INDEX ? rowIdx + 1 : undefined;
		const prevColIdx =
			colIdx > MIN_GRID_COLUMN_INDEX ? colIdx - 1 : undefined;
		const nextColIdx =
			colIdx < MAX_GRID_COLUMN_INDEX ? colIdx + 1 : undefined;

		return [
			[prevRowIdx, prevColIdx],
			[prevRowIdx, colIdx],
			[prevRowIdx, nextColIdx],
			[rowIdx, prevColIdx],
			[rowIdx, nextColIdx],
			[nextRowxIdx, prevColIdx],
			[nextRowxIdx, colIdx],
			[nextRowxIdx, nextColIdx],
		].reduce((acc, [rowIndex, columnIndex]) => {
			if (
				typeof rowIndex === "number" &&
				typeof columnIndex === "number"
			) {
				acc.push(grid[rowIndex][columnIndex]);
			}
			return acc;
		}, []);
	};
})(data);

let sum = 0;
data.forEach((row, rowIdx) => {
	row.forEach((char, colIdx) => {
		if (char === "@") {
			const adjacentSubGrid = getAdjacentSubGrid(rowIdx, colIdx);
			if (adjacentSubGrid.filter((char) => char === "@").length < 4) {
				sum++;
			}
		}
	});
});
console.log("Accessible paper rolls:", sum);
