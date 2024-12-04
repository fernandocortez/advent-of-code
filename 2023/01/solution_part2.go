package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	// f, err := os.Open("test_input_2.txt")
	f, err := os.Open("puzzle_input.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer f.Close()

	sum := 0
	s := bufio.NewScanner(f)
	for s.Scan() {
		sum += process_line(s.Text())
	}
	fmt.Println(sum)
}

func process_line(line string) int {
	trimmed_line := strings.TrimSpace(line)
	if len(trimmed_line) == 0 {
		return 0
	}

	var tens int
	var ones int
	var tens_index int = len(trimmed_line) - 1
	var ones_index int = 0

	digits := []string{
		"1", "2", "3", "4", "5", "6", "7", "8", "9",
	}
	for index, value := range digits {
		var idx int
		idx = strings.Index(trimmed_line, value)
		if idx >= 0 && idx <= tens_index {
			tens_index = idx
			tens = index + 1
		}
		idx = strings.LastIndex(trimmed_line, value)
		if idx >= 0 && idx >= ones_index {
			ones_index = idx
			ones = index + 1
		}
	}

	digits_as_words := []string{
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
	}
	for index, value := range digits_as_words {
		var idx int
		idx = strings.Index(trimmed_line, value)
		if idx >= 0 && idx <= tens_index {
			tens_index = idx
			tens = index + 1
		}
		idx = strings.LastIndex(trimmed_line, value)
		if idx >= 0 && idx >= ones_index {
			ones_index = idx
			ones = index + 1
		}
	}

	return tens*10 + ones
}
