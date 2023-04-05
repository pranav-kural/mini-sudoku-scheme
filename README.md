# Mini Sudoku Scheme

A program implemented in scheme programming language to verify validity of a given 4x4 sudoku

<img width="124" alt="image" src="https://user-images.githubusercontent.com/17651852/229974071-9768b2e6-8892-4f9a-aabb-4b457f003e92.png">

A mini-sudoku is an array of 4x4 in which each entry is one of the four numbers 1,2,3,4. To be a valid Sudoku, each row, each column, and each of the four quadrants must contain different numbers (as shown in the figure above)

## Usage

Running the program by default executed the `checkSudoku` function on two sample hard-coded sudoku lists.

You can also manually provide a sudoku and set DEBUG mode to check validity of a sudoku list.

```scheme
; Provide sudoku as first argument, and #t or #f for DEBUG mode
(run '((2 1 4 3) (4 3 2 1) (1 2 3 4) (3 4 1 2)) #f)
```

### Note
Feel free to use the code, but if using for school, please make sure you understand the consequences of using code from external sources for your schoolwork. 
