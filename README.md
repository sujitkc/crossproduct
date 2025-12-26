# What is This?
This is a simple OCaml implementation of the cross product algorithm using
two approaches. One is the recursive approach, the other is using a counter.
The code illustrates the power of functional programming in OCaml. It also
uses functors to create reusable and generic modules.

# Instruction for use
` ocaml cross.ml `

# Output
```
{
  [1, 4, 6],
  [1, 4, 7],
  [1, 4, 8],
  [1, 4, 9],
  [1, 5, 6],
  [1, 5, 7],
  [1, 5, 8],
  [1, 5, 9],
  [2, 4, 6],
  [2, 4, 7],
  [2, 4, 8],
  [2, 4, 9],
  [2, 5, 6],
  [2, 5, 7],
  [2, 5, 8],
  [2, 5, 9],
  [3, 4, 6],
  [3, 4, 7],
  [3, 4, 8],
  [3, 4, 9],
  [3, 5, 6],
  [3, 5, 7],
  [3, 5, 8],
  [3, 5, 9]
}
{
  [one, five, eight],
  [one, five, nine],
  [one, five, seven],
  [one, five, six],
  [one, four, eight],
  [one, four, nine],
  [one, four, seven],
  [one, four, six],
  [three, five, eight],
  [three, five, nine],
  [three, five, seven],
  [three, five, six],
  [three, four, eight],
  [three, four, nine],
  [three, four, seven],
  [three, four, six],
  [two, five, eight],
  [two, five, nine],
  [two, five, seven],
  [two, five, six],
  [two, four, eight],
  [two, four, nine],
  [two, four, seven],
  [two, four, six]
}
{
  [1, 4, 6],
  [1, 4, 7],
  [1, 4, 8],
  [1, 4, 9],
  [1, 5, 6],
  [1, 5, 7],
  [1, 5, 8],
  [1, 5, 9],
  [2, 4, 6],
  [2, 4, 7],
  [2, 4, 8],
  [2, 4, 9],
  [2, 5, 6],
  [2, 5, 7],
  [2, 5, 8],
  [2, 5, 9],
  [3, 4, 6],
  [3, 4, 7],
  [3, 4, 8],
  [3, 4, 9],
  [3, 5, 6],
  [3, 5, 7],
  [3, 5, 8],
  [3, 5, 9]
}
{
  [one, five, eight],
  [one, five, nine],
  [one, five, seven],
  [one, five, six],
  [one, four, eight],
  [one, four, nine],
  [one, four, seven],
  [one, four, six],
  [three, five, eight],
  [three, five, nine],
  [three, five, seven],
  [three, five, six],
  [three, four, eight],
  [three, four, nine],
  [three, four, seven],
  [three, four, six],
  [two, five, eight],
  [two, five, nine],
  [two, five, seven],
  [two, five, six],
  [two, four, eight],
  [two, four, nine],
  [two, four, seven],
  [two, four, six]
}
```
