#!/usr/bin/env python3

def fibonacci(n):
    """Calculate fibonacci number recursively"""
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

def main():
    print("Python Debugging Example")
    
    # Set a breakpoint here with <leader>db
    numbers = [5, 8, 10]
    
    for num in numbers:
        result = fibonacci(num)
        print(f"Fibonacci({num}) = {result}")
    
    # Another good breakpoint location
    print("Debugging complete!")

if __name__ == "__main__":
    main()