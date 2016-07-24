# Minesweeper

Created a ruby implementation of the game [Minesweeper][play-minesweeper] ([wiki][minesweeper-wiki]).

`ruby lib/minesweeper.rb`

[play-minesweeper]: http://minesweeperonline.com/#beginner
[minesweeper-wiki]: http://en.wikipedia.org/wiki/Minesweeper_(Windows)

<strong>To-do-list:</strong>

- [x] prevent user from entering incorrect formats
- [x] colorize numbers and grid to match real game
- [x] fill number of adjacent bombs to each tile even if it is face-down, so game-over rendering works
- [ ] add save/load feature (needs to work for multiple levels)
- [ ] integrate emojis
- [ ] modify specs
- [ ] rendering is slow for hard level, need to refactor
