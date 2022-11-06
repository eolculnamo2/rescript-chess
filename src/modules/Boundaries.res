let isRightBoundary = (cellId) => {
  mod(cellId, Game.width) == 7
}

let isLeftBoundary = (cellId) => {
  mod(cellId, Game.width) == 0
}
