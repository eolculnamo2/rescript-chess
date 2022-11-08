let state: Game.boardState = {
  cells: Init.Cells.make(),
  turn: Game.White,
  winner: None,
}

type actions = CellClicked(int)
let reducer = (state: Game.boardState, action) => {
  switch action {
  | CellClicked(id) =>
    if Belt.Option.isNone(state.winner) {
      CellClick.make(state, id)
    } else {
      state
    }
  }
}

let boardWidth = Belt.Int.toString(Game.width * Game.cellSize) ++ "px"
@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, state)

  <>
    {<h2>
      {switch state.winner {
      | Some(Game.White) => "White wins!"
      | Some(Game.Black) => "Black wins!"
      | None => ""
      }->React.string}
    </h2>}
    <div
      style={ReactDOM.Style.make(
        ~marginBottom="2rem",
        ~display="flex",
        ~justifyContent="center",
        (),
      )}>
      <div
        style={ReactDOM.Style.make(
          ~border="4px solid black",
          ~transform=`rotate(${state.turn == Game.Black ? "180deg" : "0"})`,
          ~transition="all ease-in-out 1s",
          ~display="flex",
          ~flexWrap="wrap",
          ~maxWidth={boardWidth},
          (),
        )}>
        {state.cells
        ->Belt.Array.mapWithIndex((i, cell) => {
          <Cell
            handleClick={id => {
              dispatch(CellClicked(id))
            }}
            key={"cell" ++ Belt.Int.toString(i)}
            cell
            turn={state.turn}
          />
        })
        ->React.array}
      </div>
    </div>
  </>
}
