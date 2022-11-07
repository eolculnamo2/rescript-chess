type bishopDirection = TopLeft | TopRight | BottomLeft | BottomRight

let rec getOptionsByDirection = (~moveOptions=[], id, team, cells, direction: bishopDirection) => {
  let nextId = switch direction {
  | TopLeft => id - Game.width - 1
  | TopRight => id - Game.width + 1
  | BottomLeft => id + Game.width - 1
  | BottomRight => id + Game.width + 1
  }
  let isOutOfBounds = nextId > Game.area || nextId < 0
  let isBoundaryExceptInitialId = Boundaries.isBoundary(id) && Belt.Array.length(moveOptions) > 0
  let initialIdStops =
    Belt.Array.length(moveOptions) == 0 &&
      switch direction {
      | TopLeft | BottomLeft => Boundaries.isLeftBoundary(id)
      | TopRight | BottomRight => Boundaries.isRightBoundary(id)
      }
  if isOutOfBounds || isBoundaryExceptInitialId || initialIdStops {
    moveOptions
  } else {
    let isOppositeTeam = Utils.checkOppositeTeam(id, cells, team)
    if isOppositeTeam {
      moveOptions
    } else {
      let nextCell = switch cells->Belt.Array.get(nextId) {
      | Some(c) => c
      | None =>
        raise(
          Utils.CellNotFound(
            `Next cell not found in getOptionsByDirection at id ${nextId->Belt.Int.toString}`,
          ),
        )
      }
      switch Utils.getTeamFromPieceType(nextCell.pieceType) {
      | Some(t) if t == team => moveOptions
      | Some(_) | None =>
        getOptionsByDirection(
          ~moveOptions=moveOptions->Belt.Array.concat([nextId]),
          nextId,
          team,
          cells,
          direction,
        )
      }
    }
  }
}
let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  Belt.Array.concatMany([
    getOptionsByDirection(id, team, cells, TopLeft),
    getOptionsByDirection(id, team, cells, TopRight),
    getOptionsByDirection(id, team, cells, BottomLeft),
    getOptionsByDirection(id, team, cells, BottomRight),
  ])
}
@react.component
let make = (~team: Game.team, ~turn) => {
  <Piece
    image={switch team {
    | White => "/images/white_bishop.png"
    | Black => "/images/black_bishop.png"
    }}
    pieceName="Bishop"
    turn
  />
}
