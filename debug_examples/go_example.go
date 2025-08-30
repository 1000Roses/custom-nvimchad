package main

import "fmt"

func fibonacci(n int) int {
	// Set a breakpoint here with <leader>db
	if n <= 1 {
		return n
	}
	return fibonacci(n-1) + fibonacci(n-2)
}

func main() {
	fmt.Println("Go Debugging Example")
	
	// Set a breakpoint here with <leader>db
	numbers := []int{5, 8, 10}
	
	for _, num := range numbers {
		result := fibonacci(num)
		fmt.Printf("Fibonacci(%d) = %d\n", num, result)
	}
	
	// Another good breakpoint location
	fmt.Println("Debugging complete!")
}