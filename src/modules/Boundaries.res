let isRightBoundary = (cellId) => {
  mod(cellId, Game.width) == 7
}

let isLeftBoundary = (cellId) => {
  mod(cellId, Game.width) == 0
}

let isBoundary = (cellId) => {
  isRightBoundary(cellId) || isLeftBoundary(cellId)
}

let rec crossesHorizontalBoundary = (start, end) => {
  if end - start == 0 {
    false
  } else if isLeftBoundary(start) || isRightBoundary(start) {
    true
  } else {
    crossesHorizontalBoundary(start + 1, end)
  }
}

let isInBounds = (id) => id >= 0 && id < Game.area
