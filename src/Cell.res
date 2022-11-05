
let getBgColor = (id, cellState) => {
  if cellState == Game.Selected {
    "#AEB888"
  } else if cellState == Game.MovePreview {
    "#B89A88"
  } else {
    let isEvenRow = mod(id / 8, 2) == 0

    let isBlack =
      mod(id, 2) ==
        switch isEvenRow {
        | true => 1
        | false => 0
        }
    isBlack ? "#777" : "#dadada"
  }
}

@react.component
let make = (~cell: Game.cell, ~handleClick) => {
  <div
    onClick={_ => handleClick(cell.id)}
    style={ReactDOM.Style.make(
      ~width={Game.cellSizePx},
      ~height={Game.cellSizePx},
      ~backgroundColor=getBgColor(cell.id, cell.cellState),
      ~display="grid",
      ~placeItems="center",
      (),
    )}>
    {switch cell.pieceType {
    | Game.Blank => <> /* {cell.id->Belt.Int.toString->React.string} */ </>
    | Game.PawnCell(team) => <Pawn team />
    | Game.RookCell(team) => <Rook team />
    | Game.KnightCell(team) => <Knight team />
    | Game.BishopCell(team) => <Bishop team />
    | Game.KingCell(team) => <King team />
    | Game.QueenCell(team) => <Queen team />
    }}
  </div>
}
